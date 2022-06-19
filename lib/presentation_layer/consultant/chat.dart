import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:consultme/Bloc/consultantBloc/cubit/consultant_cubit.dart';
import 'package:consultme/Bloc/consultantBloc/cubit/consultant_states.dart';
import 'package:consultme/presentation_layer/consultant/messender_main.dart';
import 'package:consultme/presentation_layer/presentation_layer_manager/color_manager/color_manager.dart';
import 'package:consultme/presentation_layer/user/widget/messenger_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            appBar: AppBar(
              iconTheme: Theme.of(context).iconTheme,
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
              elevation: 1,
              foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
              title: leadingTitle(context),
              // actions: appBarItems(model?.image),
            ),
            body: ConditionalBuilder(
              condition: ConsultantCubit.get(context).usersInChat.length >= 0,
              builder: (context) => ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => ConsultChatitem(
                      ConsultantCubit.get(context).usersInChat[index], context),
                  separatorBuilder: (context, index) => myDivider(),
                  itemCount: ConsultantCubit.get(context).usersInChat.length),
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
          ),
        );
      },
    );
  }
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
