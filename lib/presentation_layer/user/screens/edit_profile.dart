import 'dart:io';
import 'package:consultme/Bloc/userBloc/cubit/userlayoutcubit_cubit.dart';
import 'package:consultme/moduls/forget_password_screen.dart';
import 'package:consultme/shard/style/iconly_broken.dart';
import 'package:consultme/shard/style/theme/cubit/cubit.dart';
import 'package:consultme/shard/utils/validators.dart';
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
      emailController = TextEditingController(text: usermodel.email);
      phoneController = TextEditingController(text: usermodel.phone);
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: dashAppBar(
            title: 'تعديل الملف الشخصي',
            context: context,
            pop: true,
        ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state is LoadingUpdateUseInfo) LinearProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: buildEditableProfile(context, usermodel, imagePicker),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }, listener: (context, state) {
      if (state is PickedProfileImageSucsses) {
        UserLayoutCubit.get(context).uploadProfile();
      }
      else if (state is LoadingUpdateUseInfo ) {
        UserLayoutCubit.get(context).profileImage = null ;
        Navigator.pop(context);
      }
      else if (state is UpdateUserInfoScusses || state is LoadingWithUploadProfileimagge) {
        showDialog<void>(
            context: context,
            builder: (context)=> waitingDialog(context: context)
        );
      }else if (state is SuccessWithUploadProfileimagge ) {
        Navigator.pop(context);
      }
    });
  }

  Widget buildEditableProfile(context, usermodel, imagePicker) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 120,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  buildProfilePic(
                      context: context,
                      image: usermodel!.image,
                      imagepicker: imagePicker),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            buildCustomText(
              text: usermodel!.email,
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 70,
              child: defaultFormField(
                  controller: nameController,
                  type: TextInputType.name,
                  validate: nameValidator,
                  prefix: IconBroken.User,
                  context: context,
                  label: "الإسم كامل"),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 70,
              child: defaultFormField(
                  controller: emailController,
                  type: TextInputType.emailAddress,
                  validate: emailValidator,
                  prefix: IconBroken.Message,
                  context: context,
                  label:  'البريد الالكتروني'),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 70,
              child: defaultFormField(
                  controller: phoneController,
                  type: TextInputType.phone,
                  validate: phoneNumberValidator,
                  prefix: IconBroken.Call,
                  context: context,
                  label:  'رقم الهاتف'),
            ),
             SizedBox(
              height: 30,
            ),

            defaultButton(
              function: () {
                UserLayoutCubit.get(context).upDateUser(
                    name: nameController.text,
                    phone: phoneController.text,
                    email: emailController.text,
                );
              },
              text: 'تعديل ',
              fontSize: 15,
              height: 50.0,
              btnColor: mainColors,
              width: double.infinity,
            ),
            SizedBox(
              height: 10,
            ),
            defaultButton(
              function: () {
                navigateAndFinish(context, ForgetScreen());
              },
              text: 'إعادة تعيين كلمة المرور ',
              fontSize: 15,
              height: 50.0,
              btnColor: highlightColor,
              width: double.infinity,
            ),
          ],
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
            radius: 100.0,
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
