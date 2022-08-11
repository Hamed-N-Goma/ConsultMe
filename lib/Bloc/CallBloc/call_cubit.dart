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

  String? callId;
  Future<void> sendCallinfo(
      {required String senderId,
      required String receverId,
      required String datetime,
      required String channelName,
      required String token,
      required String callType}) async{
    callId = "";
    CALLID = "";
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
            callId = value.id,
      emit(MakeCallSucsses(value.id)),

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
    print("=================================================================================== call ubdateCallinfo=================================================="),
        print(call!.callState),
    print("=================================================================================== call ubdateCallinfo==================================================")

  });
  }

  CallMessageModel? call ;

  bool ?Canceling;
  Future<void> lestenCallinfo(callerID, receiverID) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(receiverID)
        .collection('callDetails')
        .doc(callerID)
        .collection('calls')
        .doc(callId)
        .snapshots()
        .listen((event) {
      call = CallMessageModel.fromJson(event.data()!);
      print(
          "=================================================================================== call callId==================================================");
      print(call!.callId);
      print(
          "=================================================================================== call callId==================================================");
      if (call!.callState == false) {
        emit(UserCancelCall());
        print(
            "=================================================================================== call call.callState==================================================");
        print(call!.callState);
        print(
            "=================================================================================== call call.callState==================================================");
      } ;
    });

  }

  Future<void> UbdateCallinfo(callerID, receiverID , callId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(receiverID)
        .collection('callDetails')
        .doc(callerID)
        .collection('calls')
        .doc(callId)
        .update({'callState': true})
        .then((value) => {
      print("=================================================================================== call ubdateCallinfo=================================================="),
      print(call!.callState),
      print("=================================================================================== call ubdateCallinfo==================================================")

    });
  }

  Future<void> lestenCall(callerID, receiverID, callId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(receiverID)
        .collection('callDetails')
        .doc(callerID)
        .collection('calls')
        .doc(callId)
        .snapshots()
        .listen((event) {
      call = CallMessageModel.fromJson(event.data()!);
      print(
          "=================================================================================== call callId==================================================");
      print(call!.callId);
      print(
          "=================================================================================== call callId==================================================");
       if (call!.callState == true) {
        emit(ConsultCancelCall());
        print(
            "=================================================================================== call call.callState==================================================");
        print(call!.callState);
        print(
            "=================================================================================== call call.callState==================================================");
      };
    });

  }
  endCall(consultId) {
    emit(EndCall(consultId));
  }
}
