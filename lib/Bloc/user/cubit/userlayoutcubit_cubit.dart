import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultme/models/consultantmodel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../../models/usermodel.dart';

part 'userlayoutcubit_state.dart';

class UserLayoutCubit extends Cubit<UserLayoutState> {
  UserLayoutCubit() : super(UserlayoutcubitInitial());

  static UserLayoutCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;
  List<ConsultantModel> conslutants = [];

  void GetUserInfo() {
    emit(GetDataLoading());
    FirebaseFirestore.instance
        .collection('users')
        .doc(
            'dl6Xzul3AjV9xkzjN8iDYZqEfjc2') //REPLACE THE DOC ID WITH SEAREDPREFRENCE UID
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
              })
          .catchError((onError) {
        emit(ErrorWithUpdateUser());
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
              })
          .catchError((onError) {
        emit(ErrorWithUpdateUser());
      });
    }
  }

  void getConsultants() async {
    CollectionReference consultant =
        FirebaseFirestore.instance.collection('users');
    await consultant.where('userType', isEqualTo: 'Consultant').get().then(
          (consultant) => {
            conslutants = consultant.docs
                .map((e) =>
                    ConsultantModel.fromJson(e.data() as Map<String, dynamic>))
                .toList(),
            emit(GitConsultantsDataSucsess(conslutants)),
            consultant.docs.forEach((element) {
              print(element.data());
              print("++++============================");
            })
          },
        );
  }
}
