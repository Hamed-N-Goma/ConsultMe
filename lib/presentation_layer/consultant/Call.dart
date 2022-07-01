import 'dart:convert';
import 'package:consultme/Bloc/consultantBloc/cubit/consultant_cubit.dart';
import 'package:consultme/Bloc/consultantBloc/cubit/consultant_states.dart';
import 'package:consultme/Bloc/userBloc/cubit/userlayoutcubit_cubit.dart';
import 'package:consultme/models/UserModel.dart';
import 'package:consultme/models/callerhandshakeModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:sdp_transform/sdp_transform.dart';

class ReceiveCall extends StatefulWidget {
  final UserModel user;

  ReceiveCall({Key? key, required this.user}) : super(key: key);

  @override
  State<ReceiveCall> createState() => _ReceiveCallState(user);
}

class _ReceiveCallState extends State<ReceiveCall> {
  final RTCVideoRenderer _localVideoRender = RTCVideoRenderer();
  final RTCVideoRenderer _remoteVideoRender = RTCVideoRenderer();
  late MediaStream _localStreem;
  RTCPeerConnection? _peerConnection;
  final UserModel user;
  List<CallMessageModel> callDetails = [];
  late var remote;
  bool _offer = false;
  bool setcandidate = true;
  String answer = '';
  String candidate = '';

  _ReceiveCallState(this.user);

  // bool offer = false;

  @override
  void dispose() async {
    await _localVideoRender.dispose();
    await _remoteVideoRender.dispose();
    _localStreem.dispose();
    _createPeerConnecion();
    _getUserMidea();
    super.dispose();
  }

  @override
  void initState() {
    initRender();
    _createPeerConnecion().then((pc) {
      _peerConnection = pc;
      print('out of cubit');
      print(remote);
      // _setRemoteDescription();

      //  print("length offfffffffff ${callDetails.length}");
    });
    // _getUserMidea();

    // createOffer();
    super.initState();
  }

  _createPeerConnecion() async {
    Map<String, dynamic> configuration = {
      "iceServers": [
        {"url": "stun:stun.l.google.com:19302"},
      ]
    };

    final Map<String, dynamic> offerSdpConstraints = {
      "mandatory": {
        "OfferToReceiveAudio": true,
        "OfferToReceiveVideo": true,
      },
      "optional": [],
    };

    _localStreem = await _getUserMidea();

    RTCPeerConnection pc =
        await createPeerConnection(configuration, offerSdpConstraints);

    pc.addStream(_localStreem);

    pc.onIceCandidate = (e) {
      if (e.candidate != null) {
        print(json.encode({
          'candidate': e.candidate.toString(),
          'sdpMid': e.sdpMid.toString(),
          'sdpMlineIndex': e.sdpMLineIndex,
        }));
        candidate = json.encode({
          'candidate': e.candidate.toString(),
          'sdpMid': e.sdpMid.toString(),
          'sdpMlineIndex': e.sdpMLineIndex,
        });

        if (setcandidate) {
          BlocProvider.of<ConsultantCubit>(context).sendAnswer(
              receverId: user.uid,
              datetime: DateTime.now().toString(),
              answer: answer,
              candidate: candidate);
          setcandidate = false;
        }
      }
    };

    pc.onIceConnectionState = (e) {
      print(e);
    };

    pc.onAddStream = (stream) {
      print('addStream: ' + stream.id);
      _remoteVideoRender.srcObject = stream;
    };

    return pc;
  }

  void _setRemoteDescription() async {
    //setting remote description
    String jsonString = remote.toString();
    dynamic session = await jsonDecode('$jsonString');

    String sdp = write(session, null);

    RTCSessionDescription description =
        new RTCSessionDescription(sdp, _offer ? 'answer' : 'offer');
    print(description.toMap());
    await _peerConnection!.setRemoteDescription(description);
    //creating answer
    RTCSessionDescription descripion =
        await _peerConnection!.createAnswer({'offerToReceiveVideo': 1});
    var sessiion = parse(descripion.sdp.toString());
    print('data neeeeeeded');

    print(json.encode(sessiion));
    answer = json.encode(sessiion);

    _peerConnection!.setLocalDescription(descripion);
  }

  void initRender() async {
    await _localVideoRender.initialize();
    await _remoteVideoRender.initialize();
  }

  _getUserMidea() async {
    final Map<String, dynamic> mediaConstraints = {
      'audio': true,
      'video': true,
    };

    MediaStream streem =
        await navigator.mediaDevices.getUserMedia(mediaConstraints);
    _localVideoRender.srcObject = streem;
    setState(() {});

    return streem;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return Builder(builder: (context) {
      BlocProvider.of<ConsultantCubit>(context)
          .getCallDetails(callerid: user.uid);
      remote = BlocProvider.of<ConsultantCubit>(context).remote;
      return BlocConsumer<ConsultantCubit, ConsultantStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text(
                'CallScreen',
                style: TextStyle(color: Colors.black),
              ),
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: _setRemoteDescription, child: Icon(Icons.abc)),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  child: Container(
                    color: Colors.amber,
                    key: const Key('local'),
                    height: height / 3,
                    margin: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                    child: RTCVideoView(_localVideoRender,
                        objectFit:
                            RTCVideoViewObjectFit.RTCVideoViewObjectFitCover),
                  ),
                ),
                Flexible(
                  child: Container(
                    color: Colors.amber,
                    key: const Key('remote'),
                    height: height / 3,
                    margin: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                    child: RTCVideoView(_remoteVideoRender,
                        objectFit:
                            RTCVideoViewObjectFit.RTCVideoViewObjectFitCover),
                  ),
                ),
                // videoRender(height),
              ],
            ),
          );
        },
      );
    });
  }

  SizedBox videoRender(height) => SizedBox(
        height: height / 2,
        width: double.infinity,
        child: Column(
          children: [
            Flexible(
              child: Container(
                key: const Key('local'),
                height: height / 2.5,
                margin: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                child: RTCVideoView(_localVideoRender,
                    objectFit:
                        RTCVideoViewObjectFit.RTCVideoViewObjectFitCover),
              ),
            ),
          ],
        ),
      );
}
