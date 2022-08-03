
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultme/Bloc/consultantBloc/cubit/consultant_cubit.dart';
import 'package:consultme/Bloc/consultantBloc/cubit/consultant_states.dart';
import 'package:consultme/components/components.dart';
import 'package:consultme/const.dart';
import 'package:consultme/models/UserModel.dart';
import 'package:consultme/moduls/login/login_screen.dart';
import 'package:consultme/presentation_layer/consultant/chat.dart';
import 'package:consultme/presentation_layer/consultant/chatDetailsScreen.dart';
import 'package:consultme/presentation_layer/consultant/complaints/complaints_screen.dart';
import 'package:consultme/presentation_layer/consultant/edit_profile.dart';
import 'package:consultme/presentation_layer/consultant/news/news_screen.dart';
import 'package:consultme/presentation_layer/consultant/request_appoinment_screen.dart';
import 'package:consultme/presentation_layer/presentation_layer_manager/color_manager/color_manager.dart';
import 'package:consultme/presentation_layer/user/screens/chat.dart';
import 'package:consultme/shard/network/local/cache_helper.dart';
import 'package:consultme/shard/style/theme/cubit/cubit.dart';
import 'package:fancy_snackbar/fancy_snackbar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../moduls/signup/signup.dart';

class ConsultantHomeScreen extends StatelessWidget {
  const ConsultantHomeScreen({Key? key}) : super(key: key);

  @override
  initalMessage() async {
    var message = await FirebaseMessaging.instance.getInitialMessage();

    if (message != null) {
    }
  }



  getMessage(context) {

    late UserModel user;

    FirebaseMessaging.onMessage.listen((event) async {

      if(event.data['type'] == "appointment" ){
        await BlocProvider.of<ConsultantCubit>(context).getUserById(event.data['userId']);
        user = BlocProvider.of<ConsultantCubit>(context).user!;


        AnimatedSnackBar.rectangle(
          "${user.name}",
          "لقد تلقيت طلب إستشارة جديد ",
          type: AnimatedSnackBarType.info,
          brightness: Brightness.dark,
        ).show(
          context,
        );

        FancySnackbar.showSnackbar(
          context,
          snackBarType: FancySnackBarType.waiting,
          title: "${user.name}",
          message: "لقد تلقيت طلب إستشارة جديد , تفقد طلباتك .. ",
          duration: 4,
          onCloseEvent: () {},
        );
      }
      else if(event.data['type'] == "message" ){
        await BlocProvider.of<ConsultantCubit>(context).getUserById(event.data['userId']);
        user = BlocProvider.of<ConsultantCubit>(context).user!;
        FancySnackbar.showSnackbar(
          context,
          snackBarType: FancySnackBarType.waiting,
          title: "${user.name}",
          message: "لقد تلقيت رسالة جديدة ",
          duration: 4,
          onCloseEvent: () {},
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) async {

      if(event.data['type'] == "appointment" ){
        BlocProvider.of<ConsultantCubit>(context).getAppoinments();
        navigateTo(context, RequestAppoinmentScreen());
      }
      else if(event.data['type'] == "message" ){
        await BlocProvider.of<ConsultantCubit>(context).getUserById(event.data['userId']);
        user = BlocProvider.of<ConsultantCubit>(context).user!;
        navigateTo(context, ConsultChatDetails( User: user));
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConsultantCubit, ConsultantStates>(
      listener: (BuildContext context, state) {
          initalMessage();
          getMessage(context);
      },

      builder: (BuildContext context, state) {
        var consultantModel = ConsultantCubit.get(context).consultantModel;
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: dashAppBar(
                title: 'أهلاً بعودتك ', context: context, pop: false),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Builder(builder: (context) {
                  if (state is GetProfileConsultantLoadingStates) {
                    return const SizedBox(
                        width: double.infinity,
                        height: 300.0,
                        child: Center(child: CircularProgressIndicator()));
                  }
                  else
                  {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: InkWell(
                            onTap: () {
                              navigateTo(context, EditProfileScreen());
                            },
                            child: Row(
                              children: [
                                if ('${consultantModel?.image}' != null)
                                  CircleAvatar(
                                    radius: 60,
                                    backgroundColor:
                                        ThemeCubit.get(context).darkTheme
                                            ? mainTextColor
                                            : mainColors,
                                    backgroundImage: NetworkImage(
                                      '${consultantModel?.image}',
                                    ),
                                  ),
                                if ('${consultantModel?.image}' == null)
                                  CircleAvatar(
                                    radius: 60,
                                    backgroundColor:
                                        ThemeCubit.get(context).darkTheme
                                            ? mainTextColor
                                            : mainColors,
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 80.0,
                                      child: Icon(
                                        Icons.error,
                                        color: ThemeCubit.get(context).darkTheme
                                            ? mainColors
                                            : mainTextColor,
                                      ),
                                    ),
                                  ),
                                const SizedBox(
                                  width: 12.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${consultantModel?.name}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 2.0,
                                    ),
                                    Text(
                                      '${consultantModel?.email}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.0,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        InkWell(
                          onTap: () {
                            ConsultantCubit.get(context).getUsersChat();
                            navigateTo(context, ConsultChat());
                          },
                          child: buildOthersIten(
                              name: 'الدردشة',
                              context: context,
                              icon: FontAwesomeIcons.message,
                         ),
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),

                        InkWell(
                          onTap: () {
                            ConsultantCubit.get(context).getAppoinments();
                            navigateTo(context, RequestAppoinmentScreen());
                          },
                          child: buildOthersIten(
                              name: 'طلبات الإستشارة',
                              context: context,
                              icon: FontAwesomeIcons.phone,
                             ),
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        InkWell(
                          onTap: () {
                            ConsultantCubit.get(context).getPosts();
                            navigateTo(context, const NewsScreen());
                          },
                          child: buildOthersIten(
                              name: 'المنشورات',
                              context: context,
                              icon: FontAwesomeIcons.paperPlane,
                         ),
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        InkWell(
                          onTap: () {
                                 navigateTo(context, ComplaintsScreen());
                           },
                          child:  buildOthersIten(
                            name: 'تقديم شكوى ',
                            context: context,
                            icon: FontAwesomeIcons.reply,
                          ),
                     ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        const SizedBox(
                          height: 22.0,
                        ),
                        InkWell(
                          onTap: () {
                            showDialog<void>(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor:
                                ThemeCubit.get(context).darkTheme
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
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1,
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
                                      style:
                                      Theme.of(context).textTheme.bodyText1,
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
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                        ),
                      ],
                    );
                  }
                }),
              ),
            ),
          ),
        );
      },
    );
  }
}
