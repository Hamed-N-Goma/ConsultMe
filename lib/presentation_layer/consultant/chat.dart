import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:consultme/Bloc/consultantBloc/cubit/consultant_cubit.dart';
import 'package:consultme/Bloc/consultantBloc/cubit/consultant_states.dart';
import 'package:consultme/presentation_layer/consultant/messender_main.dart';
import 'package:consultme/presentation_layer/consultant/request_appoinment_screen.dart';
import 'package:consultme/presentation_layer/presentation_layer_manager/color_manager/color_manager.dart';
import 'package:consultme/presentation_layer/user/widget/messenger_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../components/components.dart';

class ConsultChat extends StatelessWidget {
  ConsultChat({Key? key}) : super(key: key);
  var size, width, height;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConsultantCubit, ConsultantStates>(
      listener: (context, state) {},
      builder: (context, state) {
        size = MediaQuery.of(context).size;
        height = size.height;
        width = size.width;
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar:dashAppBar(
              title: 'الدردشة',
              context: context,
              pop: true,
            ),
            body: Builder(
              builder: (context) {
                  if (validation(context)) {
                    return SingleChildScrollView(
                      child: Center(
                          child: buildChatfallback(context)
                      ),
                    );
                  }
                  else {
                    return ConditionalBuilder(
                      condition: ConsultantCubit
                          .get(context)
                          .usersInChat
                          .length >= 0,
                      builder: (context) =>
                          ListView.separated(
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) =>
                                  ConsultChatitem(
                                      ConsultantCubit
                                          .get(context)
                                          .usersInChat[index], context),
                              separatorBuilder: (context, index) => myDivider(),
                              itemCount: ConsultantCubit
                                  .get(context)
                                  .usersInChat
                                  .length),
                      fallback: (context) =>
                          Center(child: buildChatfallback(context)),
                    );
                  }
              }),
          ),
        );
      },

    );
  }
}

Widget buildChatfallback(context) {
  return SizedBox(
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100.0,
                ),
                SizedBox(
                  width: double.infinity,
                  child: SvgPicture.asset(
                    'assets/images/chat.svg',
                    height: 200.0,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  '" لا توجد دردشات حاليا "',
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyText1,
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Container(
                  alignment: Alignment.center,
                  child: InkWell(
                    child: Text(
                      'عرض طلبات الإستشارة',
                      style:
                      Theme.of(context).textTheme.bodyText2!.copyWith(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    onTap: () {
                      navigateTo(
                          context,
                          RequestAppoinmentScreen());
                    },
                  ),
                ),
              ],
            ),
          ),
  );
}

validation(context) {
  if (ConsultantCubit.get(context).usersInChat.isEmpty) {
    return true;
  }
  return false;
}

Widget myDivider() => const SizedBox(
      width: double.infinity,
      height: 3.0,
    );
Widget leadingTitle(context) {
  return buildCustomText(
      text: 'إستشرني', style: Theme.of(context).textTheme.bodyLarge);
}

List<Widget> appBarItems(image) {
  return [
    IconButton(
      onPressed: () {},
      icon: const FaIcon(
        FontAwesomeIcons.bell,
        color: ColorManager.myGrey,
      ),
    ),
    InkWell(
      onTap: () {
        //  navigateTo(context, const Profile());
      },
      child: CircleAvatar(
        backgroundImage: image == null
            ? const AssetImage(
                "assets/images/user.png",
              ) as ImageProvider
            : NetworkImage(image),
        radius: 15,
      ),
    )
  ];
}
