

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultme/Bloc/userBloc/cubit/user_state.dart';
import 'package:consultme/models/UserModel.dart';
import 'package:consultme/shard/network/local/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserStates> {
  UserCubit() : super(UserInitial());

  static UserCubit get(context) => BlocProvider.of(context);


UserModel? userModel;
String uId = CacheHelper.getData(key: "uId") ;

void getUserData() {

  print('----------get User Data----------');
  emit(GetProfileUserLoadingStates());

  FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
    print(value.data());
    userModel = UserModel.fromJson(value.data());
    emit(GetProfileUserSuccessStates());
  }).catchError((error) {
    print(error.toString());
    emit(GetProfileUserErrorStates(error.toString()));
  });
}


}