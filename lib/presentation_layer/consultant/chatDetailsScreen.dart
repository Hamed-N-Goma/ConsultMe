import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:consultme/Bloc/consultantBloc/cubit/consultant_cubit.dart';
import 'package:consultme/Bloc/consultantBloc/cubit/consultant_states.dart';
import 'package:consultme/models/MessageModel.dart';
import 'package:consultme/models/UserModel.dart';
import 'package:consultme/presentation_layer/presentation_layer_manager/color_manager/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../shard/style/iconly_broken.dart';

class ConsultChatDetails extends StatelessWidget {
  ConsultChatDetails({Key? key, required UserModel this.User}) : super(key: key);

   UserModel User ;
   var messageController = TextEditingController();

   @override
   Widget build(BuildContext context) {
     return Builder(
         builder: (BuildContext context) {
           ConsultantCubit.get(context).getMessages(
         userId: User.uid!,
       );
       return BlocConsumer<ConsultantCubit, ConsultantStates>(
           listener: (context, state) {},
           builder: (context, state) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorManager.myBlue.withOpacity(0.5),
          titleSpacing: 0,
          title: buildAppbarTitle(context),
          actions: actionsAppBar(),
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
                    itemBuilder: (context, index)
                    {
                      var message = ConsultantCubit.get(context).messages[index];

                      if(ConsultantCubit.get(context).consultantModel?.uid == message.senderId)
                        return buildMyMessage(message);

                      return buildMessage(message);
                    },
                    separatorBuilder: (context, index) => SizedBox(
                      height: 15.0,
                    ),
                    itemCount: ConsultantCubit.get(context).messages.length,
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
                            decoration: InputDecoration(
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
                            ConsultantCubit.get(context).sendMessage(
                              receiverId: User.uid!,
                              dateTime: DateTime.now().toString(),
                              content : messageController.text,
                            );
                          },
                          minWidth: 1.0,
                          child: Icon(
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
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
       );
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
        SizedBox(
          width: 15.0,
        ),
        Text(
          User.name!,
          style: Theme.of(context).textTheme.bodyText1,
        )
      ],
    );
  }

  List<Widget> actionsAppBar() {
    return [
      IconButton(
        onPressed: () {},
        icon: FaIcon(
          FontAwesomeIcons.phone,
          color: ColorManager.myWhite.withOpacity(0.8),
        ),
      ),
      IconButton(
        onPressed: () {},
        icon: FaIcon(
          FontAwesomeIcons.video,
          color: ColorManager.myWhite.withOpacity(0.8),
        ),
      ),
    ];
  }

   Widget buildMessage(MessageModel model) => Align(
     alignment: AlignmentDirectional.centerStart,
     child: Container(
       decoration: BoxDecoration(
         color: Colors.grey[300],
         borderRadius: BorderRadiusDirectional.only(
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
       padding: EdgeInsets.symmetric(
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
         borderRadius: BorderRadiusDirectional.only(
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
       padding: EdgeInsets.symmetric(
         vertical: 5.0,
         horizontal: 10.0,
       ),
       child: Text(
         model.content!,
       ),
     ),
   );
}