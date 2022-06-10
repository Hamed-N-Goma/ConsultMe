import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultme/Bloc/consultantBloc/cubit/consultant_states.dart';
import 'package:consultme/components/components.dart';
import 'package:consultme/models/ConsultantModel.dart';
import 'package:consultme/models/complaintsModel.dart';
import 'package:consultme/models/PostModel.dart';
import 'package:consultme/shard/network/local/cache_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

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
      consultantModel = ConsultantModel.fromJson(value.data()!);
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
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(CreatePostSuccessState());
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
}
