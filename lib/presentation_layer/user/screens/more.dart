import 'package:consultme/Bloc/userBloc/cubit/userlayoutcubit_cubit.dart';
import 'package:consultme/components/components.dart';
import 'package:consultme/presentation_layer/presentation_layer_manager/color_manager/color_manager.dart';
import 'package:consultme/presentation_layer/user/screens/AboutAppScreen.dart';
import 'package:consultme/presentation_layer/user/screens/TechnicalSupportScreen.dart';
import 'package:consultme/presentation_layer/user/screens/TermsAndConditionsScreen.dart';
import 'package:consultme/presentation_layer/user/screens/profile.dart';
import 'package:consultme/shard/style/iconly_broken.dart';
import 'package:consultme/shard/style/theme/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

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
              buildOthersIten(
                  name: 'الملف الشخصي',
                  context: context,
                  icon: FontAwesomeIcons.user,
                  widgetNavigation: const Profile()),

          const SizedBox(
          height: 20.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  //AppCubit.get(context).getOrderData();
              //    navigateTo(
               //    context,
                //    const FollowRequestsScreen(),
                //  );
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
               //   navigateTo(
               //     context,
                   // StudentRateScreen(),
                //  );
                },
                child: Row(
                  children: [
                    Text(
                      'تقييم الطلاب',
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
                  navigateTo(context, AboutAppScreen());
                },
                child: Row(
                  children: [
                    Text(
                      'خدماتنا',
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
                        navigateTo(context, AboutAppScreen());
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
                          duration:
                          const Duration(milliseconds: 1000),
                          child: InkWell(
                            onTap: () {
                              cubit.toggleButton();
                              ThemeCubit.get(context).changeTheme();
                            },
                            child: AnimatedSwitcher(
                              duration: const Duration(
                                  milliseconds: 1000),
                              transitionBuilder: (Widget child,
                                  Animation<double> animation) {
                                return RotationTransition(
                                    child: child, turns: animation);
                              },
                              child:
                              ThemeCubit.get(context).darkTheme
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
                      color:
                      ThemeCubit.get(context).darkTheme == true
                          ? mainColors
                          : Colors.white,
                    ),
                  )
                ],
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
