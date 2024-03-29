import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultme/models/UserModel.dart';
import 'package:consultme/models/categorymodel.dart';
import 'package:consultme/moduls/signup/cubit/states.dart';
import 'package:consultme/presentation_layer/user/widget/category.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../../models/consultantmodel.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit() : super(signUpInitialStates());

  static SignUpCubit get(context) => BlocProvider.of(context);

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ChangePasswordVisibilityStates());
  }

  var buttonController = RoundedLoadingButtonController();

  void rotationPeriod() async {
    Timer(const Duration(milliseconds: 2000), () {
      buttonController.stop();
      emit(signUpRotationPeriodState());
    });
  }

  bool isConsultant = true;

  void changeIsReason(bool reason) {
    isConsultant = reason;
    emit(ChangeConsultantState());
  }

  var picker = ImagePicker();

  // building image
  File? certificateImage;

  Future<void> pikeBuildingImage() async {
    final pickedFile = await picker
        .pickImage(
      source: ImageSource.gallery,
    )
        .then((value) {
      certificateImage = File(value!.path);
      emit(imagePickedSuccessState());
    });
  }

  Future<void> removePikeImage() async {
    certificateImage = null;
    emit(imageRemoveSuccessState());
  }

  List<CategoryModel> categorys = [];

  void getCategorys() {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.get().then((value) {
          categorys.add(CategoryModel.fromJson(element.data()));
        }).catchError((error) {});
      });
    });
  }

  List<SelectDept> dept = [];

  int currVal = 0;
  String currText = '';

  void changeDept(int currentNum, String currentDept) {
    currVal = currentNum;
    currText = currentDept;
    emit(ChangetDeptState());
  }

////
  ///authantication
  void auth(
      {required email,
      required password,
      required phone,
      required name,
      department,
      speachalist,
      yearsofExperience}) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((userData) => {
              emit(
                SignupSucsses(userData),
              ),
              emailCreation(
                  email: email,
                  uid: userData.user!.uid,
                  phone: phone,
                  name: name,
                  department: department,
                  speachalist: speachalist,
                  yearsofExperience: yearsofExperience)
            })
        .catchError((error) {
      emit(ErrorWithSignup(error));
      print(onError.toString());
    });
  }

  ////
  ///chek user Or consultant

  void emailCreation(
      {required email,
      required uid,
      required phone,
      required name,
      department,
      speachalist,
      yearsofExperience}) {
    switch (isConsultant) {
      case true:
        createUser(uid: uid, email: email, phone: phone, name: name);
        break;
      case false:
        {
          firebase_storage.FirebaseStorage.instance
              .ref()
              .child(
                  'users/${Uri.file(certificateImage!.path).pathSegments.last}')
              .putFile(certificateImage!)
              .then((value) {
            value.ref.getDownloadURL().then((value) {
              print(value);
              createConsultant(
                uid: uid,
                name: name,
                phone: phone,
                email: email,
                deapartment: department,
                spechalist: speachalist,
                yearsOfExperiance: yearsofExperience,
                imageOfCertificate: value,
              );
            }).catchError((error) {});
          }).catchError((error) {});
        }
        break;
      default:
    }
  }

  ///Create Email and sending data to firestore

  void createUser({
    required uid,
    required name,
    required email,
    required phone,
  }) {
    UserModel usermodel = UserModel(
        email: email,
        name: name,
        phone: phone,
        uid: uid,
        userType: "user",
        image: "https://cdn-icons-png.flaticon.com/512/527/527489.png?w=740&t=st=1659793760~exp=1659794360~hmac=7cfff10352a3dc96fdfe74b00449c87f5c62482ebc231eae5e3ccecc537684e7");
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(usermodel.toMap())
        .then((result) => {
              emit(
                UserCreatedSucsess(),
              ),
            })
        .catchError((error) {
      print("error is here");

      print(error.toString());

      emit(
        UserCreatedError(error),
      );
    });
  }

  void createConsultant(
      {required uid,
      required name,
      required email,
      required phone,
      required deapartment,
      required spechalist,
      required yearsOfExperiance,
      required imageOfCertificate}) {
    ConsultantModel consultantModel = ConsultantModel(
      name: name,
      email: email,
      userType: "Consultant",
      accept: false,
      uid: uid,
      phone: phone,
      department: deapartment,
      speachalist: spechalist,
      yearsofExperience: yearsOfExperiance,
      imageOfCertificate: imageOfCertificate,
      rating: 0,
      image:
          "https://img.freepik.com/free-icon/businessman_318-1548.jpg?t=st=1657668103~exp=1657668703~hmac=fc788cc07810041e394f21af0c41ceb8997be4f8868bd0b0c7e715c1f1f3b4f3&w=740",
      bio:
          "تخصصي هوا ${spechalist} واعمل في مجال ${deapartment} , وأمتلك  ${yearsOfExperiance} من سنين الخبرة ",
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(consultantModel.toMap())
        .then((value) => {
              print('consultant created '),
              emit(
                ConsultentCreatedSucsess(),
              ),
            })
        .catchError((error) {
      emit(
        ConsultantCreatedError(error),
      );
    });
  }

// SelectDept(name: 'تقنية المعلومات', index: 1),
//     SelectDept(name: 'هندسة', index: 2),
//     SelectDept(name: 'قانون', index: 3),
//     SelectDept(name: 'طب', index: 4),
  List<CategoryModel> categoryList = [];
  void GetCategory() {
    CollectionReference category =
        FirebaseFirestore.instance.collection('Category');
    category.get().then((value) => {
          categoryList = value.docs
              .map((e) =>
                  CategoryModel.fromJson(e.data() as Map<String, dynamic>))
              .toList(),
          for (int i = 0; i < categoryList.length; i++)
            {
              dept.add(
                  SelectDept(name: categoryList[i].name.toString(), index: i))
            }
        });
  }
}

class SelectDept {
  late String name;
  late int index;

  SelectDept({
    required this.name,
    required this.index,
  });
}
