import 'package:consultme/presentation_layer/consultant/consultantScreen.dart';
import 'package:consultme/presentation_layer/signup/signup.dart';
import 'package:consultme/presentation_layer/user/user_layout/home_user_layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:consultme/shard/network/local/cache_helper.dart';
import 'package:consultme/shard/style/theme/cubit/cubit.dart';
import '../../components/components.dart';
import '../../presentation_layer/presentation_layer_manager/color_manager/color_manager.dart';
import '../../Bloc/login/cubit.dart';
import '../../Bloc/login/states.dart';

class LoginScreen extends StatelessWidget {
  // late LoginModel loginModel;
  DateTime timeBackPressed = DateTime.now();
  var fromKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (BuildContext context, state) async {
          if (state is UserAuthFoundedSuccess) {
            navigateAndFinish(context, UserLayout());
          } else if (state is ConsultantVeryfied) {
            navigateAndFinish(context, ConsultantScreen());
          } else if (state is ConsultantNotVeryfied) {
            showToast(
                message:
                    ' لم يتم قبولك بعد في خبراء إستشرني الرجاء الانتظار والمحاولة لاحقا ',
                state: ToastStates.WARNING);
            LoginCubit.get(context).loginbutton.stop();
          }
        },
        builder: (BuildContext context, Object? state) {
          var cubit = LoginCubit.get(context);
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
                                const EdgeInsets.symmetric(horizontal: 14.0),
                            child: Align(
                              alignment: AlignmentDirectional.topStart,
                              child: ThemeCubit.get(context).darkTheme
                                  ? Image.asset(
                                      'assets/images/logo_dark.png',
                                      width: 71.0,
                                      height: 71.0,
                                    )
                                  : Image.asset(
                                      'assets/images/logo.png',
                                      width: 71.0,
                                      height: 71.0,
                                    ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 28.0),
                            child: Column(
                              children: [
                                Align(
                                  alignment: AlignmentDirectional.center,
                                  child: SvgPicture.asset(
                                    'assets/images/login.svg',
                                    height: 227.0,
                                  ),
                                ),
                                Text(
                                  'اهلا بك في تطبيق إستشرني',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                const SizedBox(
                                  height: 33.0,
                                ),
                                TextFormField(
                                  controller: emailController,
                                  style: Theme.of(context).textTheme.bodyText1,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'الإيميل فارغ';
                                    } else {
                                      return null;
                                    }
                                  },
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
                                  obscureText: cubit.isPassword,
                                  style: Theme.of(context).textTheme.bodyText1,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'كلمة المرور فارغة !';
                                    } else {
                                      return null;
                                    }
                                  },
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
                                  height: 36.0,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 50.0,
                                  child: RoundedLoadingButton(
                                    color: mainColors,
                                    controller: cubit.loginbutton,
                                    borderRadius: 5.0,
                                    onPressed: () {
                                      if (fromKey.currentState!.validate()) {
                                        LoginCubit.get(context).login(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        );
                                      } else {
                                        LoginCubit.get(context)
                                            .loginbutton
                                            .stop();
                                      }
                                    },
                                    child: const Text(
                                      'تسجيل دخول',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 12.0,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 50.0,
                                  child: RoundedLoadingButton(
                                    color: highlightColor,
                                    controller: cubit.buttonController,
                                    borderRadius: 5.0,
                                    onPressed: () {
                                      cubit.rotationPeriod();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SignUpScreen()),
                                      );
                                    },
                                    child: const Text(
                                      'إنشاء حساب',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ),
                                ),
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
