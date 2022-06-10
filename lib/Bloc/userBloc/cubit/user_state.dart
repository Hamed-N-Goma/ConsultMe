
abstract class UserStates {}

class UserInitial extends UserStates {}

class GetProfileUserLoadingStates extends UserStates {}
class GetProfileUserSuccessStates extends UserStates {}
class GetProfileUserErrorStates extends UserStates {
  final String error;

  GetProfileUserErrorStates(this.error);
}


