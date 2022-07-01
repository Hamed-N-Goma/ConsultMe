import 'dart:convert';
import 'package:consultme/Bloc/userBloc/cubit/userlayoutcubit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:sdp_transform/sdp_transform.dart';
import 'package:consultme/models/consultantmodel.dart';

class CallScreen extends StatefulWidget {
  final ConsultantModel consultant;

  CallScreen({Key? key, required this.consultant}) : super(key: key);

  @override
  State<CallScreen> createState() => _CallScreenState(consultant);
}

class _CallScreenState extends State<CallScreen> {
  final RTCVideoRenderer _localVideoRender = RTCVideoRenderer();
  final RTCVideoRenderer _remoteVideoRender = RTCVideoRenderer();
  late MediaStream _localStreem;
  late RTCPeerConnection _peerConnection;
  final ConsultantModel consultant;
  bool _offer = true;

  _CallScreenState(this.consultant);

  // bool offer = false;

  @override
  void dispose() async {
    await _localVideoRender.dispose();
    await _remoteVideoRender.dispose();
    _createPeerConnecion();
    _localStreem.dispose();
    _getUserMidea();
    super.dispose();
  }

  @override
  void initState() {
    initRender();
    _createPeerConnecion().then((pc) {
      _peerConnection = pc;
      _createOffer();
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

  void _createOffer() async {
    RTCSessionDescription description =
        await _peerConnection.createOffer({'offerToReceiveVideo': 1});
    var session = parse(description.sdp.toString());
    print(json.encode(session));

    _peerConnection.setLocalDescription(description);
    BlocProvider.of<UserLayoutCubit>(context).sendOffer(
        datetime: DateTime.now().toString(),
        message: json.encode(session),
        receverId: consultant.uid.toString());
    print("offffffffffffffffffffffffffffffffffffffffffffffffffer");
    print(consultant.uid);
  }

  /* void _setRemoteDescription() async {
    String jsonString = sdpController.text;
    dynamic session = await jsonDecode('$jsonString');

    String sdp = write(session, null);

    // RTCSessionDescription description =
    //     new RTCSessionDescription(session['sdp'], session['type']);
    RTCSessionDescription description =
        new RTCSessionDescription(sdp, _offer ? 'answer' : 'offer');
    print(description.toMap());

    await _peerConnection!.setRemoteDescription(description);
  }

  void _addCandidate() async {
    String jsonString = sdpController.text;
    dynamic session = await jsonDecode('$jsonString');
    print(session['candidate']);
    dynamic candidate =
        new RTCIceCandidate(session['candidate'], session['sdpMid'], session['sdpMlineIndex']);
    await _peerConnection!.addCandidate(candidate);
  }*/

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

  void _setRemoteDescription(remote) async {
    //setting remote description
    String jsonString = remote.toString();
    dynamic session = await jsonDecode('$jsonString');

    String sdp = write(session, null);

    RTCSessionDescription description =
        RTCSessionDescription(sdp, _offer ? 'answer' : 'offer');
    print(description.toMap());
    await _peerConnection.setRemoteDescription(description);
    //creating answer
  }

  void _addCandidate(candi) async {
    String jsonString = candi.toString();
    dynamic session = await jsonDecode('$jsonString');
    print(session['candidate']);
    dynamic candidate = new RTCIceCandidate(
        session['candidate'], session['sdpMid'], session['sdpMlineIndex']);
    await _peerConnection.addCandidate(candidate);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return Builder(builder: (context) {
      BlocProvider.of<UserLayoutCubit>(context)
          .getCallDetails(callerid: consultant.uid);
      return BlocConsumer<UserLayoutCubit, UserLayoutState>(
        listener: (context, state) {
          if (state is ReceiveCallSucssesfully) {
            print('data reeeeeeeeeeecevied');
            _setRemoteDescription(state.remoteDescription);
            _addCandidate(state.candidate);
          }
        },
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
                onPressed: () {
                  _createOffer();
                },
                child: Icon(Icons.abc)),
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
