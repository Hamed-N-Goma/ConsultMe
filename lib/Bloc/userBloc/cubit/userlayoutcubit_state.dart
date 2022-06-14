part of 'userlayoutcubit_cubit.dart';

@immutable
abstract class UserLayoutState {}

class UserlayoutcubitInitial extends UserLayoutState {}

class GetDataLoading extends UserLayoutState {}

class GetUserDataSucsses extends UserLayoutState {}

class ErrorWithGetUserData extends UserLayoutState {}

class PickedProfileImageSucsses extends UserLayoutState {}

class ErrorWithPickedProfileImage extends UserLayoutState {}

class UploadProfileimaggeSucsess extends UserLayoutState {}

class ErrorWithUploadProfileimagge extends UserLayoutState {}

class LoadingUpdateUseInfo extends UserLayoutState {}

class ErrorWithUpdateUser extends UserLayoutState {}

class UpdateUserInfoScusses extends UserLayoutState {}

class GitConsultantsDataSucsess extends UserLayoutState {
  final List<ConsultantModel> consultants;

  GitConsultantsDataSucsess(this.consultants);
}

class ChangeThemeSuccessState extends UserLayoutState {}

class CreateAppoinmentLoadingState extends UserLayoutState{}
class CreateAppoinmentSuccessState extends UserLayoutState {}
class CreateAppoinmentErrorState extends UserLayoutState
{
  final String error;

  CreateAppoinmentErrorState(this.error);
}