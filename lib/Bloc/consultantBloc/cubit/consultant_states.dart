import 'package:consultme/models/ConsultantModel.dart';
import 'package:consultme/models/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class ConsultantStates {}

class ConsultantInitialState extends ConsultantStates {}

//get profile data from API
class GetProfileConsultantLoadingStates extends ConsultantStates {}

class GetProfileConsultantSuccessStates extends ConsultantStates {}

class GetProfileConsultantErrorStates extends ConsultantStates {
  final String error;

  GetProfileConsultantErrorStates(this.error);
}

class PostComplaintsLoadingStates extends ConsultantStates {}

class PostComplaintsSuccessStates extends ConsultantStates {}

class PostComplaintsErrorStates extends ConsultantStates {
  final String error;

  PostComplaintsErrorStates(this.error);
}

class CreatePostLoadingState extends ConsultantStates {}

class CreatePostSuccessState extends ConsultantStates {}

class CreatePostErrorState extends ConsultantStates {
  final String error;

  CreatePostErrorState(this.error);
}

class GetPostsLoadingState extends ConsultantStates {}

class GetPostsSuccessState extends ConsultantStates {}

class GetPostsErrorState extends ConsultantStates {
  final String error;

  GetPostsErrorState(this.error);
}

class DelPostLoadingStates extends ConsultantStates {}

class DeletePostSuccessState extends ConsultantStates {}

class DeletePostErrorState extends ConsultantStates {}

class ImagePickedSuccessState extends ConsultantStates {}

// Add post
class PostImagePickedSuccessState extends ConsultantStates {}

class PostImagePickedErrorState extends ConsultantStates {}

class ImageRemoveSuccessState extends ConsultantStates {}

class GetNewsLoadingStates extends ConsultantStates {}

class GetNewsSuccessStates extends ConsultantStates {}

class GetNewsErrorStates extends ConsultantStates {
  final String error;

  GetNewsErrorStates(this.error);
}

class PostNewsLoadingStates extends ConsultantStates {}

class PostNewsSuccessStates extends ConsultantStates {}

class PostNewsErrorStates extends ConsultantStates {
  final String error;

  PostNewsErrorStates(this.error);
}

class DelNewsLoadingStates extends ConsultantStates {}

class DelNewsSuccessStates extends ConsultantStates {}

class DelNewsErrorStates extends ConsultantStates {
  final String error;

  DelNewsErrorStates(this.error);
}

class GetAppointmentsLodingState extends ConsultantStates {}

class GetAppointmentsSuccessState extends ConsultantStates {}

class GetAppointmentsErrorState extends ConsultantStates {
  final String error;

  GetAppointmentsErrorState(this.error);
}

class ShowAppointmentDetails extends ConsultantStates {}

class LoadingUpdateUseInfo extends ConsultantStates {}

class PickedProfileImageSucsses extends ConsultantStates {}

class ErrorWithPickedProfileImage extends ConsultantStates {}

class UploadProfileimaggeSucsess extends ConsultantStates {}

class ErrorWithUploadProfileimagge extends ConsultantStates {}

class LoadingUpdateConsultantInfo extends ConsultantStates {}

class ErrorWithUpdateConsultant extends ConsultantStates {}

class UpdateConsultantInfoScusses extends ConsultantStates {}

class SecurityShowWarningState extends ConsultantStates {}

class AcceptedAppointmentSuccessStates extends ConsultantStates {}

class AcceptedAppointmentErrorStates extends ConsultantStates {
  final String error;
  AcceptedAppointmentErrorStates(this.error);
}

class refusalAppointmentSuccessStates extends ConsultantStates {}

class refusalAppointmentErrorStates extends ConsultantStates {
  final String error;
  refusalAppointmentErrorStates(this.error);
}

class GitUsersChatSucsess extends ConsultantStates {
  final List<UserModel> users;

  GitUsersChatSucsess(this.users);
}

class GetMessagesSuccessState extends ConsultantStates {}

class SendMessageSuccessState extends ConsultantStates {}

class SendMessageErrorState extends ConsultantStates {}


class GetMessagePicSuccessState extends ConsultantStates {}

class GetMessagePicErrorState extends ConsultantStates {}

class UploadMessagePicLoadingState extends ConsultantStates {}

class UploadMessagePicSuccessState extends ConsultantStates {}

class UploadMessagePicErrorState extends ConsultantStates {}

class DeleteMessagePicState extends ConsultantStates {}

class DeleteCommentPicState extends ConsultantStates {}

class GetAllChatSuccessState extends ConsultantStates {
  final List<UserModel> chats;

  GetAllChatSuccessState(this.chats);
}

class GetAllChatErrorState extends ConsultantStates {
  final String error;

  GetAllChatErrorState(this.error);
}

class GetAllUsersLoadingStates extends ConsultantStates {}

class GetAllUsersSuccessStates extends ConsultantStates {}

class GetAllUsersErrorStates extends ConsultantStates {
  final String error;

  GetAllUsersErrorStates(this.error);
}

class PutStudentLoadingStates extends ConsultantStates {}

class PutStudentSuccessStates extends ConsultantStates {}

class PutStudentErrorStates extends ConsultantStates {
  final String error;
  PutStudentErrorStates(this.error);
}

class DeleteStudentLoadingStates extends ConsultantStates {}

class DeleteStudentSuccess extends ConsultantStates {}

class DeleteStudentError extends ConsultantStates {
  final String error;
  DeleteStudentError(this.error);
}
