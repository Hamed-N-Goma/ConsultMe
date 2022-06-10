abstract class LoginStates {}

class LoginInitialStates extends LoginStates {}

class LoginIsAuth extends LoginStates {
  final result;

  LoginIsAuth(this.result);
}

class LoginIsNotAuth extends LoginStates {
  final error;

  LoginIsNotAuth(this.error);
}

class UserAuthFoundedSuccess extends LoginStates {}

class AdminAuthFoundedSuccess extends LoginStates {
  final String uId;

  AdminAuthFoundedSuccess(this.uId);
}

class ConsultantAuthFoundedSuccess extends LoginStates {}

class ErrorWithCheck extends LoginStates {
  final errorWithCheck;

  ErrorWithCheck(this.errorWithCheck);
}

class ConsultantVeryfied extends LoginStates {
  final String uId;

  ConsultantVeryfied(this.uId);
}

class ConsultantNotVeryfied extends LoginStates {}

class ErrorWithCheckVreifcation extends LoginStates {
  final errorWithCheckVreifcation;

  ErrorWithCheckVreifcation(this.errorWithCheckVreifcation);
}

class LoginLoadingStates extends LoginStates {}

class LoginRotationPeriodState extends LoginStates {}

class LoginFieldsEmpty extends LoginStates {}

class ChangePasswordVisibilityState extends LoginStates {}

class LoginSuccessStates extends LoginStates {
  //final LoginModel loginModel;

  //LoginSuccessStates(this.loginModel);
}

class LoginErrorStates extends LoginStates {
  final String error;

  LoginErrorStates(this.error);
}
