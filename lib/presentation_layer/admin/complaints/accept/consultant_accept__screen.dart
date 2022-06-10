import 'dart:ui' as ui;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:consultme/Bloc/adminBloc/cubit/admin_cubit.dart';
import 'package:consultme/Bloc/adminBloc/cubit/admin_states.dart';
import 'package:consultme/Bloc/consultantBloc/cubit/consultant_states.dart';
import 'package:consultme/components/components.dart';
import 'package:consultme/models/ConsultantModel.dart';
import 'package:consultme/presentation_layer/presentation_layer_manager/color_manager/color_manager.dart';
import 'package:consultme/shard/style/theme/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AcceptedConsultantsScreen extends StatelessWidget {
  AcceptedConsultantsScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {
        if(state is PutStudentLoadingStates || state is DeleteStudentLoadingStates){
          showDialog<void>(
              context: context,
              builder: (context)=> waitingDialog(context: context)
          );
        }else if(state is PutStudentSuccessStates ){
          Navigator.pop(context);
          showToast(message: 'تم التعديل بنجاح', state: ToastStates.SUCCESS);
        }else if(state is DeleteStudentSuccess){
          Navigator.pop(context);
          showToast(message: 'تم الحذف بنجاح', state: ToastStates.SUCCESS);
        }
      },
      builder: (context, state) {
        var cubit = AdminCubit.get(context);
        return Directionality(
          textDirection: ui.TextDirection.rtl,
          child: Scaffold(
            appBar: dashAppBar(
              title: 'إدارة الخبراء',
              context: context,
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultDashBoardTitleBox(
                        svgImage:  'assets/images/check.svg',
                        svg: true,
                        title: ' مقيدين بالنظام '),

                    const SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      width: double.infinity,
                      height: 1.0,
                      color: separator,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),

                    Builder(
                        builder: (context){
                          if(state is GetAllUsersLoadingStates){
                            return const SizedBox(
                                width:double.infinity,
                                height: 300.0,
                                child: Center(child: CircularProgressIndicator()));
                          }else if (cubit.accepted_consultant!.isEmpty){
                            return Text(
                              'لا يوجد بيانات حاليا !!',
                              style: Theme.of(context).textTheme.bodyText1,
                              textAlign: TextAlign.center,
                            );
                          }else{
                            return ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) => ConsultantItem(
                                item:  cubit.accepted_consultant![index],
                                index: index,
                                context: context,
                                cubit: cubit,
                              ),
                              separatorBuilder: (context, index) => Container(
                                margin: const EdgeInsets.symmetric(vertical: 10.0),
                                width: double.infinity,
                                height: 1.0,
                                color: separator,
                              ),
                              itemCount: cubit.accepted_consultant!.length,
                            );
                          }
                        }),

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

Widget ConsultantItem({
  required context,
  required AdminCubit cubit,
  required ConsultantModel item,
  required int index,

}) {

  return Builder(
      builder: (context){
        if(cubit.showWaitingStudent_details==true){
          return Card(
            color: ThemeCubit.get(context).darkTheme ? backGroundDark : backGround,
            elevation: 0.0,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${item.name}',
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${item.email}',
                        style: Theme.of(context).textTheme.bodyText1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    if (cubit.showWaitingStudent_details == false ||
                        cubit.currentWaitingStudentIndex != index)
                      SizedBox(
                        width: 30.0,
                        height: 30.0,
                        child: IconButton(
                          onPressed: () {
                            cubit.currentWaitingStudentIndex = index;
                            cubit.showWaitingStudentDetails(
                                !cubit.showWaitingStudent_details, index);
                          },
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: ThemeCubit.get(context).darkTheme
                                ? mainTextColor
                                : mainColors,
                          ),
                        ),
                      ),
                    if (cubit.showWaitingStudent_details == true &&
                        cubit.currentWaitingStudentIndex == index)
                      SizedBox(
                        width: 30.0,
                        height: 30.0,
                        child: IconButton(
                          onPressed: () {
                            cubit.showWaitingStudentDetails(!cubit.showWaitingStudent_details, index);
                            if(cubit.showWaitingStudentEdit) {
                              cubit.changeWaitingStudentEditIcon(!cubit.showWaitingStudentEdit);
                            }
                          },
                          alignment: Alignment.center,
                          icon: Icon(
                            Icons.keyboard_arrow_up,
                            color: ThemeCubit.get(context).darkTheme
                                ? mainTextColor
                                : mainColors,
                          ),
                        ),
                      ),
                    if (cubit.showWaitingStudent_details == true &&
                        cubit.currentWaitingStudentIndex == index)
                      SizedBox(
                        width: 50.0,
                        height: 30.0,
                        child: IconButton(
                          onPressed: () {
                            if (cubit.showWaitingStudentEdit == true) {
                              if (cubit.phoneController.text.length == 10 ) {
                                cubit.putConsultant(
                                  email:cubit.emailController.text,
                                  department: cubit.departmentController.text,
                                  accept: cubit.acceptController.text == 'true' ? true : false ,
                                  speachalist:cubit.speachalistController.text,
                                  name: cubit.nameController.text,
                                  uid:cubit.idController.text,
                                  yearsofExperience:cubit.yearsofExperienceController.text,
                                  phone:cubit.phoneController.text,
                                  imageOfCertificate : '',

                                );
                              } else {
                                if(cubit.phoneController.text.length != 11){
                                  showToast(
                                      message: 'رقم الموبيل غير صحيح',
                                      state: ToastStates.ERROR);
                                  cubit.changeWaitingStudentEditIcon(!cubit.showWaitingStudentEdit);
                                }
                              }
                            }
                            cubit.changeWaitingStudentEditIcon(!cubit.showWaitingStudentEdit);
                          },
                          icon: Icon(
                            cubit.showWaitingStudentEdit == false ? Icons.edit : Icons.done,
                            size: 20.0,
                            color: ThemeCubit.get(context).darkTheme
                                ? mainTextColor
                                : mainColors,
                          ),
                          alignment: AlignmentDirectional.center,
                        ),
                      ),
                  ],
                ),
                if (cubit.showWaitingStudent_details == true &&
                    cubit.currentWaitingStudentIndex == index)
                  const SizedBox(
                    height: 10.0,
                  ),
                if (cubit.showWaitingStudent_details == true &&
                    cubit.currentWaitingStudentIndex == index)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 120),
                    height: cubit.animatedWaitingStudentHeight,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: cubit.showWaitingStudentEdit == true
                          ? ThemeCubit.get(context).darkTheme
                          ? mainColors
                          : Colors.white
                          : ThemeCubit.get(context).darkTheme
                          ? backGroundDark
                          : backGround,
                    ),
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                      child: Column(
                        children: [

                          const SizedBox(
                            height: 5.0,
                          ),

                          // name
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '- اسم المستشار :',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                              switchedTextFormField(
                                context: context,
                                cubit: cubit,
                                controller: cubit.nameController,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),

                          //address
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '- البريد الإلكتروني :',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                              switchedTextFormField(
                                context: context,
                                cubit: cubit,
                                controller: cubit.emailController,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),

                          // section
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '- التخصص :',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                              switchedTextFormField(
                                context: context,
                                cubit: cubit,
                                controller:cubit.speachalistController,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),

                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '- المجال :',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                              switchedTextFormField(
                                context: context,
                                cubit: cubit,
                                controller: cubit.departmentController,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),

                          //phone
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '- الموبيل :',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                              switchedTextFormField(
                                context: context,
                                cubit: cubit,
                                controller: cubit.phoneController,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),


                          const SizedBox(
                            height: 5.0,
                          ),

                          //phone
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '- عدد سنين الخبرة :',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                              switchedTextFormField(
                                context: context,
                                cubit: cubit,
                                controller: cubit.yearsofExperienceController,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),

                          Text(
                            'صورة من الشهادة',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 180.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0,),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: item.imageOfCertificate ?? "",
                                  fit: BoxFit.fill,
                                  placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>  Container(
                                    alignment: Alignment.center,
                                    height: 50.0,
                                    child: Icon(Icons.error,
                                      color: ThemeCubit.get(context).darkTheme
                                          ? mainTextColor
                                          : mainColors,),
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: 188.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(color: Colors.grey, width: 1),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          defaultButton(
                            function: (){
                              cubit.UnAcceptConsultant(uid: item.uid!);
                            },
                            text: 'تقييد',
                            btnColor: Colors.red ,
                            width: double.infinity,
                          ),
                        ],
                      ),
                    ),
                  )
              ],
            ),
          );
        }
        else{
          return InkWell(
            onTap: (){
              cubit.currentWaitingStudentIndex = index;
              cubit.showWaitingStudentDetails(
                  !cubit.showWaitingStudent_details, index);
              cubit.inputData(item);
            },
            child: Dismissible(
              direction: DismissDirection.startToEnd,
              resizeDuration: const Duration(milliseconds: 200),
              onDismissed: (direction) {
                cubit.deleteConsultant(item.uid);
              },
              background: Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadiusDirectional.circular(8.0),
                ),
                padding: const EdgeInsets.all(5.0),
                alignment: AlignmentDirectional.centerStart,
                child: const Icon(
                  Icons.delete_forever,
                  color: Colors.white,
                ),
              ),
              key: UniqueKey(),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '${item.name}',
                      style: Theme.of(context).textTheme.bodyText1,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${item.email}',
                      style: Theme.of(context).textTheme.bodyText1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    width: 30.0,
                    height: 30.0,
                    child: IconButton(
                      onPressed: () {
                        cubit.currentWaitingStudentIndex = index;
                        cubit.showWaitingStudentDetails(
                            !cubit.showWaitingStudent_details, index);
                        cubit.inputData(item);
                      },
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: ThemeCubit.get(context).darkTheme
                            ? mainTextColor
                            : mainColors,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      }
  );
}
