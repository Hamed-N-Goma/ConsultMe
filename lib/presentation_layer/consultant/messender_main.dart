import 'package:consultme/components/components.dart';
import 'package:consultme/models/UserModel.dart';
import 'package:consultme/presentation_layer/consultant/chatDetailsScreen.dart';
import 'package:consultme/presentation_layer/presentation_layer_manager/color_manager/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../shard/style/theme/cubit/cubit.dart';

class ConsultChatitem extends StatelessWidget {
  ConsultChatitem(UserModel this.User, BuildContext context, {Key? key})
      : super(key: key);
  var size, width, height;

  UserModel User;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return InkWell(
      onTap: () {
        navigateTo(
            context,
            ConsultChatDetails(
              User: User,
            ));
      },
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 5,
          bottom: 5,
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          height: 120,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserImage(),
              SizedBox(width: width * 0.03),
              UserDetales(height, context),
            ],
          ),
        ),
      ),
    );
  }
  ///////
  ///Widgets
  /////

  Widget UserImage() {
    return CircleAvatar(
      backgroundColor: Colors.black,
      radius: 40,
      backgroundImage: NetworkImage(
        '${User.image!}',
      ),
    );
  }

  Widget UserDetales(double height, context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${User.name}',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Text(
          '${User.email}',
          style: Theme.of(context).textTheme.bodyText2,
        ),

      ],
    );
  }
}
