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

class LoadingWithUploadProfileimagge extends UserLayoutState {}

class SuccessWithUploadProfileimagge extends UserLayoutState {}

class ErrorWithUploadProfileimagge extends UserLayoutState {}

class LoadingUpdateUseInfo extends UserLayoutState {}

class ErrorWithUpdateUser extends UserLayoutState {}

class UpdateUserInfoScusses extends UserLayoutState {}

class GetConsultanatDataSucsses extends UserLayoutState {
  final List<ConsultantModel> consultants;

  GetConsultanatDataSucsses(
    this.consultants,
  );
}

class GetCategoryDataSucsses extends UserLayoutState {
  final List<CategoryModel> category;

  GetCategoryDataSucsses(this.category);
}

class ChangeThemeSuccessState extends UserLayoutState {}

class CreateAppoinmentLoadingState extends UserLayoutState {}

class CreateAppoinmentSuccessState extends UserLayoutState {}

class CreateAppoinmentErrorState extends UserLayoutState {
  final String error;

  CreateAppoinmentErrorState(this.error);
}

class GetAppointmentsLodingState extends UserLayoutState {}

class GetAppointmentsSuccessState extends UserLayoutState {}

class GetAppointmentsErrorState extends UserLayoutState {
  final String error;

  GetAppointmentsErrorState(this.error);
}

class GetMessagesSuccessState extends UserLayoutState {}

class SendMessageSuccessState extends UserLayoutState {}

class SendMessageErrorState extends UserLayoutState {}

class GetMessagePicSuccessState extends UserLayoutState {}

class GetMessagePicErrorState extends UserLayoutState {}

class UploadMessagePicLoadingState extends UserLayoutState {}

class UploadMessagePicSuccessState extends UserLayoutState {}

class UploadMessagePicErrorState extends UserLayoutState {}

class DeleteMessagePicState extends UserLayoutState {}

class DeleteCommentPicState extends UserLayoutState {}

class LoadingConsultant extends UserLayoutState {}

class LoadingCategory extends UserLayoutState {}

class AddConsultantToFavoriteSucssesfuly extends UserLayoutState {}

class ErrorWithAddConsultantToFavoriteSucssesfuly extends UserLayoutState {
  final String error;

  ErrorWithAddConsultantToFavoriteSucssesfuly(this.error);
}

class GetConsultantToFavoriteSucssesfuly extends UserLayoutState {
  final List<FavoriteModel> favoriteConsultant;

  GetConsultantToFavoriteSucssesfuly(this.favoriteConsultant);
}

class ErrorWithGetConsultantToFavoriteSucssesfuly extends UserLayoutState {
  final String error;

  ErrorWithGetConsultantToFavoriteSucssesfuly(this.error);
}

class GetAllPostsLoadingState extends UserLayoutState {}

class GetAllPostsSuccessState extends UserLayoutState {
  final List<PostModel> posts;

  GetAllPostsSuccessState(this.posts);
}

class GetAllPostsErrorState extends UserLayoutState {
  final String error;

  GetAllPostsErrorState(this.error);
}

class GetAllFavSuccessState extends UserLayoutState {}

class GetAllFavErrorState extends UserLayoutState {
  final String error;

  GetAllFavErrorState(this.error);
}

class DeleteFromFavSucsses extends UserLayoutState {}

class ErrorWithDeleteFromFav extends UserLayoutState {
  final String error;

  ErrorWithDeleteFromFav(this.error);
}

class GetAllChatSuccessState extends UserLayoutState {
  final List<ConsultantModel> chats;

  GetAllChatSuccessState(this.chats);
}

class GetAllChatErrorState extends UserLayoutState {
  final String error;

  GetAllChatErrorState(this.error);
}

class CreatingVoiceCallSucsses extends UserLayoutState {}

class ErrorWithCreatingCall extends UserLayoutState {
  final String error;

  ErrorWithCreatingCall(this.error);
}

class ReceiveCallSucssesfully extends UserLayoutState {
  final String candidate;
  final String remoteDescription;

  ReceiveCallSucssesfully(this.candidate, this.remoteDescription);
}

class SendRatingSucssesfuly extends UserLayoutState {}

class SendRatingError extends UserLayoutState {
  final String error;

  SendRatingError(this.error);
}

class GetRatingSucsses extends UserLayoutState {
}

class GetRatingError extends UserLayoutState {
}

class deleteMessagesLoadingStates extends UserLayoutState {}

class  deleteMessagesSuccessStates extends UserLayoutState {}

class  deleteMessagesErrorStates extends UserLayoutState {
  final String error;
  deleteMessagesErrorStates(this.error);
}