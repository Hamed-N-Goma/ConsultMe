import 'dart:developer';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:consultme/Bloc/CallBloc/call_cubit.dart';
import 'package:consultme/Bloc/consultantBloc/cubit/consultant_cubit.dart';
import 'package:consultme/Bloc/consultantBloc/cubit/consultant_states.dart';
import 'package:consultme/const.dart';
import 'package:consultme/models/MessageModel.dart';
import 'package:consultme/models/UserModel.dart';
import 'package:consultme/presentation_layer/consultant/makeCall.dart';
import 'package:consultme/presentation_layer/presentation_layer_manager/color_manager/color_manager.dart';
import 'package:consultme/shard/style/theme/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../shard/style/iconly_broken.dart';

class ConsultChatDetails extends StatelessWidget {
  ConsultChatDetails({Key? key, required UserModel this.User})
      : super(key: key);

  UserModel User;
  String? notifyToken ;
  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      ConsultantCubit.get(context).getMessages(
        userId: User.uid,
      );
      BlocProvider.of<CallCubit>(context).generateToken(
          BlocProvider.of<ConsultantCubit>(context).consultantModel!.uid,
          "publisher",
          "uid",
          "0");
      return BlocConsumer<ConsultantCubit, ConsultantStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = ConsultantCubit.get(context);
            dynamic messageImage = ConsultantCubit.get(context).messageImage;

