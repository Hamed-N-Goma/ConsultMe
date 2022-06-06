import 'package:consultme/const.dart';
import 'package:consultme/presentation_layer/presentation_layer_manager/color_manager/color_manager.dart';
import 'package:consultme/presentation_layer/presentation_layer_manager/font_manager/fontmanager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatDetails extends StatelessWidget {
  const ChatDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorManager.myBlue.withOpacity(0.5),
          titleSpacing: 0,
          title: buildAppbarTitle(context),
          actions: actionsAppBar(),
        ),
        body: buildMessageStructure(),
      ),
    );
  }
  //you must send user Model with Navigation

  Widget buildAppbarTitle(context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20.0,
          backgroundImage: NetworkImage(profileImageUri),
        ),
        SizedBox(
          width: 15.0,
        ),
        Text(
          'عبدالله منصور',
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

  Widget buildMessageStructure() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(10),
                  topEnd: Radius.circular(10),
                  topStart: Radius.circular(10),
                ),
              ),
              padding: EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 10.0,
              ),
              child: Text("مرحبا"),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Container(
              decoration: BoxDecoration(
                color: ColorManager.myBlue.withOpacity(0.2),
                borderRadius: BorderRadiusDirectional.only(
                  bottomStart: Radius.circular(10),
                  topEnd: Radius.circular(10),
                  topStart: Radius.circular(10),
                ),
              ),
              padding: EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 10.0,
              ),
              child: Text("مرحبا"),
            ),
          ),
          Spacer(),
          Container(
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(15.0),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "  اكتب رسالتك هنا",
                    ),
                  ),
                ),
                Container(
                  color: ColorManager.myBlue.withOpacity(0.8),
                  height: 52.0,
                  child: MaterialButton(
                    onPressed: () {},
                    minWidth: 1,
                    child: Icon(
                      FontAwesomeIcons.paperPlane,
                      color: ColorManager.myWhite,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
