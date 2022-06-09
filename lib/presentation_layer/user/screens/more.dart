import 'package:consultme/components/components.dart';
import 'package:consultme/presentation_layer/presentation_layer_manager/color_manager/color_manager.dart';
import 'package:consultme/presentation_layer/user/screens/profile.dart';
import 'package:consultme/shard/style/theme/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

class More extends StatelessWidget {
  More({Key? key}) : super(key: key);
  var size, height, width;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              buildOthersIten(
                  name: 'الملف الشخصي',
                  context: context,
                  icon: FontAwesomeIcons.user,
                  widgetNavigation: const Profile())
            ],
          ),
        ));
  }

  Widget buildOthersIten(
      {required name, context, required icon, required widgetNavigation}) {
    return InkWell(
      onTap: () {
        navigateTo(context, widgetNavigation);
      },
      child: Container(
        decoration: BoxDecoration(
            color: ThemeCubit.get(context).darkTheme
                ? mainColors
                : Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 3),
                  color: HexColor('#404863').withOpacity(0.2),
                  blurRadius: 10)
            ]),
        width: width,
        height: 80,
        child: Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(icon, color: Theme.of(context).primaryIconTheme.color),
              const SizedBox(
                width: 20,
              ),
              Text(
                name,
                style: Theme.of(context).textTheme.bodyLarge,
              )
            ],
          ),
        ),
      ),
    );
  }
}
