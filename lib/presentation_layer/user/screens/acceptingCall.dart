import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:consultme/Bloc/CallBloc/call_cubit.dart';
import 'package:consultme/components/components.dart';
import 'package:consultme/presentation_layer/user/screens/reciveCall.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AcceptAndRejectCalld extends StatefulWidget {
  final String Callerimage;
  final String ConsultatnatName;
  AcceptAndRejectCalld(
      {Key? key, required this.Callerimage, required this.ConsultatnatName})
      : super(key: key);

  @override
  State<AcceptAndRejectCalld> createState() => _AcceptAndRejectCalldState();
}

class _AcceptAndRejectCalldState extends State<AcceptAndRejectCalld> {
  AssetsAudioPlayer player = AssetsAudioPlayer();

  @override
  void initState() {
    player.open(
      Audio("assets/sound/callingvoice.mp3"),
      autoStart: true,
    );
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.Callerimage),
                fit: BoxFit.fill,
              ),
            ),
            child: Container(
              color: Colors.black.withOpacity(0.8),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    widget.Callerimage,
                  ),
                  maxRadius: 45,
                ),
                Text(
                  widget.ConsultatnatName,
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  " ....يتصل بك",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                ),
                Align(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 48),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RawMaterialButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.call_end,
                            color: Colors.white,
                            size: 40,
                          ),
                          shape: const CircleBorder(),
                          elevation: 2.0,
                          fillColor: Colors.redAccent,
                          padding: const EdgeInsets.all(12),
                        ),
                        RawMaterialButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ReciveCll(
                                  channelName:
                                      BlocProvider.of<CallCubit>(context)
                                          .channelName,
                                  role: ClientRole.Broadcaster,
                                ),
                              ),
                            );
                            dispose();
                          },
                          child: const Icon(
                            Icons.call_rounded,
                            color: Colors.white,
                            size: 40,
                          ),
                          shape: const CircleBorder(),
                          elevation: 2.0,
                          fillColor: Colors.green,
                          padding: const EdgeInsets.all(12),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
