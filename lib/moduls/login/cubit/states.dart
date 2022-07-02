
import '../../../models/usermodel.dart';

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

class UserAuthFoundedSuccess extends LoginStates {
  final UserModel loginModel;
  UserAuthFoundedSuccess(this.loginModel);
}

class ConsultantAuthFoundedSuccess extends LoginStates {
  ConsultantAuthFoundedSuccess();
}

class ConsultantVeryfied extends LoginStates {
  final UserModel loginModel;

  ConsultantVeryfied(this.loginModel);
}

class AdminAuthFoundedSuccess extends LoginStates {
  final UserModel loginModel;

  AdminAuthFoundedSuccess(this.loginModel);
}

class ErrorWithCheck extends LoginStates {
  final errorWithCheck;

  ErrorWithCheck(this.errorWithCheck);
}

class ConsultantNotVeryfied extends LoginStates {}

class ErrorWithCheckVreifcation extends LoginStates {
  final errorWithCheckVreifcation;

  ErrorWithCheckVreifcation(this.errorWithCheckVreifcation);
}

class LoginLoadingStates extends LoginStates {}

class LoginRotationPeriodState extends LoginStates {}

class ChangePasswordVisibilityState extends LoginStates {}

class LoginSuccessStates extends LoginStates {
  //final LoginModel loginModel;

  //LoginSuccessStates(this.loginModel);
}

class LoginErrorStates extends LoginStates {
  final String error;

  LoginErrorStates(this.error);
}

class sendEmailSecces extends LoginStates{}
class sendEmailError extends LoginStates{}