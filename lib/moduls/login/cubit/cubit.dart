import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultme/components/components.dart';
import 'package:consultme/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:consultme/moduls/login/cubit/states.dart';
import 'package:consultme/shard/network/end_point.dart';
import 'package:consultme/shard/network/remote/dio_helper.dart';

import '../../../models/usermodel.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialStates());

  static LoginCubit get(context) => BlocProvider.of(context);

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  var auth = FirebaseAuth.instance;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ChangePasswordVisibilityState());
  }

  var buttonController = RoundedLoadingButtonController();
  var loginbutton = RoundedLoadingButtonController();
  var resetButton = RoundedLoadingButtonController();


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
        .then((reuslt) =>
    {
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

  UserModel? loginModel;

  ////
  ///check if user of consultent
  ///
  void checkIsUser({required uid}) {
    loginModel = null;
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((user) {
      loginModel = UserModel.fromJson(user.data()!);
      switch (user.get('userType')) {
        case 'user':
          {
            emit(UserAuthFoundedSuccess(loginModel!));
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
            emit(AdminAuthFoundedSuccess(loginModel!));
          }
          break;
        default:
      }
    }).catchError((error) {
      emit(ErrorWithCheck(error));
    });
  }

  void checkIsConsultantVirefied({required uid}) {
    loginModel = null;
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((user) {
      loginModel = UserModel.fromJson(user.data()!);
      switch (user.get('accept')) {
        case true:
          {
            emit(ConsultantVeryfied(loginModel!));
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
    ).then(
          (value) {
        // print(value!.data);
        //loginModel = LoginModel.fromJson(value!.data);
        //emit(LoginSuccessStates(loginModel));
      },
    ).catchError((error) {
      print(error.toString());
      emit(LoginErrorStates(error.toString()));
    });
  }

  Future<void> sendPasswordResetEmail( String email) async {
    auth.sendPasswordResetEmail(email: email).then((value) =>
    {
      emit(sendEmailSecces()),
      showToast(message: 'لقد تم إرسال رسالة , تحقق من البريد الخاص بك',
          state: ToastStates.SUCCESS)
    }).catchError((error) {
      emit(sendEmailError());
      showToast(message: 'حدث خطأ يرجى إعادة المحاولة لاحقا ..',
          state: ToastStates.ERROR);
    });
  }
}
