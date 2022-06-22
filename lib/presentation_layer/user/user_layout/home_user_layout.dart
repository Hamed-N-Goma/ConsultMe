import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultme/Bloc/userBloc/cubit/userlayoutcubit_cubit.dart';
import 'package:consultme/components/components.dart';
import 'package:consultme/const.dart';
import 'package:consultme/moduls/signup/signup.dart';
import 'package:consultme/presentation_layer/user/screens/chat.dart';
import 'package:consultme/presentation_layer/user/screens/home.dart';
import 'package:consultme/presentation_layer/user/screens/more.dart';
import 'package:consultme/presentation_layer/user/screens/search.dart';
import 'package:consultme/shard/style/iconly_broken.dart';
import 'package:consultme/shard/style/theme/cubit/cubit.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../presentation_layer_manager/color_manager/color_manager.dart';
import '../screens/profile.dart';

class UserLayout extends StatefulWidget {
  const UserLayout({Key? key}) : super(key: key);

  @override
  State<UserLayout> createState() => _UserLayoutState();
}

class _UserLayoutState extends State<UserLayout> {
  List<Widget> screens = [Home(), Search(), UserChat(), More()];
  int _selectedIndex = 0;


  initalMessage() async {
    var message = await FirebaseMessaging.instance.getInitialMessage();

    if (message != null) {
      navigateTo(context, SignUpScreen);
    }
  }

  @override
  void initState() {
    initalMessage();

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      //navigateTo(context, UserChat);
    });

    FirebaseMessaging.onMessage.listen((event) {
      print(
          "================================== Notafecation ================================");
      print("${event.notification}");
      print(
          "================================== Notafecation  ==========================================");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserLayoutCubit, UserLayoutState>(
      builder: (context, state) {
        var model = UserLayoutCubit.get(context).userModel;

        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
              elevation: Theme.of(context).appBarTheme.elevation,
              foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
              title: leadingTitle(),
              actions: appBarItems(model?.image),
            ),

            //bottom navebar controller
            body: screens[_selectedIndex],

            bottomNavigationBar: Container(
              height: 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.5),
                      offset: Offset(3, 2),
                      blurRadius: 4,
                      spreadRadius: 0.5,
                    )
                  ]),
              child: GNav(
                curve: Curves.easeOutCubic,
                textStyle: Theme.of(context).textTheme.bodyText2,
                backgroundColor: ThemeCubit.get(context).darkTheme
                    ? mainColors
                    : Theme.of(context).scaffoldBackgroundColor,
                color:
                    Theme.of(context).bottomNavigationBarTheme.backgroundColor,
                activeColor: Theme.of(context)
                    .bottomNavigationBarTheme
                    .selectedItemColor,
                tabBackgroundColor: ColorManager.myBlue.withOpacity(0.5),
                padding: const EdgeInsets.all(16),
                gap: 8,
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                tabs: const [
                  GButton(
                    icon: IconBroken.Home,
                    text: 'الرئيسية',
                    gap: 8,
                  ), //home
                  GButton(
                    icon: IconBroken.Search,
                    text: 'بحث',
                  ), //search
                  GButton(
                    icon: IconBroken.Chat,
                    text: 'الرسائل',
                  ), //chat
                  GButton(
                    icon: IconBroken.More_Square,
                    text: 'أخري',
                  ) //more
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget leadingTitle() {
    return Text(
      'إستشرني',
      style: Theme.of(context).textTheme.bodyText1,
    );
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
          navigateTo(context, const Profile());
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
}
