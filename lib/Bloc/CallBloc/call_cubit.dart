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
        print(token);
        emit(GetTokenSucsses());
      },
    ).catchError((error) {
      emit(GetTokenFaild());
    });
  }

  sendCallinfo({
    required String senderId,
    required String receverId,
    required String datetime,
    required String channelName,
    required String token,
  }) {
    CallMessageModel callerModel = CallMessageModel(
        senderId: senderId,
        receiverId: receverId,
        dateTime: datetime,
        channelName: channelName,
        token: token);

    FirebaseFirestore.instance
        .collection('users')
        .doc(receverId)
        .collection('callDetails')
        .doc(senderId)
        .collection('calls')
        .add(callerModel.toMap())
        .then((value) => {emit(MakeCallSucsses())})
        .catchError((error) {
      emit(ErrorWithMakeingCall(error));
    });
  }

  String channelName = '';
  List<CallMessageModel> callanswer = [];
  void getCallDetails({callerid, receiverID}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverID)
        .collection('callDetails')
        .doc(callerid)
        .collection('calls')
        .snapshots()
        .listen((event) {
      event.docs.forEach((element) {
        callanswer.add(CallMessageModel.fromJson(element.data()));
        channelName = callanswer.first.channelName!;
        token = callanswer.first.token!;
        emit(ReceiveCallSucsses(channelName, token));
      });
    });
  }
}