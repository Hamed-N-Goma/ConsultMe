import 'dart:ui' as ui;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:consultme/Bloc/consultantBloc/cubit/consultant_cubit.dart';
import 'package:consultme/Bloc/consultantBloc/cubit/consultant_states.dart';
import 'package:consultme/components/components.dart';
import 'package:consultme/models/AppoinmentModel.dart';
import 'package:consultme/presentation_layer/presentation_layer_manager/color_manager/color_manager.dart';
import 'package:consultme/shard/style/theme/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';


class RequestAppoinmentDetails extends StatelessWidget {

  RequestAppoinmentDetails({
    Key? key,
    required this.appoItem,
  }): super(key: key);

  AppointmentModel? appoItem;
  String? notifyToken ;

  var consultTimeController = TextEditingController();
  var consultDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConsultantCubit, ConsultantStates>(
      listener: (context, state) {

      },
      builder: (context, state) {

        DateTime tempDate = DateFormat("yyyy-MM-dd").parse(appoItem!.time!);
        String date = tempDate.toString().substring(0, 10);
        var cubit = ConsultantCubit.get(context);

        return Directionality(
          textDirection: ui.TextDirection.rtl,
          child: Scaffold(
            appBar: dashAppBar(
              title: 'الاستشارة',
              context: context,
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    smallDashBoardTitleBox(
                        svgImage: 'assets/images/call.svg',
                        title: 'طلبات الاستشارة ',
                        svg: true
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        children: [

                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'الأسم :',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: SelectableText(
                                  appoItem!.userName!,
                                  style: Theme.of(context).textTheme.bodyText1,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'البريد  :',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: SelectableText(
                                  appoItem!.userEmail!,
                                  style: Theme.of(context).textTheme.bodyText1,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),


                          //Building
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'رقم الهاتف :',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: SelectableText(
                                  appoItem!.userPhone!,
                                  style: Theme.of(context).textTheme.bodyText1,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'سبب / نوع الاستشارة :',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: SelectableText(
                                  appoItem!.resson!,
                                  style: Theme.of(context).textTheme.bodyText1,
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),

                          //request
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'تاريخ الطلب :',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: SelectableText(
                                  date,
                                  style: Theme.of(context).textTheme.bodyText1,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),

                          //request
                          const SizedBox(
                            height: 30.0,
                          ),
                          Text(
                            'وصف للمشكلة',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 20.0),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),

                          Container(
                            width: double.infinity,
                            height: 250.0,
                            decoration: BoxDecoration(
                              color:
                              ThemeCubit.get(context).darkTheme ? finesColorDark : Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(color: Colors.grey, width: 1),
                              boxShadow: [
                                BoxShadow(
                                  color: ThemeCubit.get(context).darkTheme
                                      ? Colors.black.withOpacity(0.5)
                                      : Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(5, 5), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // guest name
                                  SelectableText(
                                    appoItem!.description!,
                                    style: Theme.of(context).textTheme.bodyText1,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),


                          const SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'حدد موعد المقابلة ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 20.0),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          TextFormField(
                            textDirection: ui.TextDirection.ltr,
                            textAlign: TextAlign.end,
                            controller: consultTimeController,
                            keyboardType: TextInputType.number,
                            readOnly: true,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText:"تحديد موعد",
                              hintTextDirection: ui.TextDirection.ltr,
                              contentPadding:
                              EdgeInsets.symmetric(horizontal: 14.0),
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
                            onTap: (){
                              showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              ).then((value) {
                                if(value == null){
                                  showToast(message: 'الرجاء تحديد الوقت', state: ToastStates.WARNING);
                                }else{
                                  checkTime(
                                    h: value.hour.toString(),
                                    time: consultTimeController.text,
                                    cubit: cubit,
                                    date: consultDateController.text,
                                  );
                                  consultTimeController.text = value.format(context).toString();
                                }
                              });
                            },
                          ),

                          const SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: defaultButton(
                                  function: ()  async {
                                    cubit.acceptAppointment(
                                      MeetTime : consultTimeController.text,
                                      appoItem : appoItem!,
                                    );
                                    cubit.sendNotfiy(
                                        "${appoItem?.consultName}",
                                        "لقد تم قبول طلبك , يمكنك بدء المحادثة ",
                                        await  cubit.getTokenById("${appoItem!.userID}"),"appointment");
                                  },
                                  text: 'اوافق',
                                  btnColor: Colors.green,
                               ),
                                ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Expanded(
                                child: defaultButton(
                                  function: () {

                                    cubit.refusalAppointment(
                                      appoItem : appoItem!,
                                    );

                                  },
                                  text: 'ارفض',
                                  btnColor: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

void checkTime ({
  required h,
  required ConsultantCubit cubit,
  required String date,
  required String time,
}) {
  for (int i = 18; i < 25; i++) {
    if (h == i.toString()) {
      cubit.showStudentWarning(
        isLate: true,
      );
    }
  }
  for (int i = 1; i < 18; i++) {
    if (h == i.toString()) {
      cubit.showStudentWarning(
        isLate: false,
      );
    }
  }
}