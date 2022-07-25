import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultme/Bloc/consultantBloc/cubit/consultant_states.dart';
import 'package:consultme/components/components.dart';
import 'package:consultme/const.dart';
import 'package:consultme/models/AppoinmentModel.dart';
import 'package:consultme/models/ConsultantModel.dart';
import 'package:consultme/models/MessageModel.dart';
import 'package:consultme/models/UserModel.dart';
import 'package:consultme/models/complaintsModel.dart';
import 'package:consultme/models/PostModel.dart';
import 'package:consultme/shard/network/local/cache_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../../models/callerhandshakeModel.dart';

class ConsultantCubit extends Cubit<ConsultantStates> {
  ConsultantCubit() : super(ConsultantInitialState());

  static ConsultantCubit get(context) => BlocProvider.of(context);

  ConsultantModel? consultantModel;
  String uId = CacheHelper.getData(key: "uId");

  void getConsultantData() {
    print('----------get Consultant Data----------');
    emit(GetProfileConsultantLoadingStates());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      print(value.data());
      consultantModel = ConsultantModel.fromJson(value.data());
      emit(GetProfileConsultantSuccessStates());
    }).catchError((error) {
      print(error.toString());
      emit(GetProfileConsultantErrorStates(error.toString()));
    });
  }

  void postComplaints({
    required String complaints,
    required String email,
    required String name,
    required userType,
  }) {
    emit(PostComplaintsLoadingStates());

    ComplaintModel complaintModel = ComplaintModel(
      name: name,
      email: email,
      complaint: complaints,
      userType: userType,
    );

    FirebaseFirestore.instance
        .collection('complaints')
        .doc(uId)
        .set(complaintModel.toMap())
        .then((value) => {
              print('Complaint sended '),
            })
        .then(
      (value) {
        emit(PostComplaintsSuccessStates());
      },
    ).catchError((error) {
      print(error.toString());
      emit(PostComplaintsErrorStates(error));
    });
  }

  var picker = ImagePicker();
  File? postImage;

  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(PostImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(PostImagePickedErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(ImageRemoveSuccessState());
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
    required String title,
  }) {
    emit(CreatePostLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createPost(
          text: text,
          title: title,
          dateTime: dateTime,
          postImage: value,
        );
      }).catchError((error) {
        emit(CreatePostErrorState(error));
      });
    }).catchError((error) {
      emit(CreatePostErrorState(error));
    });
  }

  PostModel? postModel;

  void createPost({
    required String dateTime,
    required String text,
    required String title,
    String? postImage,
  }) {
    emit(CreatePostLoadingState());

    PostModel model = PostModel(
      name: consultantModel?.name,
      image: consultantModel?.image,
      uid: consultantModel?.uid,
      dateTime: dateTime,
      title: title,
      text: text,
      postImage: postImage,
      postID: null,
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) => {
    print("posts ceateted"),
    FirebaseFirestore.instance
        .collection('posts')
        .doc(value.id)
        .update({'postID': value.id})
        .then((value) => {
      emit(CreatePostSuccessState()),
    })
    }).catchError((error) {
      emit(CreatePostErrorState(error.toString()));
    });
  }

  List<PostModel> posts = [];
  List<String> postsId = [];

  void getPosts() {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      posts = [];
      value.docs.forEach((element) {
        if (element.data()['uid'] == consultantModel!.uid) {
          postsId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        }
      });

      emit(GetPostsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetPostsErrorState(error.toString()));
    });
  }

  void DeletePost(id) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(id)
        .delete()
        .then((value) {
      emit(DeletePostSuccessState());
      showToast(message: 'تم حذف المنشور بنجاح', state: ToastStates.SUCCESS);
      getPosts();
    }).catchError((error) {
      print(error.toString());
      emit(DeletePostErrorState());
      showToast(
          message: 'حدث خطأ ما, برجاء المحاولة في وقت لاحق',
          state: ToastStates.ERROR);
    });
  }

  File? profileImage;

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

  void upDateConsultant(
      {required name, required phone, required email, required depatment, required bio}) {
    emit(LoadingUpdateConsultantInfo());
    if (profileImageUrl != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(consultantModel!.uid)
          .update({
            'email': email,
            'name': name,
            'phone': phone,
            'department': depatment,
            'bio' : bio
          })
          .then((value) => {
                emit(UpdateConsultantInfoScusses()),
                getConsultantData(),
                showToast(
                    message: 'تم التعديل بنجاح', state: ToastStates.SUCCESS),
              })
          .catchError((onError) {
            emit(ErrorWithUpdateConsultant());
            showToast(
                message: 'حدث خطأ يرجى إعادة المحاولة',
                state: ToastStates.ERROR);
          });
    } else {
      FirebaseFirestore.instance
          .collection('users')
          .doc(consultantModel!.uid)
          .update({
            'email': email,
            'name': name,
            'phone': phone,
            'department': depatment,
            'bio' : bio
      })
          .then((value) => {
                emit(UpdateConsultantInfoScusses()),
                getConsultantData(),
                showToast(
                    message: 'تم التعديل بنجاح', state: ToastStates.SUCCESS),
              })
          .catchError((onError) {
            emit(ErrorWithUpdateConsultant());
            showToast(
                message: 'حدث خطأ يرجى إعادة المحاولة',
                state: ToastStates.ERROR);
          });
    }
  }

  List<AppointmentModel>? appointments = [];

  void getAppoinments() {
    FirebaseFirestore.instance.collection('appointments').get().then((value) {
      appointments = [];
      value.docs.forEach((element) {
        if (element.data()['consultId'] == consultantModel!.uid) {
          appointments!.add(AppointmentModel.fromJson(element.data()));
        }
      });

      emit(GetAppointmentsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetAppointmentsErrorState(error.toString()));
    });
  }

  double animatedWaitingStudentHeight = 0.0;
  bool showWaitingStudent_details = false;
  int currentWaitingStudentIndex = -1;
  void showWaitingStudentDetails(bool show, int index) {
    if (currentWaitingStudentIndex == index) {
      showWaitingStudent_details = show;
      animatedWaitingStudentHeight == 0.0
          ? animatedWaitingStudentHeight = 1000.0
          : animatedWaitingStudentHeight = 0.0;

      emit(ShowAppointmentDetails());
    }
  }

  bool showWarning = false;
  void showStudentWarning({
    required bool isLate,
  }) {
    showWarning = isLate;
    emit(SecurityShowWarningState());
  }

  void refusalAppointment({required AppointmentModel appoItem}) {
    FirebaseFirestore.instance
        .collection('appointments')
        .doc(appoItem.appoId)
        .update({
          'accept': false,
        })
        .then((value) => {
              print('Appointment Unaccepted '),
            })
        .then((value) {
          getAppoinments();
          emit(refusalAppointmentSuccessStates());
          showToast(message: 'تم رفض الطلب بنجاح', state: ToastStates.SUCCESS);
        })
        .catchError((error) {
          print(error);
          showToast(
              message: 'حدث خطأ ما, برجاء المحاوله في وقت لاحق',
              state: ToastStates.ERROR);
          emit(refusalAppointmentErrorStates(error.toString()));
        });
  }

  void acceptAppointment(
      {required String MeetTime, required AppointmentModel appoItem}) {
    FirebaseFirestore.instance
        .collection('appointments')
        .doc(appoItem.appoId)
        .update({
          'accept': true,
          'MeetTime': MeetTime,
        })
        .then((value) => {
              print('Appointment accepted '),
            })
        .then((value) {
          getAppoinments();
          emit(AcceptedAppointmentSuccessStates());
          showToast(message: 'تم القبول بنجاح', state: ToastStates.SUCCESS);
        })
        .catchError((error) {
          print(error);
          showToast(
              message: 'حدث خطأ ما, برجاء المحاوله في وقت لاحق',
              state: ToastStates.ERROR);
          emit(AcceptedAppointmentErrorStates(error.toString()));
        });
  }

  List<MessageModel> messages = [];

  void getMessages({
    required String userId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(consultantModel?.uid)
        .collection('chats')
        .doc(userId)
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
      senderId: consultantModel?.uid,
      receiverId: receiverId,
      dateTime: dateTime,
    );

    // set my chats

    FirebaseFirestore.instance
        .collection('users')
        .doc(consultantModel?.uid)
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
        .doc(consultantModel?.uid)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });
  }

  List<UserModel> usersInChat = [];

  getUsersChat() {
    getAppoinments();
    usersInChat = [];
    appointments!.forEach((element) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((user) {
          if (user.data()['uid'] == element.userID && element.accept == true) {
            usersInChat.add(UserModel.fromJson(user.data()));
          }
        });
        emit(GetAllChatSuccessState(usersInChat));
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

  sendNotfiy(String title, String body, String Token , String type ,[String? RTCtoken]) async {
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
            'consultId' : consultantModel!.uid,
            'RTCtoken' : RTCtoken,
          },
          'to': Token,
        },
      ),
    );
  }

  UserModel? user;
  getUserById(userId){
    FirebaseFirestore.instance.collection('users').doc(userId).get().then((value) {
      user = UserModel.fromJson(value.data());
    });
  }
}
