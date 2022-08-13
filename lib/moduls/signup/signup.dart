import 'package:consultme/moduls/login/login_screen.dart';
import 'package:consultme/moduls/signup/cubit/cubit.dart';
import 'package:consultme/moduls/signup/cubit/states.dart';
import 'package:consultme/shard/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../presentation_layer/presentation_layer_manager/color_manager/color_manager.dart';
import 'package:consultme/shard/style/theme/cubit/cubit.dart';

import '../../components/components.dart';

class SignUpScreen extends StatelessWidget {
//  late LoginModel loginModel;
  DateTime timeBackPressed = DateTime.now();
  var fromKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var yearsOfExperiance = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var careerField = TextEditingController();
  var emailController = TextEditingController();
  var reasonController = TextEditingController();
  var consultSeptalistController = TextEditingController();

  SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SignUpCubit()..GetCategory(),
      child: BlocConsumer<SignUpCubit, SignUpStates>(
        listener: (BuildContext context, state) async {
          if (state is UserCreatedSucsess) {
            showToast(
              message: 'تم الستجيل بنجاح يمكنك تسجيل الدخول',
              state: ToastStates.SUCCESS,
            );
            navigateTo(context, LoginScreen());
          } else if (state is ConsultentCreatedSucsess) {
            showToast(
              message:
                  'تم إرسال بياناتك بنجاح يرجي الانظار حتي يتم مراجعة طلبك والمحاولة لاحقآ',
              state: ToastStates.SUCCESS,
            );
            navigateTo(context, LoginScreen());
          } else if (state is UserCreatedError ||
              state is ConsultantCreatedError ||
              state is ErrorWithSignup) {
            showToast(
              message: 'هناك خطأ  ! تأكد من صحة البيانات او انك غير مسجل مسبقا',
              state: ToastStates.WARNING,
            );
            SignUpCubit.get(context).buttonController.stop();
          }
        },
        builder: (BuildContext context, state) {
          var cubit = SignUpCubit.get(context);
          return Directionality(
            textDirection: TextDirection.rtl,
            child: SafeArea(
              child: Scaffold(
                body: WillPopScope(
                  onWillPop: () async {
                    final difference =
                        DateTime.now().difference(timeBackPressed);
                    final isExitWarning =
                        difference >= const Duration(seconds: 2);
                    timeBackPressed = DateTime.now();
                    if (isExitWarning) {
                      showToast(
                          message: 'اضغط مرة أخرى للخروج من البرنامج',
                          state: ToastStates.WARNING);
                      return false;
                    } else {
                      return true;
                    }
                  },
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Form(
                      key: fromKey,
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 28.0),
                            child: Column(
                              children: [
                                Text(
                                  'اهلا بك في تطبيق إستشرني',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                const SizedBox(
                                  height: 33.0,
                                ),
                                TextFormField(
                                  controller: nameController,
                                  style: Theme.of(context).textTheme.bodyText1,
                                  validator: nameValidator,
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.all(10.0),
                                    border: OutlineInputBorder(),
                                    hintText: 'الإسم كامل',
                                    hintStyle: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.grey,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 12.0,
                                ),
                                TextFormField(
                                  controller: emailController,
                                  style: Theme.of(context).textTheme.bodyText1,
                                  validator: emailValidator,
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.all(10.0),
                                    border: OutlineInputBorder(),
                                    hintText: 'البريد الإلكتروني',
                                    hintStyle: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.grey,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 12.0,
                                ),
                                TextFormField(
                                  controller: passwordController,
                                  keyboardType: TextInputType.visiblePassword,
                                  style: Theme.of(context).textTheme.bodyText1,
                                  obscureText: cubit.isPassword,
                                  validator: passwordValidator,
                                  decoration: InputDecoration(

                                    isDense: true,
                                    contentPadding: const EdgeInsets.all(10.0),
                                    suffixIcon: IconButton(
                                      color: Colors.grey,
                                      onPressed: () {
                                        cubit.changePasswordVisibility();
                                      },
                                      icon: Icon(
                                        cubit.suffix,
                                      ),
                                    ),

                                    border: const OutlineInputBorder(),
                                    hintText: 'كلمه المرور',
                                    hintStyle: const TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.grey,
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 12.0,
                                ),
                                TextFormField(
                                  controller: phoneController,
                                  style: Theme.of(context).textTheme.bodyText1,
                                  validator: phoneNumberValidator,
                                  decoration: InputDecoration(

                                    isDense: true,
                                    contentPadding: const EdgeInsets.all(10.0),
                                    border: const OutlineInputBorder(),
                                    hintText: 'رقم الهاتف',
                                    hintStyle: const TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.grey,
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 20.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap:(){
                                          cubit.changeIsReason(true);
                                        },
                                        child: SizedBox(
                                          width: 10.0,
                                          height: 10.0,
                                          child: Radio(
                                            value: true,
                                            splashRadius: 100,
                                            groupValue: cubit.isConsultant,
                                            activeColor:
                                                ThemeCubit.get(context).darkTheme
                                                    ? mainTextColor
                                                    : mainColors,
                                            focusColor:
                                                ThemeCubit.get(context).darkTheme
                                                    ? mainTextColor
                                                    : mainColors,
                                            onChanged: (value) {
                                              cubit.changeIsReason(true);
                                            },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8.0,
                                      ),
                                     InkWell(
                                       onTap:(){
                                        cubit.changeIsReason(true);
                                       },
                                         child: Text(
                                          ' مستخدم',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 30.0,
                                      ),
                                      SizedBox(
                                          width: 10.0,
                                          height: 10.0,
                                          child: Radio(
                                            value: false,
                                            groupValue: cubit.isConsultant,
                                            splashRadius: 100,
                                            activeColor:
                                                ThemeCubit.get(context).darkTheme
                                                    ? mainTextColor
                                                    : mainColors,
                                            focusColor:
                                                ThemeCubit.get(context).darkTheme
                                                    ? mainTextColor
                                                    : mainColors,
                                            hoverColor:
                                                ThemeCubit.get(context).darkTheme
                                                    ? mainTextColor
                                                    : mainColors,
                                            onChanged: (value) {
                                              cubit.changeIsReason(false);
                                            },
                                          ),
                                        ),

                                      const SizedBox(
                                        width: 8.0,
                                      ),
                                      InkWell(
                                        onTap:(){
                                          cubit.changeIsReason(false);
                                        },
                                        child: Text(
                                          'خبير',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Builder(builder: (context) {
                                  if (cubit.isConsultant) {
                                    return const SizedBox(
                                      height: 1.0,
                                    );
                                  } else {
                                    return Column(children: [
                                      Container(
                                        width: double.infinity,
                                        height: 45.0,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            8.0,
                                          ),
                                          border: Border.all(
                                              color: Colors.grey, width: 1),
                                        ),
                                        child: TextFormField(
                                          validator: (String? value) {
                                            if (value == null || value.isEmpty) {
                                              showToast(
                                                  message: 'الرجاء اختيار تخصصك الوظيفي ! ', state: ToastStates.ERROR);
                                            }
                                            return null;
                                          },
                                          controller:
                                              consultSeptalistController,
                                          readOnly: true,
                                          onTap: () {
                                            showDialog<void>(
                                              context: context,
                                              builder: (context) => buildDialog(
                                                context: context,
                                                title:
                                                    'اختر التخصص / المسمى الوظيفي ',
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: cubit.dept
                                                      .map((e) => RadioListTile(
                                                            activeColor: ThemeCubit
                                                                        .get(
                                                                            context)
                                                                    .darkTheme
                                                                ? mainTextColor
                                                                : backGroundDark,
                                                            tileColor:
                                                                backGroundDark,
                                                            title: Text(
                                                              e.name,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText1!,
                                                            ),
                                                            groupValue:
                                                                cubit.currVal,
                                                            value: e.index,
                                                            onChanged:
                                                                (int? val) {
                                                              cubit.changeDept(
                                                                  val!, e.name);
                                                              consultSeptalistController
                                                                      .text =
                                                                  cubit
                                                                      .currText;
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          ))
                                                      .toList(),
                                                ),
                                              ),
                                            );
                                          },
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            suffixIcon: Icon(
                                              Icons.keyboard_arrow_down,
                                              color: ThemeCubit.get(context)
                                                      .darkTheme
                                                  ? mainTextColor
                                                  : Colors.black38,
                                            ),
                                            hintText: 'التخصص',
                                            hintStyle: const TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.grey,
                                            ),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 14.0),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 12.0,
                                      ),
                                      TextFormField(
                                        controller: careerField,
                                        keyboardType: TextInputType.text,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                        validator: notEmptyValidator,
                                        decoration: const InputDecoration(
                                          isDense: true,
                                          contentPadding: EdgeInsets.all(10.0),
                                          border: OutlineInputBorder(),
                                          hintText: 'المجال',
                                          hintStyle: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.grey,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 12.0,
                                      ),
                                      TextFormField(
                                        controller: yearsOfExperiance,
                                        keyboardType: TextInputType.number,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                        validator: (String? value) {
                                          if (value!.isEmpty) {
                                            return 'عدد السنوات فارغ !';
                                          } else {
                                            return null;
                                          }
                                        },
                                        decoration: const InputDecoration(
                                          isDense: true,
                                          contentPadding: EdgeInsets.all(10.0),
                                          border: OutlineInputBorder(),
                                          hintText: 'عدد سنوات الخبرة',
                                          hintStyle: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.grey,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 12.0,
                                      ),
                                      Builder(builder: (context) {
                                        if (cubit.certificateImage != null) {
                                          return Stack(
                                            alignment:
                                                AlignmentDirectional.topEnd,
                                            children: [
                                              Stack(
                                                alignment:
                                                    AlignmentDirectional.center,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 18.0),
                                                    child: Container(
                                                      width: double.infinity,
                                                      height: 280.0,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          8.0,
                                                        ),
                                                        image: DecorationImage(
                                                          image: FileImage(cubit
                                                              .certificateImage!),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    height: 288.0,
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 14.0),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      border: Border.all(
                                                          color: Colors.grey,
                                                          width: 1),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16.0,
                                                        vertical: 3.0),
                                                child: IconButton(
                                                  onPressed: () {
                                                    cubit.removePikeImage();
                                                  },
                                                  icon: const CircleAvatar(
                                                    radius: 20.0,
                                                    child: Icon(
                                                      Icons.close,
                                                      size: 16.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        } else {
                                          return Container(
                                            width: double.infinity,
                                            height: 45.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                8.0,
                                              ),
                                              border: Border.all(
                                                  color: Colors.grey, width: 1),
                                            ),
                                            child: TextFormField(
                                              validator: (String? value) {
                                                if (value == null || value.isEmpty) {
                                                  showToast(
                                                      message: 'الرجاء اختيار صورة شهادتك او مؤهلك الوظيفي ! ', state: ToastStates.ERROR);
                                                }
                                                return null;
                                              },
                                              onTap: () {
                                                cubit.pikeBuildingImage();
                                              },
                                              decoration: InputDecoration(
                                                suffixIcon: IconButton(
                                                  onPressed: () {
                                                    cubit.pikeBuildingImage();
                                                  },
                                                  icon: SvgPicture.asset(
                                                    'assets/images/upload.svg',
                                                    alignment: Alignment.center,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                border: InputBorder.none,
                                                hintText: 'صورة من الشهادة',
                                                hintStyle: const TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.grey,
                                                ),
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 14.0),
                                              ),
                                            ),
                                          );
                                        }
                                      }),
                                    ]);
                                  }
                                }),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 50.0,
                                  child: RoundedLoadingButton(
                                    color: mainColors,
                                    controller: cubit.buttonController,
                                    borderRadius: 5.0,
                                    onPressed: () {
                                      if (fromKey.currentState!.validate()) {
                                        SignUpCubit.get(context).auth(
                                            name: nameController.text,
                                            phone: phoneController.text,
                                            email: emailController.text,
                                            password: passwordController.text,
                                            speachalist:
                                                consultSeptalistController.text,
                                            department: careerField.text,
                                            yearsofExperience:
                                                yearsOfExperiance.text);
                                      } else {
                                        cubit.buttonController.stop();
                                      }
                                    },
                                    child: const Text(
                                      'تسجيل ',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'لديك حساب ؟ ',
                                        style: TextStyle(
                                          fontSize: 15.0,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          navigateTo(context, LoginScreen());
                                        },
                                        child: Text(
                                          'تسجيل دخول ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.0,
                                              ),
                                        ),
                                      ),
                                    ]),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class SelectDept {
  late String name;
  late int index;

  SelectDept({
    required this.name,
    required this.index,
  });
}
