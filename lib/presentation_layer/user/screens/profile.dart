import 'package:consultme/Bloc/user/cubit/userlayoutcubit_cubit.dart';
import 'package:consultme/components/components.dart';
import 'package:consultme/models/usermodel.dart';
import 'package:consultme/presentation_layer/presentation_layer_manager/color_manager/color_manager.dart';
import 'package:consultme/presentation_layer/user/screens/edit_profile.dart';
import 'package:consultme/shard/style/theme/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel? usermodel;

    BlocListener<UserLayoutCubit, UserLayoutState>(
        listener: (context, state) {});

    return BlocBuilder<UserLayoutCubit, UserLayoutState>(
      builder: (context, state) {
        usermodel = UserLayoutCubit.get(context).userModel;

        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
              appBar: AppBar(
                title: Text('Profile',
                    style: Theme.of(context).textTheme.bodyLarge),
                centerTitle: true,
                elevation: 5,
              ),
              body: ConditionalBuilder(
                builder: (context) => profileWidget(context, usermodel),
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
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(
            height: 20,
          ),
          buildinfoItems(
              bodyText: usermodel!.email,
              context: context,
              titleText: 'البريد الإلكتروني :'),
          const SizedBox(
            height: 10,
          ),
          buildinfoItems(
              bodyText: usermodel!.phone,
              context: context,
              titleText: 'رقم الهاتف : '),
          const SizedBox(
            height: 15,
          ),
          OutlineButton(
            onPressed: () {
              navigateTo(context, EditProfile());
            },
            child: Text(
              'تعديل الملف الشخصي',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            borderSide: BorderSide(
              color:
                  ThemeCubit.get(context).darkTheme ? Colors.white : mainColors,
            ),
          )
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
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      buildCustomText(
        text: titleText,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      const SizedBox(
        width: 20,
      ),
      buildCustomText(
        text: bodyText,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    ]);
  }
}
