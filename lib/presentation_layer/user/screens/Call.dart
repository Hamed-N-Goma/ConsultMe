import 'dart:developer';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:consultme/Bloc/CallBloc/call_cubit.dart';
import 'package:consultme/Bloc/userBloc/cubit/userlayoutcubit_cubit.dart';
import 'package:consultme/const.dart';
import 'package:consultme/models/MessageModel.dart';
import 'package:consultme/models/consultantmodel.dart';
import 'package:consultme/presentation_layer/presentation_layer_manager/color_manager/color_manager.dart';
import 'package:consultme/presentation_layer/user/screens/reciveCall.dart';
import 'package:consultme/shard/style/theme/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../shard/style/iconly_broken.dart';

class Call extends StatefulWidget {
  Call({Key? key, required ConsultantModel this.consultant ,required String this.calltype,required String this.RTCtoken,required String this.callId,})
      : super(key: key);

  ConsultantModel consultant;
  String calltype;
  String RTCtoken;
  String callId;
  @override
  State<Call> createState() => _CallState();
}

class _CallState extends State<Call> {

  AssetsAudioPlayer player = AssetsAudioPlayer();

  @override
  void initState() {
    player.open(
      Audio("assets/sound/callingvoice.mp3"),
      autoStart: true,
    );

    super.initState();
  }

  @override
  dispose(){

    player.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {

      return BlocListener<CallCubit, CallState>(
        listener: (context, state) async {},
        child: BlocBuilder<UserLayoutCubit, UserLayoutState>(
          builder: (context, state) {
            token = widget.RTCtoken;
            return Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                body: Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(widget.consultant.image!),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Container(
                        color: Colors.black.withOpacity(0.8),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                  widget.consultant.image!,
                                ),
                                maxRadius: 45,
                              ),
                              Text(
                                widget.consultant.name!,
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
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      RawMaterialButton(
                                        onPressed: ()  async {
                                          Navigator.pop(context);
                                          iscalling = false;
                                          player.stop();
                                          player.dispose();

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
                                        onPressed: ()  {
                                          iscalling = false;
                                          player.stop();
                                          player.dispose();
                                          BlocProvider.of<CallCubit>(context)
                                              .ubdateCallinfo(
                                              widget.consultant.uid!,
                                              BlocProvider.of<UserLayoutCubit>(
                                                  context)
                                                  .userModel
                                                  ?.uid,
                                              widget.callId
                                          );
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ReciveCll(
                                                channelName:
                                                BlocProvider.of<CallCubit>(
                                                    context)
                                                    .channelName,
                                                role: ClientRole.Broadcaster,
                                                consultantId: widget.consultant.uid,
                                                callType:   widget.calltype,
                                                consultantinfo: widget.consultant,
                                              ),
                                            ),
                                          );
                                          const Icon(
                                            Icons.call_rounded,
                                            color: Colors.white,
                                            size: 40,
                                          );
                                        },
                                        child: widget.calltype == "Audio"
                                            ? const Icon(
                                          Icons.call_rounded,
                                          color: Colors.white,
                                          size: 40,
                                        )
                                            : const Icon(
                                          FontAwesomeIcons.video,
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
              ),
            );
          },
        ),
      );
    });
  }

  Future<void> handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    log(status.toString());
  }
}
