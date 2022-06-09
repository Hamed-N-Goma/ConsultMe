import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:consultme/Bloc/user/cubit/userlayoutcubit_cubit.dart';
import 'package:consultme/components/components.dart';
import 'package:consultme/presentation_layer/presentation_layer_manager/font_manager/fontmanager.dart';
import 'package:consultme/presentation_layer/user/screens/chat.dart';
import 'package:consultme/presentation_layer/user/screens/home.dart';
import 'package:consultme/presentation_layer/user/screens/more.dart';
import 'package:consultme/presentation_layer/user/screens/search.dart';
import 'package:consultme/presentation_layer/user/widget/category.dart';
import 'package:consultme/presentation_layer/user/widget/mostimportant.dart';
import 'package:consultme/presentation_layer/user/widget/toprated.dart';
import 'package:consultme/shard/style/iconly_broken.dart';
import 'package:consultme/shard/style/theme/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../presentation_layer_manager/color_manager/color_manager.dart';
import '../screens/profile.dart';

class UserLayout extends StatefulWidget {
  const UserLayout({Key? key}) : super(key: key);

  @override
  State<UserLayout> createState() => _UserLayoutState();
}

class _UserLayoutState extends State<UserLayout> {
  List<Widget> screens = [const Home(), const Search(), Chat(), More()];
  int _selectedIndex = 0;

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
                    icon: FontAwesomeIcons.houseUser,
                    text: 'الرئيسية',
                    gap: 8,
                  ), //home
                  GButton(
                    icon: FontAwesomeIcons.magnifyingGlass,
                    text: 'بحث',
                  ), //search
                  GButton(
                    icon: FontAwesomeIcons.comments,
                    text: 'الرسائل',
                  ), //chat
                  GButton(
                    icon: FontAwesomeIcons.listUl,
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
              ? const AssetImage("assets/images/user.png") as ImageProvider
              : NetworkImage(image),
          radius: 15,
        ),
      )
    ];
  }
}
