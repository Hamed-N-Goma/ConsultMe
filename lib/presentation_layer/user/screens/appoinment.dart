import 'dart:ui' as ui;
import 'package:consultme/Bloc/userBloc/cubit/userlayoutcubit_cubit.dart';
import 'package:consultme/components/components.dart';
import 'package:consultme/presentation_layer/consultant/success_screen.dart';
import 'package:consultme/presentation_layer/presentation_layer_manager/color_manager/color_manager.dart';
import 'package:consultme/presentation_layer/user/screens/follow_request_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../../../../models/consultantmodel.dart';

class appoinment extends StatelessWidget {


  final ConsultantModel cm;

  appoinment({Key? key, required this.cm}) : super(key: key);

  var reassonController = TextEditingController();
  var descController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    BlocListener<UserLayoutCubit, UserLayoutState>(
        listener: (context, state) {


        });

    return BlocBuilder<UserLayoutCubit, UserLayoutState>(
        builder: (context, state) {
          var cubit = UserLayoutCubit.get(context);

          return Directionality(
              textDirection: ui.TextDirection.rtl,
              child: Scaffold(
                  appBar: dashAppBar(
                    title: 'طلب مقابلة',
                    context: context,
                    pop: true,
                  ),
                  body: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 13.0),
                      child: Container(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20.0,),
                            Text(
                              'تعليمات الإستشارة',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText1,
                            ),
                            const SizedBox(height: 10.0,),
                            Text(
                              '.يمكن للمستخدم طلب إستشارة مع إرفاق السبب , مع إنتظار قبول الطلب  ',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                fontSize: 15.0,
                              ),
                            ),

                            const SizedBox(height: 20.0,),
                            Builder(
                                builder: (context) {
                                  return Column(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(cm.image!),
                                        //backgroundColor: Colors.lightBlue[100],
                                        radius: 80,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        cm.name!,
                                        style: Theme.of(context).textTheme.headline6,
                                      ),
                                      Text(
                                        cm.speachalist!,
                                        style: Theme.of(context).textTheme.headline6,
                                      ),
                                      const SizedBox(height: 14.0,),
                                      Container(
                                        width: double.infinity,
                                        height: 60.0,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 14.0),
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: ' سبب / نوع الإستشارة',
                                            contentPadding: EdgeInsets.all(14.0),
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
                                          controller: reassonController,
                                        ),
                                      ),
                                      const SizedBox(height: 14.0,),
                                      SizedBox(
                                        width: double.infinity,
                                        child: Text(
                                          'اكتب وصف مشكلتك ',
                                          textAlign: TextAlign.start,
                                          style: Theme.of(context).textTheme.headline6,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      whiteBoard(context, controller: descController , height : 150),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                    ],
                                  );
                                }
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25.0),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/warning.svg',
                                    width: 20.0,
                                    height: 20.0,
                                  ),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    'تحذير',
                                    style: TextStyle(
                                      color: warning,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25.0),
                              child: Container(
                                width: double.infinity,
                                height: 1.0,
                                color: warning,
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 26.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: SvgPicture.asset(
                                      'assets/images/dot.svg',
                                      width: 14.0,
                                      height: 14.0,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 6.0,
                                  ),
                                  Expanded(
                                    child: Text(
                                      ' يجب ذكر سبب الإستشارة مع وصف بسيط لمشكلتك ',
                                      style:
                                      Theme
                                          .of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 26.0),
                              child: Stack(alignment: Alignment.bottomLeft,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: SvgPicture.asset(
                                          'assets/images/dot.svg',
                                          width: 14.0,
                                          height: 14.0,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 6.0,
                                      ),
                                      Expanded(
                                        child: Text(
                                          'لن تستطيع التواصل مع المستشير الٌا في حالة قبول الطلب .. ',
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                            height: 1.5,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18.0),
                                    child: InkWell(
                                      onTap: () {
                                        UserLayoutCubit.get(context).getAppoinments();
                                        navigateTo(context, const FollowRequestsScreen());
                                      },
                                      child: Text(
                                        'متابعة الطلبات',
                                        style:
                                        Theme
                                            .of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                          height: 1.5,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            defaultButton(
                              function: () {

                                cubit.createAppoinment(
                                    consultId: cm.uid!,
                                    consultName : cm.name!,
                                    consultSp : cm.speachalist!,
                                    resson: reassonController.text,
                                    description: descController.text,
                                );
                                cubit.sendNotfiy(
                                    " لديك طلب إستشارة جديد ",
                                    " ${cubit.userModel!.name} تلقيت طلب أستشارة من ",
                                    cubit.getTokenById("${cm.uid}")!);
                              }
                              ,
                              text: 'تقديم الطلب',
                              width: double.infinity,
                              height: 47.0,
                              btnColor: mainColors,
                              marginSize: const EdgeInsets.symmetric(
                                  horizontal: 14.0),
                            ),
                            const SizedBox(height: 20.0),

                          ],
                        ),
                      ),
                    ),
                  )
              )
          );
        });
  }
}
