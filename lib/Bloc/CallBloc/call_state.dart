part of 'call_cubit.dart';

@immutable
abstract class CallState {}

class CallInitial extends CallState {}

class GetTokenSucsses extends CallState {}

class GetTokenFaild extends CallState {}

class MakeCallSucsses extends CallState {}

class ErrorWithMakeingCall extends CallState {
  final String error;

  ErrorWithMakeingCall(this.error);
}

class ReceiveCallSucsses extends CallState {
  final String cahnnelName;
  final String token;

  ReceiveCallSucsses(this.cahnnelName, this.token);
}

class DeleteCalldetailsSucssesfully extends CallState {}

class CallEnded extends CallState {}
class EndCall extends CallState{}