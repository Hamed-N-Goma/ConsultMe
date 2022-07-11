import 'dart:developer';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:consultme/Bloc/CallBloc/call_cubit.dart';
import 'package:consultme/Bloc/userBloc/cubit/userlayoutcubit_cubit.dart';
import 'package:consultme/components/components.dart';
import 'package:consultme/const.dart';
import 'package:consultme/models/MessageModel.dart';
import 'package:consultme/models/consultantmodel.dart';
import 'package:consultme/presentation_layer/presentation_layer_manager/color_manager/color_manager.dart';
import 'package:consultme/presentation_layer/user/screens/acceptingCall.dart';
import 'package:consultme/presentation_layer/user/screens/reciveCall.dart';
import 'package:consultme/shard/style/theme/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../shard/style/iconly_broken.dart';

class UserChatDetails extends StatelessWidget {
  UserChatDetails({Key? key, required ConsultantModel this.consultant})
      : super(key: key);

  ConsultantModel consultant;
  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      UserLayoutCubit.get(context).getMessages(
        consultId: consultant.uid!,
      );
      BlocProvider.of<CallCubit>(context).getCallDetails(
          callerid: consultant.uid!,
          receiverID: UserLayoutCubit.get(context).userModel!.uid);

      return BlocListener<CallCubit, CallState>(
        listener: (context, state) async {
          if (state is ReceiveCallSucsses) {
            token = state.token;
            if (token.toString().isNotEmpty) {
              await handleCameraAndMic(Permission.camera);
              await handleCameraAndMic(Permission.microphone);
              navigateTo(
                context,
                AcceptAndRejectCalld(
                  Callerimage: consultant.image!,
                  ConsultatnatName: consultant.name!,
                ),
              );
            }
          }
        },
        child: BlocBuilder<UserLayoutCubit, UserLayoutState>(
          builder: (context, state) {
            var cubit = UserLayoutCubit.get(context);
            return Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: ColorManager.myBlue.withOpacity(0.5),
                  titleSpacing: 0,
                  title: buildAppbarTitle(context),
                  actions:
                  actionsAppBar(context, consultant.image, consultant.name),
                ),
                body: ConditionalBuilder(
                  condition: UserLayoutCubit.get(context).messages.length >= 0,
                  builder: (context) => Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              var message =
                              UserLayoutCubit.get(context).messages[index];

                              if (UserLayoutCubit.get(context).userModel?.uid ==
                                  message.senderId) {
                                return buildMyMessage(message);
                              }

                              return buildMessage(message, context);
                            },
                            separatorBuilder: (context, index) =>
                            const SizedBox(
                              height: 15.0,
                            ),
                            itemCount:
                            UserLayoutCubit.get(context).messages.length,
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
                              Container(
                                height: 50.0,
                                color: mainColors,
                                child: MaterialButton(
                                  onPressed: () {
                                    UserLayoutCubit.get(context).sendMessage(
                                      receiverId: consultant.uid!,
                                      dateTime: DateTime.now().toString(),
                                      content: messageController.text,
                                    );

                                    cubit.sendNotfiy(
                                        " لديك رسالة جديدة  ",
                                        " ${cubit.userModel!.name} تلقيت رسالة جديدة من ",
                                        cubit.getTokenById(
                                            "${consultant.uid}")!);
                                    messageController.clear();
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
          },
        ),
      );
    });
  }

  Future<void> handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    log(status.toString());
  }

  //you must send user Model with Navigation

  Widget buildAppbarTitle(context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20.0,
          backgroundImage: NetworkImage(consultant.image!),
        ),
        const SizedBox(
          width: 15.0,
        ),
        Text(
          consultant.name!,
          style: Theme.of(context).textTheme.bodyText1,
        )
      ],
    );
  }

  List<Widget> actionsAppBar(context, consultantimg, consultantName) {
    return [
      IconButton(
        onPressed: () {
          navigateTo(
              context,
              AcceptAndRejectCalld(
                Callerimage: consultantimg,
                ConsultatnatName: consultantName,
              ));
        },
        icon: FaIcon(
          FontAwesomeIcons.video,
          color: ColorManager.myWhite.withOpacity(0.8),
        ),
      ),
    ];
  }

  Widget buildMessage(MessageModel model, context) => Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      decoration: BoxDecoration(
        color: ThemeCubit.get(context).darkTheme
            ? mainColors
            : mainColors.withOpacity(0.4),
        borderRadius: const BorderRadiusDirectional.only(
          bottomEnd: Radius.circular(
            10.0,
          ),
          topStart: Radius.circular(
            10.0,
          ),
          topEnd: Radius.circular(
            10.0,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 10.0,
      ),
      child: Text(
        model.content!,
      ),
    ),
  );

  Widget buildMyMessage(MessageModel model) => Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      decoration: BoxDecoration(
        color: mainColors.withOpacity(
          .2,
        ),
        borderRadius: const BorderRadiusDirectional.only(
          bottomStart: Radius.circular(
            10.0,
          ),
          topStart: Radius.circular(
            10.0,
          ),
          topEnd: Radius.circular(
            10.0,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 10.0,
      ),
      child: Text(
        model.content!,
      ),
    ),
  );
}
