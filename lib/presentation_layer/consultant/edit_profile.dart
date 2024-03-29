import 'dart:io';
import 'package:consultme/Bloc/consultantBloc/cubit/consultant_cubit.dart';
import 'package:consultme/Bloc/consultantBloc/cubit/consultant_states.dart';
import 'package:consultme/const.dart';
import 'package:consultme/main.dart';
import 'package:consultme/moduls/forget_password_screen.dart';
import 'package:consultme/presentation_layer/presentation_layer_manager/color_manager/color_manager.dart';
import 'package:consultme/shard/style/iconly_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../components/components.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var depatmentController = TextEditingController();
  var bioController = TextEditingController();

  File? imagePicker;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConsultantCubit, ConsultantStates>(
        builder: (context, state) {
          var consultantModel = ConsultantCubit.get(context).consultantModel;
          imagePicker = ConsultantCubit.get(context).profileImage;
          nameController = TextEditingController(text: consultantModel!.name);
          emailController = TextEditingController(text: consultantModel.email);
          phoneController = TextEditingController(text: consultantModel.phone);
          depatmentController = TextEditingController(text: consultantModel.department);
          bioController = TextEditingController(text: consultantModel.bio);

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
                      buildEditableProfile(context, consultantModel, imagePicker)
                    ],
                  ),
                ),
              ),
            ),
          );
        }, listener: (context, state) {
      if (state is PickedProfileImageSucsses) {
        ConsultantCubit.get(context).uploadProfile();
      }
      else if (state is UpdateConsultantInfoScusses) {
        Navigator.pop(context);
      }
      else if (state is LoadingUpdateUseInfo ) {
        ConsultantCubit.get(context).profileImage = null ;
        Navigator.pop(context);
      }
      else if (state is UpdateConsultantInfoScusses || state is LoadingWithUploadProfileimagge) {
        showDialog<void>(
            context: context,
            builder: (context)=> waitingDialog(context: context)
        );
      }else if (state is SuccessWithUploadProfileimagge ) {
        Navigator.pop(context);
      }
    });
  }

  Widget buildEditableProfile(context, consultantModel, imagePicker) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          SizedBox(
            height: 100,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < consultantModel.rating!.toInt(); i++)
                const Icon(
                  Icons.star_rounded,
                  color: Colors.indigoAccent,
                  size: 30,
                ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          NumbersWidget(),
          const SizedBox(
            height: 20,
          ),
           Column(
              children: [
                Text(
                  'السيرة الذاتية',
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline6,
                ),
                SizedBox(
                  height: 15,
                ),
                whiteBoard
                  (
                    context,
                    controller: bioController,
                    height : 150 ,
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 60,
                  child: defaultFormField(
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
                ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 60,
              child: defaultFormField(
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
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 60,
              child: defaultFormField(
                  controller: phoneController,
                  type: TextInputType.phone,
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'يجب ملئ رقم الهاتف';
                    }
                  },
                  prefix: IconBroken.Call,
                  context: context,
                  label: ' رقم الهاتف '),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 60,
              child: defaultFormField(
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
            ),
            SizedBox(
              height: 30,
            ),
              ],
            ),

           defaultButton(
              function: () {
                ConsultantCubit.get(context).upDateConsultant(
                    name: nameController.text,
                    phone: phoneController.text,
                    email: emailController.text,
                    depatment : depatmentController.text,
                    bio : bioController.text);
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
    );
  }


  Widget buildProfilePic({context, image, imagepicker}) {
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: [
        CircleAvatar(
          radius: 58,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          child: CircleAvatar(
            radius: 50.0,
            backgroundImage: imagePicker == null
                ? NetworkImage(image!)
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
class NumbersWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>  Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(
        150.0,
      ),
      border: Border.all(color: mainColors.withOpacity(0.4), width:6),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        buildButton(context,  'التقييم', '${ConsultantCubit.get(context).consultantModel!.rating}'),
        buildDivider(),
        buildButton(context, ' الطلبات' , '${ConsultantCubit.get(context).appointments!.length}'),
        buildDivider(),
        buildButton(context,  'سنين الخبرة','${ConsultantCubit.get(context).consultantModel!.yearsofExperience}'),
      ],
    ),
  );
  Widget buildDivider() => Container(
    width: 5.0,
    color: mainColors,

    child: VerticalDivider(),
  );

  Widget buildButton(BuildContext context, String value, String text) =>
      MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              value,
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyText1,
            ),
            SizedBox(height: 2),
            Text(
              text,
              style: Theme
                  .of(context)
                  .textTheme
                  .headline6,
            ),
          ],
        ),
      );
}
