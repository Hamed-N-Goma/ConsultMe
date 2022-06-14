import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultme/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:consultme/moduls/login/cubit/states.dart';
import 'package:consultme/shard/network/end_point.dart';
import 'package:consultme/shard/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates>{

  LoginCubit() : super(LoginInitialStates());

  static LoginCubit get(context) => BlocProvider.of(context);

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ChangePasswordVisibilityState());
  }

  var buttonController = RoundedLoadingButtonController();
  var loginbutton = RoundedLoadingButtonController();

  void rotationPeriod() async {
    Timer(const Duration(milliseconds: 2000), () {
      buttonController.stop();
      emit(LoginRotationPeriodState());
    });
  }


/////
  ///Login auth creation
  void login({required email, required password}) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((reuslt) => {
      emit(
        LoginIsAuth(reuslt),
      ),
      checkIsUser(
        uid: reuslt.user!.uid,
      ),
    })
        .catchError((error) {
      emit(LoginIsNotAuth(error));
    });
  }



  ////
  ///check if user of consultent
  ///
  void checkIsUser({required uid}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      switch (documentSnapshot.get('userType')) {
        case 'user':
          {
            emit(UserAuthFoundedSuccess(uid));
          }
          break;
        case 'Consultant':
          {
            emit(ConsultantAuthFoundedSuccess());
            checkIsConsultantVirefied(uid: uid);
          }
          break;
        case 'admin':
          {
            emit(AdminAuthFoundedSuccess(uid));
          }
          break;
        default:
      }
    }).catchError((error) {
      emit(ErrorWithCheck(error));
    });
  }

  void checkIsConsultantVirefied({required uid}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      switch (documentSnapshot.get('accept')) {
        case true:
          {
            emit(ConsultantVeryfied(uid));
          }
          break;
        case false:
          {
            emit(ConsultantNotVeryfied());
          }
          break;
        default:
      }
    }).catchError((virifvaionError) {
      emit(ErrorWithCheckVreifcation(virifvaionError));
    });
  }
 // late LoginModel loginModel;

  void userLogin({
    required int id,
    required String password,
  }) {
    emit(LoginLoadingStates());

    DioHelper.postData(
      url: USERS_LOGIN,
      data: {
        'id': id,
        'password': password,
      },
    ).then((value) {
      // print(value!.data);
      //loginModel = LoginModel.fromJson(value!.data);
      //emit(LoginSuccessStates(loginModel));
    },
    ).catchError((error) {
      print(error.toString());
      emit(LoginErrorStates(error.toString()));
    });
  }

}