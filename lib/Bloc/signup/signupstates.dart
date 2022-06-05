class SignUpStates {}

class signUpInitialStates extends SignUpStates {}

class SignupSucsses extends SignUpStates {
  final authsucsess;

  SignupSucsses(this.authsucsess);
}

class ErrorWithSignup extends SignUpStates {
  final error;

  ErrorWithSignup(this.error);
}

class UserCreatedSucsess extends SignUpStates {}

class UserCreatedError extends SignUpStates {
  final error;

  UserCreatedError(this.error);
}

class ConsultentCreatedSucsess extends SignUpStates {}

class ConsultantCreatedError extends SignUpStates {
  final error;

  ConsultantCreatedError(this.error);
}

class signUpLoadingStates extends SignUpStates {}

class signUpRotationPeriodState extends SignUpStates {}

class ChangePasswordVisibilityStates extends SignUpStates {}

class ChangeConsultantState extends SignUpStates {}

class imagePickedSuccessState extends SignUpStates {}

class imageRemoveSuccessState extends SignUpStates {}

class ChangetDeptState extends SignUpStates {}

class signUpSuccessStates extends SignUpStates {
  //final LoginModel loginModel;

  // signUpSuccessStates(this.loginModel);
}

class signUpErrorStates extends SignUpStates {
  final String error;

  signUpErrorStates(this.error);
}
