part of 'call_cubit.dart';

@immutable
abstract class CallState {}

class CallInitial extends CallState {}

class GetTokenSucsses extends CallState {}

class GetTokenFaild extends CallState {}

class MakeCallSucsses extends CallState {
  final String callId;

  MakeCallSucsses(this.callId);
}

class ErrorWithMakeingCall extends CallState {
  final String error;

  ErrorWithMakeingCall(this.error);
}

class ReceiveCallSucsses extends CallState {
  final CallMessageModel callanswer;

  ReceiveCallSucsses(this.callanswer);
}

class DeleteCalldetailsSucssesfully extends CallState {}

class CallEnded extends CallState {}

class EndCall extends CallState {
  final String consultId;


  EndCall(this.consultId);

}
class UserCancelCall extends CallState{}

class ConsultCancelCall extends CallState{}
