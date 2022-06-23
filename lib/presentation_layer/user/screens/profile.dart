import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:consultme/Bloc/userBloc/cubit/userlayoutcubit_cubit.dart';
import 'package:consultme/components/components.dart';
import 'package:consultme/models/usermodel.dart';
import 'package:consultme/presentation_layer/presentation_layer_manager/color_manager/color_manager.dart';
import 'package:consultme/presentation_layer/user/screens/edit_profile.dart';
import 'package:consultme/shard/style/theme/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    BlocListener<UserLayoutCubit, UserLayoutState>(
        listener: (context, state) {});

    return BlocBuilder<UserLayoutCubit, UserLayoutState>(
      builder: (context, state) {
        var cubit = UserLayoutCubit.get(context);

        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
              appBar: dashAppBar(
                title: ' الملف الشخصي',
                context: context,
                pop: true,
              ),
              body: ConditionalBuilder(
                builder: (context) => profileWidget(context, cubit.userModel),
                condition: state != ErrorWithGetUserData,
                fallback: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              )),
        );
      },
    );
  }

  Widget profileWidget(context, usermodel) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(
            height: 190,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                buildCover(),
                buildProfilePic(context: context, image: usermodel!.image),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          buildCustomText(
            text: usermodel!.name,
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(
            height: 50,
          ),
          buildinfoItems(
              bodyText: usermodel!.email,
              context: context,
              titleText: 'البريد الإلكتروني :'),
          const SizedBox(
            height: 15,
          ),
          buildinfoItems(
              bodyText: usermodel!.phone,
              context: context,
              titleText: 'رقم الهاتف : '),
          const SizedBox(
            height: 50,
          ),
          defaultButton(
            function: () {
              navigateTo(context, EditProfile());
            },
            text: 'تعديل الملف الشخصي',
            btnColor: mainColors,
            width: double.infinity,
          ),
        ],
      ),
    );
  }

  Widget buildCover() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 140,
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(4.0), topRight: Radius.circular(4.0)),
          image: DecorationImage(
              image: NetworkImage(
                  'https://5blh.com/wp-content/uploads/2022/01/performance_1280.png'),
              fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget buildProfilePic({context, image}) {
    return CircleAvatar(
      radius: 54,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: CircleAvatar(
        radius: 50.0,
        backgroundImage: NetworkImage(image),
      ),
    );
  }

  Widget buildinfoItems(
      {required context, required titleText, required bodyText}) {
    return Row(
        children: [
      buildCustomText(
        text: titleText,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      const SizedBox(
        width: 50,
      ),
      buildCustomText(
        text: bodyText,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    ]);
  }
}
