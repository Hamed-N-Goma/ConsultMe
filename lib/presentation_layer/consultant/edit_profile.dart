import 'dart:io';
import 'package:consultme/Bloc/consultantBloc/cubit/consultant_cubit.dart';
import 'package:consultme/Bloc/consultantBloc/cubit/consultant_states.dart';
import 'package:consultme/presentation_layer/presentation_layer_manager/color_manager/color_manager.dart';
import 'package:consultme/shard/style/iconly_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../components/components.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var depatmentController = TextEditingController();

  File? imagePicker;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConsultantCubit, ConsultantStates>(
        builder: (context, state) {
          var consultantModel = ConsultantCubit.get(context).consultantModel;
          imagePicker = ConsultantCubit.get(context).profileImage;
          nameController = TextEditingController(text: consultantModel!.name);
          emailController = TextEditingController(text: consultantModel!.email);
          phoneController = TextEditingController(text: consultantModel!.phone);
          depatmentController = TextEditingController(text: consultantModel!.department);
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
                    buildEditableProfile(context, consultantModel, imagePicker)
                  ],
                ),
              ),
            ),
          );
        }, listener: (context, state) {
      if (state is PickedProfileImageSucsses) {
        ConsultantCubit.get(context).uploadProfile();
      }
    });
  }

  Widget buildEditableProfile(context, consultantModel, imagePicker) {
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
                    image: consultantModel!.image,
                    imagepicker: imagePicker),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          buildCustomText(
            text: consultantModel!.name,
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(
            height: 20,
          ),
          defaultFormField(
              controller: nameController,
              type: TextInputType.text,
              validate: (String value) {
                if (value.isEmpty) {
                  return 'يجب ملئ الإسم';
                }
              },
              prefix: IconBroken.User,
              context: context,
              label: 'الإسم'),
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
              label: 'البريد الالكتروني'),
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
              label: 'المجال '),
          const SizedBox(
            height: 20,
          ),
          defaultFormField(
              controller: depatmentController,
              type: TextInputType.text,
              validate: (String value) {
                if (value.isEmpty) {
                  return 'يجب ملئ المجال';
                }
              },
              prefix: IconBroken.Work,
              context: context,
              label: 'المجال'),
          SizedBox(
            height: 30,
          ),

          defaultButton(
            function: () {
              ConsultantCubit.get(context).upDateConsultant(
                  name: nameController.text,
                  phone: phoneController.text,
                  email: emailController.text,
                  depatment : depatmentController.text);
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
            ConsultantCubit.get(context).getProfileImage();
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
