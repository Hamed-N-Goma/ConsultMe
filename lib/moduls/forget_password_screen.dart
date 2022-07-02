
import 'package:consultme/moduls/login/cubit/cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../presentation_layer/presentation_layer_manager/color_manager/color_manager.dart';
import 'login/cubit/states.dart';

class ForgetScreen extends StatelessWidget {
  // late LoginModel loginModel;
  DateTime timeBackPressed = DateTime.now();
  var _formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();

  ForgetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _email;
    var auth = FirebaseAuth.instance.currentUser;
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (BuildContext context, state) async {

        },
        builder: (BuildContext context, Object? state) {
          var cubit = LoginCubit.get(context);
          return Directionality(
            textDirection: TextDirection.rtl,
            child: SafeArea(
              child: Scaffold(
                  body: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 80,
                            ),
                            Text(
                              'إعادة تعيين كلمة المرور',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child:  Text(
                                'Forget password',
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: TextFormField(
                                  controller: emailController,
                                  textInputAction: TextInputAction.next,
                                  style: Theme.of(context).textTheme.bodyText1,
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
                              ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25),
                              child: RoundedLoadingButton(
                                color: mainColors,
                                borderRadius: 5.0,
                                onPressed:(){
                                  LoginCubit.get(context).
                                  sendPasswordResetEmail(emailController.text);
                                  Navigator.of(context).pop();
                                },
                                controller: cubit.resetButton,
                                child: const Text(
                                  'إعادة تعيين كلمة المرور',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                            ),
                          ])
                  )
              ),
            ),
          );
        },
      ),
    );
  }


}
