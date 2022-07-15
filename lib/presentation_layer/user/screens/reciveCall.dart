import 'package:flutter/material.dart';
import 'package:consultme/const.dart';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'dart:async';

class ReciveCll extends StatefulWidget {
  final String? channelName;
  final ClientRole? role;
  ReciveCll({Key? key, this.channelName, this.role}) : super(key: key);

  @override
  State<ReciveCll> createState() => _ReciveCllState();
}

class _ReciveCllState extends State<ReciveCll> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(token);
    initilize();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _users.clear();
    _engine.leaveChannel();
    _engine.destroy();
  }

  final _users = <int>[];
  final infoString = <String>[];
  bool mute = false;
  bool viewPanel = false;
  late RtcEngine _engine;

  Future<void> initilize() async {
    if (appId.isEmpty) {
      setState(() {
        infoString.add("app ID is empty");
      });
      return;
    }
    _engine = await RtcEngine.create(appId);
    await _engine.enableVideo();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(widget.role!);
    _addAgoraEventHandler();
    VideoEncoderConfiguration config = VideoEncoderConfiguration();
    config.dimensions = VideoDimensions(width: 640, height: 360);
    await _engine.setVideoEncoderConfiguration(config);
    await _engine.joinChannel(token, widget.channelName!, null, 0);
  }

  void _addAgoraEventHandler() {
    _engine.setEventHandler(
      RtcEngineEventHandler(
        error: (code) {
          setState(
            () {
              final info = 'error $code';
              infoString.add(info);
            },
          );
        },
        joinChannelSuccess: (channel, uid, elapsed) {
          setState(
            () {
              final info = 'Join Chanel: $channel , uid $uid';
              infoString.add(info);
            },
          );
        },
        leaveChannel: (status) {
          setState(
            () {
              final info = 'Join Chanel: $status ';
              infoString.add(info);
              _users.clear();
            },
          );
        },
        userJoined: (uid, elepse) {
          setState(() {
            final info = 'Joind user: $uid ';
            infoString.add(info);
            _users.add(uid);
          });
        },
        userOffline: (uid, elepse) {
          final info = 'Joind user: $uid ';
          infoString.add(info);
          _users.remove(uid);
          _engine.leaveChannel();
          Navigator.pop(context);
        },
        firstRemoteVideoFrame: (uid, height, width, elepse) {
          setState(
            () {
              final info = 'first remote user: $uid $width x $height';
              infoString.add(info);
            },
          );
        },
      ),
    );
  }

  Widget viewRow() {
    List<StatefulWidget> list = [];
    if (widget.role == ClientRole.Broadcaster) {
      list.add(const RtcLocalView.SurfaceView());
    }
    for (var uid in _users) {
      list.add(
        RtcRemoteView.SurfaceView(
          uid: uid,
          channelId: widget.channelName!,
        ),
      );
    }
    final view = list;
    return Column(
      children: List.generate(
        view.length,
        (index) => Expanded(
          child: view[index],
        ),
      ),
    );
  }

  Widget toolbar() {
    if (widget.role == ClientRole.Audience) {
      return const SizedBox();
    }
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        children: [
          RawMaterialButton(
            onPressed: () {
              setState(() {
                mute = !mute;
              });
              _engine.muteLocalAudioStream(mute);
            },
            child: Icon(
              mute ? Icons.mic_off : Icons.mic,
              color: mute ? Colors.white : Colors.blueAccent,
              size: 20,
            ),
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: mute ? Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(12),
          ),
          RawMaterialButton(
            onPressed: () {
              _engine.leaveChannel();
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.call_end,
              color: Colors.white,
              size: 20,
            ),
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(12),
          ),
          RawMaterialButton(
            onPressed: () {
              _engine.switchCamera();
            },
            child: Icon(
              Icons.switch_camera,
              color: Colors.blueAccent,
              size: 20,
            ),
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12),
          ),
        ],
      ),
    );
  }

  Widget panel() {
    return Visibility(
      visible: viewPanel,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 48),
        alignment: Alignment.bottomCenter,
        child: FractionallySizedBox(
          heightFactor: 0.5,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 48),
            child: ListView.builder(
                reverse: true,
                itemBuilder: (context, index) {
                  if (infoString.isEmpty) {
                    return const Text('null');
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 3,
                      horizontal: 10,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              infoString[index],
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
                itemCount: infoString.length),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Stack(
            children: [
              viewRow(),
              panel(),
              toolbar(),
            ],
          ),
        ),
      );
    });
  }
}