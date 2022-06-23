import 'dart:io';
import 'package:consultme/Bloc/userBloc/cubit/userlayoutcubit_cubit.dart';
import 'package:consultme/shard/style/iconly_broken.dart';
import 'package:consultme/shard/style/theme/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../components/components.dart';
import '../../presentation_layer_manager/color_manager/color_manager.dart';

class EditProfile extends StatelessWidget {
  EditProfile({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  File? imagePicker;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserLayoutCubit, UserLayoutState>(
        builder: (context, state) {
      var usermodel = UserLayoutCubit.get(context).userModel;
      imagePicker = UserLayoutCubit.get(context).profileImage;
      nameController = TextEditingController(text: usermodel!.name);
      emailController = TextEditingController(text: usermodel!.email);
      phoneController = TextEditingController(text: usermodel!.phone);
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: dashAppBar(
            title: 'تعديل الملف الشخصي',
            context: context,
            pop: true,
        ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                if (state is LoadingUpdateUseInfo) LinearProgressIndicator(),
                SizedBox(
                  height: 10,
                ),
                buildEditableProfile(context, usermodel, imagePicker)
              ],
            ),
          ),
        ),
      );
    }, listener: (context, state) {
      if (state is PickedProfileImageSucsses) {
        UserLayoutCubit.get(context).uploadProfile();
      }
    });
  }

  Widget buildEditableProfile(context, usermodel, imagePicker) {
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
                buildProfilePic(
                    context: context,
                    image: usermodel!.image,
                    imagepicker: imagePicker),
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
            height: 20,
          ),
          defaultFormField(
              controller: nameController,
              type: TextInputType.name,
              validate: (String value) {
                if (value.isEmpty) {
                  return 'يجب ملئ الإسم';
                }
              },
              prefix: IconBroken.User,
              context: context,
              label: "الإسم كامل"),
          const SizedBox(
            height: 20,
          ),
          defaultFormField(
              controller: emailController,
              type: TextInputType.emailAddress,
              validate: (String value) {
                if (value.isEmpty) {
                  return 'يجب ملئ البريد الالكتروني';
                }
              },
              prefix: IconBroken.Message,
              context: context,
              label:  'البريد الالكتروني'),
          const SizedBox(
            height: 20,
          ),
          defaultFormField(
              controller: phoneController,
              type: TextInputType.phone,
              validate: (String value) {
                if (value.isEmpty) {
                  return 'يجب ملئ رقم الهاتف';
                }
              },
              prefix: IconBroken.Call,
              context: context,
              label:  'رقم الهاتف'),
           SizedBox(
            height: 30,
          ),

          defaultButton(
            function: () {
              UserLayoutCubit.get(context).upDateUser(
                  name: nameController.text,
                  phone: phoneController.text,
                  email: emailController.text);
            },
            text: 'تعديل ',
            fontSize: 18,
            height: 60.0,
            btnColor: mainColors,
            width: double.infinity,
          ),
          SizedBox(
            height: 20,
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

  Widget buildProfilePic({context, image, imagepicker}) {
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: [
        CircleAvatar(
          radius: 54,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          child: CircleAvatar(
            radius: 50.0,
            backgroundImage: imagePicker == null
                ? NetworkImage(image)
                : FileImage(imagepicker) as ImageProvider,
          ),
        ),
        IconButton(
          onPressed: () async {
            UserLayoutCubit.get(context).getProfileImage();
          },
          icon: const CircleAvatar(
            child: Icon(IconBroken.Camera),
            radius: 16.0,
          ),
        ),
      ],
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
    ]);
  }
}
