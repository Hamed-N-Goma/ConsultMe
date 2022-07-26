import 'dart:convert';
import 'dart:io';
import 'package:consultme/models/callerhandshakeModel.dart';
import 'package:consultme/models/ratingModel.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultme/components/components.dart';
import 'package:consultme/const.dart';
import 'package:consultme/models/AppoinmentModel.dart';
import 'package:consultme/models/UserModel.dart';
import 'package:consultme/models/categorymodel.dart';
import 'package:consultme/models/consultantmodel.dart';
import 'package:consultme/models/favoriteModel.dart';
import 'package:consultme/shard/network/local/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../../models/MessageModel.dart';
import '../../../models/PostModel.dart';

part 'userlayoutcubit_state.dart';

class UserLayoutCubit extends Cubit<UserLayoutState> {
  UserLayoutCubit() : super(UserlayoutcubitInitial());

  static UserLayoutCubit get(context) => BlocProvider.of(context);

  String uId = CacheHelper.getData(key: "uId");

  UserModel? userModel;
  List<ConsultantModel> conslutants = [];
  List<CategoryModel> categoryList = [];
  List<FavoriteModel> favoriteList = [];

  void GetUserInfo() {
    emit(GetDataLoading());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) => {
              userModel = UserModel.fromJson(value.data()!),
              emit(GetUserDataSucsses()),
            })
        .catchError((onError) {
      emit(ErrorWithGetUserData());
    });
  }

  File? profileImage;
  var picker = ImagePicker();

  Future getProfileImage() async {
    final PickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (PickedFile != null) {
      profileImage = File(PickedFile.path);
      print('pickedffile');
      emit(PickedProfileImageSucsses());
    } else {
      print('no image selected');
      emit(ErrorWithPickedProfileImage());
    }
  }

  String? profileImageUrl;

  Future<void> uploadProfile() async {
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child("users/${Uri.file(profileImage!.path).pathSegments.last}")
        .putFile(profileImage!)
        .then((value) => {
              value.ref
                  .getDownloadURL()
                  .then(
                    (value) => {
                      profileImageUrl = value.toString(),
                      print(profileImageUrl)
                    },
                  )
                  .catchError((error) {
                emit(ErrorWithUploadProfileimagge());
              })
            })
        .catchError((error) {
      emit(ErrorWithUploadProfileimagge());

      print(error.toString());
    });
  }

  void upDateUser({required name, required phone, required email}) {
    emit(LoadingUpdateUseInfo());
    if (profileImageUrl != null) {
      userModel = UserModel(
        email: email,
        name: name,
        phone: phone,
        userType: userModel!.userType,
        uid: userModel!.uid,
        image: profileImageUrl,
      );
      FirebaseFirestore.instance
          .collection('users')
          .doc(userModel!.uid)
          .update(userModel!.toMap())
          .then((value) => {
                emit(UpdateUserInfoScusses()),
                GetUserInfo(),
                showToast(
                    message: 'تم التعديل بنجاح', state: ToastStates.SUCCESS),
              })
          .catchError((onError) {
        emit(ErrorWithUpdateUser());
        showToast(
            message: 'حدث خطأ يرجى إعادة المحاولة', state: ToastStates.ERROR);
      });
    } else {
      userModel = UserModel(
        email: email,
        name: name,
        phone: phone,
        userType: userModel!.userType,
        uid: userModel!.uid,
        image: userModel!.image,
      );
      FirebaseFirestore.instance
          .collection('users')
          .doc(userModel!.uid)
          .update(userModel!.toMap())
          .then((value) => {
                emit(UpdateUserInfoScusses()),
                GetUserInfo(),
                showToast(
                    message: 'تم التعديل بنجاح', state: ToastStates.SUCCESS),
              })
          .catchError((onError) {
        emit(ErrorWithUpdateUser());
        showToast(
            message: 'حدث خطأ يرجى إعادة المحاولة', state: ToastStates.ERROR);
      });
    }
  }

  void getConsultants() {
    emit(LoadingConsultant());
    CollectionReference consultant =
        FirebaseFirestore.instance.collection('users');
    consultant.where('userType', isEqualTo: 'Consultant').get().then(
          (consultant) => {
            conslutants = consultant.docs
                .map((e) =>
                    ConsultantModel.fromJson(e.data() as Map<String, dynamic>))
                .toList(),
            emit(GetConsultanatDataSucsses(conslutants)),
            consultant.docs.forEach((element) {
              print(element.data());
              print("++++============================");
            })
          },
        );
  }

  void getCategory() {
    emit(LoadingCategory());
    CollectionReference category =
        FirebaseFirestore.instance.collection('Category');
    category.get().then((value) => {
          categoryList = value.docs
              .map((e) =>
                  CategoryModel.fromJson(e.data() as Map<String, dynamic>))
              .toList(),
          print('before emmmmmit'),
          emit(GetCategoryDataSucsses(categoryList)),
          print('after emmmmmit'),
        });
  }

  // edit profile screen
  bool isDark = false;

  void toggleButton() {
    isDark = !isDark;
    emit(ChangeThemeSuccessState());
  }

  AppointmentModel? appoinmentModel;

  void createAppoinment({
    required String consultId,
    required String resson,
    required String description,
    required String consultName,
    required String consultSp,
  }) {
    emit(CreateAppoinmentLoadingState());

    AppointmentModel model = AppointmentModel(
      consultId: consultId,
      consultName: consultName,
      consultSp: consultSp,
      resson: resson,
      userID: userModel!.uid,
      description: description,
      time: DateTime.now().toString(),
      userEmail: userModel!.email,
      userPhone: userModel!.phone,
      userName: userModel!.name,
      MeetTime: null,
      accept: null,
      appoId: null,
    );

    FirebaseFirestore.instance
        .collection('appointments')
        .add(model.toMap())
        .then((value) => {
              print("appointment ceateted"),
              FirebaseFirestore.instance
                  .collection('appointments')
                  .doc(value.id)
                  .update({'appoId': value.id})
                  .then((value) => {
                        emit(CreateAppoinmentSuccessState()),
                        showToast(
                            message: 'تم ارسال الطلب بنجاح',
                            state: ToastStates.SUCCESS)
                      })
                  .catchError((error) {
                    emit(CreateAppoinmentErrorState(error.toString()));
                    showToast(
                        message: 'حدث خطأ , يرجى إعادة المحاولة ',
                        state: ToastStates.ERROR);
                  })
            });
  }

  List<AppointmentModel>? appointments = [];

  void getAppoinments() {
    FirebaseFirestore.instance.collection('appointments').get().then((value) {
      appointments = [];
      value.docs.forEach((element) {
        if (element.data()['userID'] == userModel!.uid) {
          appointments!.add(AppointmentModel.fromJson(element.data()));
        }
      });
      emit(GetAppointmentsSuccessState());
      getConsultChat();
    }).catchError((error) {
      print(error.toString());
      emit(GetAppointmentsErrorState(error.toString()));
    });
  }

  List<MessageModel> messages = [];

  void getMessages({
    required String consultId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.uid)
        .collection('chats')
        .doc(consultId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];

      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      messages = messages .reversed.toList();
      emit(GetMessagesSuccessState());
    });
  }

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String content,
  }) {
    MessageModel model = MessageModel(
      content: content,
      senderId: userModel?.uid,
      receiverId: receiverId,
      dateTime: dateTime,
    );

    // set my chats

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });

    // set receiver chats

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel?.uid)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });
  }

  void postFavorite(String consultantid) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('favorite')
        .doc(consultantid)
        .set({'favoriteConsultant': consultantid})
        .then((value) => {
              emit(AddConsultantToFavoriteSucssesfuly()),
              getFavorite(),
            })
        .catchError((error) {
          emit(ErrorWithAddConsultantToFavoriteSucssesfuly(error.toString()));
        });
  }

  void getFavorite() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('favorite')
        .get()
        .then((value) => {
              favoriteList = value.docs
                  .map((e) => FavoriteModel.fronJson(e.data()))
                  .toList(),
              emit(GetConsultantToFavoriteSucssesfuly(favoriteList)),
              print("gettttttting favorite"),
              favoriteList.forEach((element) {
                print(element.favoriteConsultant.toString());
              })
            })
        .catchError((error) {
      emit(ErrorWithGetConsultantToFavoriteSucssesfuly(error));
    });
  }

  void deleteFavorite(String id) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('favorite')
        .doc(id)
        .delete()
        .then((value) => {
              print('getting sucssesfuly'),
              print('delete sucssesfuly'),
              emit(DeleteFromFavSucsses()),
              getFavorite(),
            })
        .catchError((error) {
      emit(ErrorWithDeleteFromFav(error.toString()));
    });
  }

  List<PostModel> posts = [];

  void getAllPosts() {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      posts = value.docs.map((e) => PostModel.fromJson(e.data())).toList();
      emit(GetAllPostsSuccessState(posts));
    }).catchError((error) {
      print(error.toString());
      emit(GetAllPostsErrorState(error.toString()));
    });
  }

  List<ConsultantModel> chats = [];

  getConsultChat() {
    chats = [];
    appointments!.forEach((element) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((consult) {
          if (consult.data()['uid'] == element.consultId &&
              element.accept == true) {
            chats.add(ConsultantModel.fromJson(consult.data()));
          }
        });
        emit(GetAllChatSuccessState(chats));
      }).catchError((error) {
        print(error.toString());
        emit(GetAllChatErrorState(error.toString()));
      });
    });
  }

  var token;
  String? getTokenById(String id) {
    FirebaseFirestore.instance.collection('users').doc(id).get().then((value) {
      token = value.data()!["token"];
    });
    return token;
  }


  sendNotfiy(String title, String body, String Token , String type) async {
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': body.toString(),
            'title': title.toString(),
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done',
            'type' : type,
            'userId' : userModel!.uid,

          },
          'to': Token,
        },
      ),
    );
  }

  var rating ;
  var ratingNumber;
  var sum;

  getrating(ConsultId) {
    rating = 0;
    ratingNumber = 0;
    sum = 0;
    FirebaseFirestore.instance
        .collection('users')
        .doc(ConsultId)
        .collection('rating')
        .get().then((value) {
      value.docs.forEach((user) {
        sum = sum + user.data()['rating'];
        ratingNumber++;
      });
      rating = (sum/ratingNumber);
      FirebaseFirestore.instance
          .collection('users')
          .doc(ConsultId).update({
        'rating': rating,
      });
      emit(GetRatingSucsses());
    }).catchError((error) {
      print(error.toString());
      emit(GetRatingError());
    });

  }

  //send rating

  sendRating({
    required double rating,
    required String sender,
    required String recever,
  }) {
    RatingModel ratingModel =
    RatingModel(rating: rating, sender: sender, recever: recever);
    FirebaseFirestore.instance
        .collection('users')
        .doc(recever)
        .collection('rating')
        .doc(sender)
        .set(ratingModel.tomap())
        .then((value) => {
      emit(SendRatingSucssesfuly()),
      getrating(recever),

    })
        .catchError((error) {
      emit(SendRatingError(error.toString()));
    });
  }

  ConsultantModel? consult;
  getConsultById(consultId){
    conslutants.forEach((element) {
      if (element.uid == consultId)
        consult = element ;
    });
  }
}
