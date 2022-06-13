import 'package:consultme/models/ConsultantModel.dart';

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

class CreatePostLoadingState extends ConsultantStates{}
class CreatePostSuccessState extends ConsultantStates {}
class CreatePostErrorState extends ConsultantStates
{
  final String error;

  CreatePostErrorState(this.error);
}

class GetPostsLoadingState extends ConsultantStates {}
class  GetPostsSuccessState extends ConsultantStates {}
class  GetPostsErrorState extends ConsultantStates
{
  final String error;

   GetPostsErrorState(this.error);
}

class DeletePostLoadingState extends ConsultantStates {}
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

class LoadingUpdateUseInfo extends ConsultantStates {}

class PickedProfileImageSucsses extends ConsultantStates {}

class ErrorWithPickedProfileImage extends ConsultantStates {}

class UploadProfileimaggeSucsess extends ConsultantStates {}

class ErrorWithUploadProfileimagge extends ConsultantStates {}

class LoadingUpdateConsultantInfo extends ConsultantStates {}

class ErrorWithUpdateConsultant extends ConsultantStates {}

class UpdateConsultantInfoScusses extends ConsultantStates {}

// Students
class ChangeTerm extends ConsultantStates {}
class ChangePeopleType extends ConsultantStates {}
class ShowStudentDetails extends ConsultantStates {}
class ChangeStudentEditIcon extends ConsultantStates {}
class SelectStudentTerm extends ConsultantStates {}
class SelectStudentLevel extends ConsultantStates {}
class SelectStudentJob extends ConsultantStates {}
class SelectStudentCredit extends ConsultantStates {}
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
class postStudentLoadingStates extends ConsultantStates {}
class postStudentSuccessStates extends ConsultantStates {}
class postStudentErrorStates extends ConsultantStates {
  final String error;
  postStudentErrorStates(this.error);
}
class ChangeGender extends ConsultantStates {}
class ChangeJob extends ConsultantStates {}
class ChangeFinesIndex extends ConsultantStates {}
class ChangeFinesEditIcon extends ConsultantStates {}
class PutFinesLoadingStates extends ConsultantStates {}
class PutFinesSuccessStates extends ConsultantStates {}
class PutFinesErrorStates extends ConsultantStates {
  final String error;
  PutFinesErrorStates(this.error);
}
class postFinesLoadingStates extends ConsultantStates {}
class postFinesSuccessStates extends ConsultantStates {}
class postFinesErrorStates extends ConsultantStates {
  final String error;
  postFinesErrorStates(this.error);
}
class GetAllVouchersLoadingStates extends ConsultantStates {}
class GetAllVouchersSuccessStates extends ConsultantStates {}
class GetAllVouchersErrorStates extends ConsultantStates {
  final String error;

  GetAllVouchersErrorStates(this.error);
}
class DeleteFinesLoadingStates extends ConsultantStates {}
class DeleteFinesSuccess extends ConsultantStates {}
class DeleteFinesError extends ConsultantStates {
  final String error;
  DeleteFinesError(this.error);
}
class InputDataSuccess extends ConsultantStates {}





//security
class SelectSecurityBuilding extends ConsultantStates {}
class ShowSecurityDetails extends ConsultantStates {}
class ChangeSecurityEditIcon extends ConsultantStates {}
class GetAllOrdersLoadingStates extends ConsultantStates {}
class GetAllOrdersSuccessStates extends ConsultantStates {}
class GetAllOrdersErrorStates extends ConsultantStates {
  final String error;

  GetAllOrdersErrorStates(this.error);
}




//get all requests
class GetAllAttendanceLoadingStates extends ConsultantStates {}
class GetAllAttendanceSuccessStates extends ConsultantStates {}
class GetAllAttendanceErrorStates extends ConsultantStates {
  final String error;

  GetAllAttendanceErrorStates(this.error);
}
//book room
class PutReplayRoomLoadingStates extends ConsultantStates {}
class PutReplayRoomSuccessStates extends ConsultantStates {}
class PutReplayRoomErrorStates extends ConsultantStates {
  final String error;
  PutReplayRoomErrorStates(this.error);
}
//change room
class PutReplayChangeLoadingStates extends ConsultantStates {}
class PutReplayChangeSuccessStates extends ConsultantStates {}
class PutReplayChangeErrorStates extends ConsultantStates {
  final String error;
  PutReplayChangeErrorStates(this.error);
}
//exit room
class PutReplayExitLoadingStates extends ConsultantStates {}
class PutReplayExitSuccessStates extends ConsultantStates {}
class PutReplayExitErrorStates extends ConsultantStates {
  final String error;
  PutReplayExitErrorStates(this.error);
}
//enquiry
class PutReplayEnquiryLoadingStates extends ConsultantStates {}
class PutReplayEnquirySuccessStates extends ConsultantStates {}
class PutReplayEnquiryErrorStates extends ConsultantStates {
  final String error;
  PutReplayEnquiryErrorStates(this.error);
}
//hosting
class PutReplayHostingLoadingStates extends ConsultantStates {}
class PutReplayHostingSuccessStates extends ConsultantStates {}
class PutReplayHostingErrorStates extends ConsultantStates {
  final String error;
  PutReplayHostingErrorStates(this.error);
}
//report
class PutReplayReportLoadingStates extends ConsultantStates {}
class PutReplayReportSuccessStates extends ConsultantStates {}
class PutReplayReportErrorStates extends ConsultantStates {
  final String error;
  PutReplayReportErrorStates(this.error);
}
//missing
class PutReplayMissingLoadingStates extends ConsultantStates {}
class PutReplayMissingSuccessStates extends ConsultantStates {}
class PutReplayMissingErrorStates extends ConsultantStates {
  final String error;
  PutReplayMissingErrorStates(this.error);
}
//damaged
class PutReplayDamagedLoadingStates extends ConsultantStates {}
class PutReplayDamagedSuccessStates extends ConsultantStates {}
class PutReplayDamagedErrorStates extends ConsultantStates {
  final String error;
  PutReplayDamagedErrorStates(this.error);
}
//complaints
class PutReplayComplaintsLoadingStates extends ConsultantStates {}
class PutReplayComplaintsSuccessStates extends ConsultantStates {}
class PutReplayComplaintsErrorStates extends ConsultantStates {
  final String error;
  PutReplayComplaintsErrorStates(this.error);
}





//changePassword
class ChangePasswordVisibilityState extends ConsultantStates {}


// rooms home screen
class GetAllRoomsLoadingStates extends ConsultantStates {}
class GetAllRoomsSuccessStates extends ConsultantStates {}
class GetAllRoomsErrorStates extends ConsultantStates {
  final String error;
  GetAllRoomsErrorStates(this.error);
}