            return Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: mainColors,
                  titleSpacing: 0,
                  title: buildAppbarTitle(context),
                  actions: actionsAppBar(context),
                ),
                body: ConditionalBuilder(
                  condition: ConsultantCubit.get(context).messages.length >= 0,
                  builder: (context) => Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            reverse: true,

                            itemBuilder: (context, index) {
                              var message =
                                  ConsultantCubit.get(context).messages[index];

                              if (ConsultantCubit.get(context)
                                      .consultantModel
                                      ?.uid ==
                                  message.senderId)
                                return buildMessage(message, context);

                              return buildMyMessage(message, context);
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 15.0,
                            ),
                            itemCount:
                                ConsultantCubit.get(context).messages.length,

                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        if (ConsultantCubit.get(context).isMessageImageLoading == true)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: LinearProgressIndicator(
                              color: mainColors,
                            ),
                          ),

                        if (messageImage != null)
                          Padding(
                            padding:
                            const EdgeInsetsDirectional.only(bottom: 8.0),
                            child: Align(
                              alignment: AlignmentDirectional.topStart,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 100,
                                    height: 100,
                                    child: Image.file(messageImage,
                                        fit: BoxFit.cover, width: 100),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.grey[300],
                                      child: IconButton(
                                        onPressed: () {
                                          ConsultantCubit.get(context)
                                              .popMessageImage();
                                        },
                                        icon: Icon(Icons.close),
                                        iconSize: 15,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),

                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(
                              15.0,
                            ),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Row(
                            children: [

                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0,
                                  ),
                                  child: TextFormField(
                                    controller: messageController,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'type your message here ...',
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    ConsultantCubit.get(context).getMessageImage();
                                  },
                                  icon: Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.grey,
                                  )),
                              Container(
                                height: 60.0,
                                color: mainColors,
                                child: MaterialButton(
                                  onPressed: ()  {
                                    if (messageImage == null) {
                                      ConsultantCubit.get(context).sendMessage(
                                        receiverId: User.uid,
                                        dateTime: DateTime.now().toString(),
                                        content: messageController.text,
                                      );
                                    }
                                    else {
                                      ConsultantCubit.get(context).uploadMessagePic(
                                        receiverId: User.uid,
                                        content: messageController.text == ''
                                            ? null
                                            : messageController.text,
                                        dateTime: DateTime.now().toString(),
                                      );
                                    }

                                      cubit.sendNotfiy(
                                        " لديك رسالة جديدة  ",
                                        " ${cubit.consultantModel!.name} تلقيت رسالة جديدة من ",
                                           cubit.getTokenById("${User.uid}")!,
                                        "message");

                                        messageController.clear();
                                        ConsultantCubit.get(context).popMessageImage();

                                  },
                                  minWidth: 1.0,
                                  child: const Icon(
                                    IconBroken.Send,
                                    size: 16.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  fallback: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            );
          });
    });
  }

  //you must send user Model with Navigation

  Widget buildAppbarTitle(context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20.0,
          backgroundImage: NetworkImage(User.image!),
        ),
        const SizedBox(
          width: 15.0,
        ),
        Text(
          '${User.name}',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
        )
      ],
    );
  }

  List<Widget> actionsAppBar(context) {
    return [
      IconButton(
        onPressed: () async {
          if (token.toString().isNotEmpty) {

            ConsultantCubit.get(context).sendNotfiy(
                " لقد تلقيت مكالمة ",
                " ${ConsultantCubit.get(context).consultantModel!.name} لديك موعد مكالمة الأن مع ",
                 ConsultantCubit.get(context).getTokenById("${User.uid}")!,"call",token.toString());

            await handleCameraAndMic(Permission.camera);
            await handleCameraAndMic(Permission.microphone);
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MakeCall(
                  channelName: BlocProvider.of<ConsultantCubit>(context)
                      .consultantModel!
                      .uid,
                  role: ClientRole.Broadcaster,
                  userId: User.uid,
                  callType: "Video",
                  userinfo: User,
                ),
              ),
            );
          }
        },
        icon: FaIcon(
          FontAwesomeIcons.video,
          color: ColorManager.myWhite.withOpacity(0.8),
        ),
      ),
      SizedBox(
        width: 10,
      ),
      IconButton(
        onPressed: () async {

          ConsultantCubit.get(context).sendNotfiy(
              " لقد تلقيت مكالمة ",
              "${ConsultantCubit.get(context).consultantModel!.name} لديك موعد مكالمة الأن مع ",
               ConsultantCubit.get(context).getTokenById("${User.uid}")!,"call" ,token.toString());

          if (token.toString().isNotEmpty) {
            await handleCameraAndMic(Permission.camera);
            await handleCameraAndMic(Permission.microphone);
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MakeCall(
                  channelName: BlocProvider.of<ConsultantCubit>(context)
                      .consultantModel!
                      .uid,
                  role: ClientRole.Broadcaster,
                  userId: User.uid,
                  callType: "Audio",
                  userinfo: User,
                ),
              ),
            );
          }
        },
        icon: FaIcon(
          FontAwesomeIcons.phone,
          color: ColorManager.myWhite.withOpacity(0.8),
        ),
      ),
    ];
  }
  Widget buildMessage(MessageModel message, context) =>
      Align(
        alignment: AlignmentDirectional.topStart,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                message.content != null && message.messageImage != null
                    ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding: const EdgeInsets.all(8),
                        width: intToDouble(
                            message.messageImage!['width']) <
                            150
                            ? intToDouble(
                            message.messageImage!['width'])
                            : 150,

                        decoration: BoxDecoration(

                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                            )),
                        child: imagePreview(
                            message.messageImage!['image'])),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 8),
                        decoration: BoxDecoration(
                            color:Colors.blueAccent,
                            borderRadius: const BorderRadiusDirectional.only(
                              bottomStart: Radius.circular(5.0),
                              topStart: Radius.circular(20.0),
                              topEnd: Radius.circular(20.0),
                              bottomEnd: Radius.circular(20.0),

                            )),
                        child: Text('${message.content}',
                        )),
                  ],
                )
                    : message.messageImage != null
                    ? Container(
                    padding: const EdgeInsets.all(10),
                    width: intToDouble(
                        message.messageImage!['width']) <
                        230
                        ? intToDouble(message.messageImage!['width'])
                        : 230,
                    height: intToDouble(
                        message.messageImage!['height']) <
                        250
                        ? intToDouble(message.messageImage!['height'])
                        : 250,

                    child:
                    imagePreview(message.messageImage!['image']))
                    : message.content != null
                    ? Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: const BorderRadiusDirectional.only(
                          bottomStart: Radius.circular(5.0),
                          topStart: Radius.circular(20.0),
                          topEnd: Radius.circular(20.0),
                          bottomEnd: Radius.circular(20.0),
                        )),
                    child: Text('${message.content}',
                    ))
                    : const SizedBox(
                  height: 0,
                  width: 0,
                )
              ],
            ),
            Text(
              '${message.dateTime}',
              style: TextStyle(color: Colors.grey,fontSize: 10),
            ),
          ],
        ),
      );

  Widget buildMyMessage(MessageModel message, context) =>
      Align(
        alignment: AlignmentDirectional.topEnd,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                message.content != null && message.messageImage != null
                    ? Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                        width: intToDouble(
                            message.messageImage!['width']) <
                            230
                            ? intToDouble(
                            message.messageImage!['width'])
                            : 230,

                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: imagePreview(
                                message.messageImage!['image']))),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                            color: Colors.grey[500],
                            borderRadius: BorderRadiusDirectional.only(
                              bottomStart: Radius.circular(5.0),
                              topStart: Radius.circular(20.0),
                              topEnd: Radius.circular(20.0),
                              bottomEnd: Radius.circular(20.0),
                            )),

                        child: Text('${message.content}',
                            style: const TextStyle(color: Colors.white))),
                  ],
                )
                    : message.messageImage != null
                    ? Container(
                    padding: const EdgeInsets.all(10),
                    width: 150,

                    child:
                    imagePreview(message.messageImage!['image']))
                    : message.content != null
                    ? Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color:  Colors.grey[500],
                        borderRadius: BorderRadiusDirectional.only(
                          bottomStart: Radius.circular(20.0),
                          topStart: Radius.circular(20.0),
                          topEnd: Radius.circular(20.0),
                          bottomEnd: Radius.circular(5.0),
                        )),
                    child: Text('${message.content}',
                        style: const TextStyle(color: Colors.white)))
                    : const SizedBox(
                  height: 0,
                  width: 0,
                )
              ],
            ),

            Text(
              '${message.dateTime} ',
              style: TextStyle(color: Colors.grey,fontSize: 10),
            ),
          ],
        ),
      );

  Future<void> handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    log(status.toString());
  }
}
