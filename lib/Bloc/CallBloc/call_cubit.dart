import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultme/const.dart';
import 'package:consultme/models/callerhandshakeModel.dart';
import 'package:consultme/shard/network/remote/generateToken.dart';
import 'package:meta/meta.dart';

part 'call_state.dart';

class CallCubit extends Cubit<CallState> {
  CallCubit() : super(CallInitial());
  var gToken = TokenService.inctance;
  generateToken(channelName, role, tokenType, uid) {
    gToken.createToken(channelName, role, tokenType, uid).then(
      (value) {
        token = value["rtcToken"];
        emit(GetTokenSucsses());
      },
    ).catchError((error) {
      emit(GetTokenFaild());
    });
  }

  sendCallinfo(
      {required String senderId,
      required String receverId,
      required String datetime,
      required String channelName,
      required String token,
      required String callType}) {
    CallMessageModel callerModel = CallMessageModel(
      senderId: senderId,
      receiverId: receverId,
      dateTime: datetime,
      channelName: channelName,
      token: token,
      callType: callType,
      callId: null,
      callState: null,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(receverId)
        .collection('callDetails')
        .doc(senderId)
        .collection('calls')
        .add(callerModel.toMap())
        .then((value) =>
    {
      FirebaseFirestore.instance
          .collection('users')
          .doc(receverId)
          .collection('callDetails')
          .doc(senderId)
          .collection('calls')
          .doc(value.id)
          .update({'callId': value.id})
          .then((vvv) => {
      emit(MakeCallSucsses(value.id))
    })
  }).catchError((error) {
      emit(ErrorWithMakeingCall(error));
    });
  }

  String? channelName;
  String? callType;
  late CallMessageModel callanswer ;
  Future<void> getCallDetails({callerid, receiverID , callId}) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(receiverID)
        .collection('callDetails')
        .doc(callerid)
        .collection('calls')
        .doc(callId)
        .get().then((value) {

      callanswer = CallMessageModel.fromJson(value.data()!);
      callType = callanswer.callType!;
      channelName = callanswer.channelName!;
      token = callanswer.token;
      print("=================================================================================== call amser==================================================");
      print(callanswer);
      print("=================================================================================== call amser==================================================");
      print(callanswer.callId);

      emit(ReceiveCallSucsses(callanswer));
    }).catchError((error) {

    });
  }

  Future<void> ubdateCallinfo(callerID, receiverID , callId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(receiverID)
        .collection('callDetails')
        .doc(callerID)
        .collection('calls')
        .doc(callId)
        .update({'callState': false})
        .then((value) => {

  });
  }

  List<CallMessageModel> calls = [];

  bool ?Canceling;
  Future<void> lestenCallinfo(callerID, receiverID , callId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(receiverID)
        .collection('callDetails')
        .doc(callerID)
        .collection('calls')
        .snapshots()
        .listen((event) {
      calls = [];

      event.docs.forEach((element) {
        calls.add(CallMessageModel.fromJson(element.data()));
      });
    });
    calls.forEach((element) {
      if (element.callId == callId){
        if(element.callState == false){
          emit(UserCancelCall());
        }
      };
    });
  }

  endCall(consultId) {
    emit(EndCall(consultId));
  }
}
