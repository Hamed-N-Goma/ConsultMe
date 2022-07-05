import 'package:consultme/Bloc/consultantBloc/cubit/consultant_cubit.dart';
import 'package:consultme/Bloc/consultantBloc/cubit/consultant_states.dart';
import 'package:consultme/components/components.dart';
import 'package:consultme/presentation_layer/presentation_layer_manager/color_manager/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ComplaintsScreen extends StatelessWidget {

  var complaintController = TextEditingController();
   ComplaintsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConsultantCubit, ConsultantStates>(
      listener: (BuildContext context, state) {
        if(state is PostComplaintsSuccessStates){
          showToast(message: 'تم رفع الشكوى بنجاح', state: ToastStates.SUCCESS);
          complaintController.text = '';
          ConsultantCubit.get(context).getConsultantData();
        }else if(state is PostComplaintsErrorStates){
          showToast(message: 'لم يتم رفع الشكوى, الرجاء المحاولة في وقت لاحق', state: ToastStates.ERROR);
          ConsultantCubit.get(context).getConsultantData();
        }
      },
      builder: (BuildContext context, Object? state) {
        var consultantModel = ConsultantCubit.get(context).consultantModel;

        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar:dashAppBar(
              title: 'إستشرني',
              context: context,
              pop: true,
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15.0,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        'اكتب تفاصيل الشكوى',
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    whiteBoard(context, controller: complaintController),
                    const SizedBox(
                      height: 88,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: defaultButton(
                          function: (){
                            ConsultantCubit.get(context).postComplaints(
                                complaints: complaintController.text,
                                email:'${consultantModel?.email}',
                                name: '${consultantModel?.name}',
                                userType : '${consultantModel?.userType}'
                            );
                          },
                          text: 'تقديم الشكوى',
                          radius: 8.0,
                          height: 47,
                          btnColor: mainColors,
                          width: double.infinity
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
