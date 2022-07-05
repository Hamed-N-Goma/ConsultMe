import 'package:consultme/Bloc/userBloc/cubit/userlayoutcubit_cubit.dart';
import 'package:consultme/components/components.dart';
import 'package:consultme/presentation_layer/user/screens/chat.dart';
import 'package:consultme/presentation_layer/user/screens/follow_request_screen.dart';
import 'package:consultme/presentation_layer/user/screens/home.dart';
import 'package:consultme/presentation_layer/user/screens/more.dart';
import 'package:consultme/presentation_layer/user/screens/search.dart';
import 'package:consultme/shard/style/iconly_broken.dart';
import 'package:consultme/shard/style/theme/cubit/cubit.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

      print("__________________________________ message _________________________________________");
      print(message.data);
      print("__________________________________ message _________________________________________");

    }
  }

  getMessage(){
    FirebaseMessaging.onMessage.listen((event) {
         navigateTo(context, const FollowRequestsScreen());
    });
  }


  @override
  void initState() {
    initalMessage();

    getMessage();


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
            appBar:
            dashAppBar(
              title: 'إستشرني',
              context: context,
              pop: false,
              action: InkWell(
                onTap: () {
                  navigateTo(context, const Profile());
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CircleAvatar(
                    backgroundImage: model?.image == null
                        ? const AssetImage(
                      "assets/images/user.png",
                    ) as ImageProvider
                        : NetworkImage("${model?.image}"),
                    radius: 15,
                  ),
                ),
              ),
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
}
