import 'package:consultme/Bloc/consultantBloc/cubit/consultant_cubit.dart';
import 'package:consultme/components/components.dart';
import 'package:consultme/models/UserModel.dart';
import 'package:consultme/presentation_layer/consultant/chatDetailsScreen.dart';
import 'package:consultme/presentation_layer/presentation_layer_manager/color_manager/color_manager.dart';
import 'package:consultme/presentation_layer/user/screens/chatDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../const.dart';
import '../../../models/consultantmodel.dart';
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
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          height: height * 0.14,
          width: width,
          decoration: BoxDecoration(
            color: ThemeCubit.get(context).darkTheme
                ? mainColors
                : Theme.of(context).highlightColor.withOpacity(0.3),
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
        SizedBox(
          height: 8,
        ),
        Text(
          '${User.name}',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          '${ ConsultantCubit.get(context).messages.last.content}',
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }
}
