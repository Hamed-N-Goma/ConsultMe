import 'package:consultme/models/AdminModel.dart';
import 'package:consultme/models/UserModel.dart';
import 'package:consultme/models/consultantmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AdminStates {}

class AdminInitialState extends AdminStates {}

//get profile data from API
class GetProfileAdminLoadingStates extends AdminStates {}
class GetProfileAdminSuccessStates extends AdminStates {}
class GetProfileAdminErrorStates extends AdminStates {
  final String error;

  GetProfileAdminErrorStates(this.error);
}

class SecurityShowWarningState extends AdminStates {}


//get user in security data from API
class GetUserSecurityLoadingStates extends AdminStates {}
class GetUserSecuritySuccessStates extends AdminStates {}
class GetUserSecurityErrorStates extends AdminStates {
  final String error;

  GetUserSecurityErrorStates(this.error);
}

class delUserLoadingStates extends AdminStates{}
class delUserSuccessStates extends AdminStates{}
class delUserErrorStates extends AdminStates{}

class ShowConsultantDetails extends AdminStates{}
class ChangeConsultantEditIcon extends AdminStates{}

class InputDataSuccess extends AdminStates{}

class DeleteConsultantLoadingStates extends AdminStates {}
class DeleteConsultantSuccess extends AdminStates {}
class DeleteConsultantError extends AdminStates {
  final String error;
  DeleteConsultantError(this.error);
}

class PutConsultantLoadingStates extends AdminStates {}
class PutConsultantSuccessStates extends AdminStates {}
class PutConsultantErrorStates extends AdminStates {
  final String error;
  PutConsultantErrorStates(this.error);
}

class AcceptedConsultantLoadingStates extends AdminStates {}
class AcceptedConsultantSuccessStates extends AdminStates {}
class AcceptedConsultantErrorStates extends AdminStates {
  final String error;
  AcceptedConsultantErrorStates(this.error);
}

class GitUsersDataSucsess extends AdminStates {
  final List<UserModel> users;

  GitUsersDataSucsess(this.users);
}

class categImagePickedSuccessState extends AdminStates {}
class categImagePickedErrorState extends AdminStates {}
class ImageRemoveSuccessState extends AdminStates {}

class CreateCategoryLoadingState extends AdminStates{}
class CreateCategorySuccessState extends AdminStates {}
class CreateCategoryErrorState extends AdminStates
{
  final String error;

  CreateCategoryErrorState(this.error);
}

class GetCategorySuccessState extends AdminStates{}
class GetCategoryErrorState extends AdminStates{
  final String error;

  GetCategoryErrorState(this.error);
}

class DeleteCategorySuccessState extends AdminStates{}
class DeleteCategoryErrorState extends AdminStates{}

class DeleteUserSuccessState extends AdminStates{}
class DeleteUserErrorState extends AdminStates{}

class DeleteAllConsultByCategorySuccessState extends AdminStates{}
class DeleteAllConsultByCategoryErrorState extends AdminStates{}


//post attendance
class PostAttendanceLoadingStates extends AdminStates {}
class PostAttendanceSuccessStates extends AdminStates {}
class PostAttendanceErrorStates extends AdminStates {}

//put attendance
class PutAttendanceLoadingStates extends AdminStates {}
class PutAttendanceSuccessStates extends AdminStates {}
class PutAttendanceErrorStates extends AdminStates {}


// rooms home screen
class GetAllRoomsLoadingStates extends AdminStates {}
class GetAllRoomsSuccessStates extends AdminStates {}
class GetAllRoomsErrorStates extends AdminStates {
  final String error;
  GetAllRoomsErrorStates(this.error);
}


//security
class SelectSecurityBuilding extends AdminStates {}
class ShowSecurityDetails extends AdminStates {}
class ChangeSecurityEditIcon extends AdminStates {}
class GetAllOrdersLoadingStates extends AdminStates {}
class GetAllOrdersSuccessStates extends AdminStates {}
class GetAllOrdersErrorStates extends AdminStates {
  final String error;

  GetAllOrdersErrorStates(this.error);
}