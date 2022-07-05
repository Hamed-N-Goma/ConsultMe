import 'package:consultme/Bloc/userBloc/cubit/userlayoutcubit_cubit.dart';
import 'package:consultme/components/components.dart';
import 'package:consultme/const.dart';
import 'package:consultme/moduls/login/login_screen.dart';
import 'package:consultme/presentation_layer/presentation_layer_manager/color_manager/color_manager.dart';
import 'package:consultme/presentation_layer/user/screens/AboutAppScreen.dart';
import 'package:consultme/presentation_layer/user/screens/TechnicalSupportScreen.dart';
import 'package:consultme/presentation_layer/user/screens/TermsAndConditionsScreen.dart';
import 'package:consultme/presentation_layer/user/screens/edit_profile.dart';
import 'package:consultme/presentation_layer/user/screens/favoritescreen.dart';
import 'package:consultme/presentation_layer/user/screens/follow_request_screen.dart';
import 'package:consultme/presentation_layer/user/screens/profile.dart';
import 'package:consultme/shard/network/local/cache_helper.dart';
import 'package:consultme/shard/style/iconly_broken.dart';
import 'package:consultme/shard/style/theme/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_svg/flutter_svg.dart';

class More extends StatelessWidget {
  More({Key? key}) : super(key: key);
  var size, height, width;

  @override
  Widget build(BuildContext context) {
    var cubit = UserLayoutCubit.get(context);
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(
                height: 12.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        navigateTo(
                          context,
                          EditProfile(),
                        );
                      },
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor:
                        ThemeCubit.get(context).darkTheme
                            ? mainTextColor
                            : mainColors,
                        backgroundImage: NetworkImage(
                          '${cubit.userModel?.image}',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                        Text(
                          '${cubit.userModel?.email}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0,
                          ),
                        ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    InkWell(
                      onTap: () {
                        UserLayoutCubit.get(context).getAppoinments();
                        navigateTo(
                          context,
                          FollowRequestsScreen(),
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            'متابعه طلباتى',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          const Spacer(),
                          IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              IconBroken.Arrow___Left_2,
                              color: ThemeCubit.get(context).darkTheme
                                  ? mainTextColor
                                  : mainColors,
                            ),
                            onPressed: () {
                              // navigateTo(context, const FollowRequestsScreen());
                              //   AppCubit.get(context).getOrderData();
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Container(
                        width: double.infinity,
                        height: 1.0,
                        color: separator,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        navigateTo(
                          context,
                          FavoriteScreen(),
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            'المفضلة',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          const Spacer(),
                          IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              IconBroken.Arrow___Left_2,
                              color: ThemeCubit.get(context).darkTheme
                                  ? mainTextColor
                                  : mainColors,
                            ),
                            onPressed: () {
                              //   navigateTo(
                              //   context,
                              //    StudentRateScreen(),
                              //  );
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Container(
                        width: double.infinity,
                        height: 1.0,
                        color: separator,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        navigateTo(context, const TermsAndConditionsScreen());
                      },
                      child: Row(
                        children: [
                          Text(
                            'الشروط والأحكام',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          const Spacer(),
                          IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              IconBroken.Arrow___Left_2,
                              color: ThemeCubit.get(context).darkTheme
                                  ? mainTextColor
                                  : mainColors,
                            ),
                            onPressed: () {
                              navigateTo(
                                  context, const TechnicalSupportScreen());
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Container(
                        width: double.infinity,
                        height: 1.0,
                        color: separator,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        navigateTo(context, const TechnicalSupportScreen());
                      },
                      child: Row(
                        children: [
                          Text(
                            'الدعم الفنى',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          const Spacer(),
                          IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              IconBroken.Arrow___Left_2,
                              color: ThemeCubit.get(context).darkTheme
                                  ? mainTextColor
                                  : mainColors,
                            ),
                            onPressed: () {
                              navigateTo(
                                  context, const TechnicalSupportScreen());
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          'الوضع الليلى',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        const Spacer(),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 1000),
                          height: 30.0,
                          width: 70.0,
                          child: Stack(
                            children: [
                              AnimatedPositioned(
                                duration: const Duration(milliseconds: 1000),
                                child: InkWell(
                                  onTap: () {
                                    cubit.toggleButton();
                                    ThemeCubit.get(context).changeTheme();
                                  },
                                  child: AnimatedSwitcher(
                                    duration:
                                        const Duration(milliseconds: 1000),
                                    transitionBuilder: (Widget child,
                                        Animation<double> animation) {
                                      return RotationTransition(
                                          child: child, turns: animation);
                                    },
                                    child: ThemeCubit.get(context).darkTheme
                                        ? Icon(
                                            Icons.nightlight_round,
                                            color: Colors.white,
                                            size: 20.0,
                                            key: UniqueKey(),
                                          )
                                        : Icon(
                                            Icons.wb_sunny_sharp,
                                            color: Colors.amberAccent,
                                            size: 20.0,
                                            key: UniqueKey(),
                                          ),
                                  ),
                                ),
                                curve: Curves.easeIn,
                                top: 5.0,
                                right: ThemeCubit.get(context).darkTheme
                                    ? 40.0
                                    : 0.0,
                                left: ThemeCubit.get(context).darkTheme
                                    ? 0.0
                                    : 40.0,
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: ThemeCubit.get(context).darkTheme == true
                                ? mainColors
                                : Colors.white,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    InkWell(
                      onTap: () {
                        showDialog<void>(
                          context: context,
                          builder: (context) => AlertDialog(
                            backgroundColor: ThemeCubit.get(context).darkTheme
                                ? mainColors
                                : Colors.white,
                            content: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/warning.svg',
                                      width: 25.0,
                                      height: 25.0,
                                      alignment: Alignment.center,
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    Text(
                                      'تأكيد الخروج من الحساب ؟',
                                      textDirection: TextDirection.rtl,
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            contentPadding: EdgeInsets.zero,
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  'الغاء',
                                  textDirection: TextDirection.rtl,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  signOut(context);
                                },
                                child: Text(
                                  'تأكيد',
                                  textDirection: TextDirection.rtl,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Text(
                        'تسجيل خروج',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.red),
                      ),
                    ),
                  ],
                ),
              )
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
              Icon(icon,
                  color: ThemeCubit.get(context).darkTheme
                      ? Theme.of(context).primaryIconTheme.color
                      : Theme.of(context).iconTheme.color),
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
