import 'package:bloc_test/bloc_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultme/Bloc/CallBloc/call_cubit.dart';
import 'package:consultme/Bloc/adminBloc/cubit/admin_cubit.dart';
import 'package:consultme/Bloc/adminBloc/cubit/admin_states.dart';
import 'package:consultme/Bloc/consultantBloc/cubit/consultant_cubit.dart';
import 'package:consultme/Bloc/consultantBloc/cubit/consultant_states.dart';
import 'package:consultme/Bloc/userBloc/cubit/userlayoutcubit_cubit.dart';
import 'package:consultme/models/UserModel.dart';
import 'package:consultme/moduls/signup/cubit/cubit.dart';
import 'package:consultme/moduls/signup/cubit/states.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:test/scaffolding.dart';
import 'package:test/test.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';

import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';


Future<void> main() async {
  group("userBlocTesting", () {
    blocTest<UserLayoutCubit, UserLayoutState>("DarkModeTesting",
        build: () => UserLayoutCubit(),
        act: (cubit) => cubit.toggleButton(),
        expect: () => [ChangeThemeSuccessState()]);
  });


  group("Admin Cubit Testing", () {
    blocTest<AdminCubit, AdminStates>(" showWaitingConsultantDetails",
        build: () => AdminCubit(),
        act: (cubit) => cubit.showWaitingConsultantDetails(true, -1),
        expect: () => [ShowConsultantDetails()]);
  });


}
