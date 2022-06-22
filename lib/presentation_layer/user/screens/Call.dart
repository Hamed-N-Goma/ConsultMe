import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class CallScreen extends StatefulWidget {
  CallScreen({Key? key}) : super(key: key);

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  final _localVideoRender = RTCVideoRenderer();
  void initRender() async {
    await _localVideoRender.initialize();
  }

  _getUserMidea() async {
    final Map<String, dynamic> mediaConstraints = {
      'audio': true,
      'video': {'facingMode': 'user'},
    };

    MediaStream streem =
        await navigator.mediaDevices.getUserMedia(mediaConstraints);
    _localVideoRender.srcObject = streem;
  }

  @override
  void initState() {
    initRender();
    _getUserMidea();
    super.initState();
  }

  @override
  void dispose() async {
    await _localVideoRender.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'CallScreen',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        height: height / 2,
        width: width,
        color: Colors.amber,
        child: Stack(
          children: [
            Positioned(
                top: 0.0,
                right: 0.0,
                left: 0.0,
                bottom: 0.0,
                child: RTCVideoView(_localVideoRender))
          ],
        ),
      ),
    );
  }
}
