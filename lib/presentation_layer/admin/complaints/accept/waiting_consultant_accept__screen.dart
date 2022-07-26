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
import 'package:flutter_svg/flutter_svg.dart';


class WaitingConsultantsScreen extends StatelessWidget {
  WaitingConsultantsScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {
        if(state is PutStudentLoadingStates || state is DeleteStudentLoadingStates){
          showDialog<void>(
              context: context,
              builder: (context)=> waitingDialog(context: context)
          );
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
              title: 'إدارة المستشارين',
              context: context,
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultDashBoardTitleBox(
                        svgImage:  'assets/images/warn.svg',
                        svg: true,
                        title: 'لم يتم قبولهم '),

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
                          }else if (cubit.waiting_consultant!.isEmpty){
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
                                  item:  cubit.waiting_consultant![index],
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
                              itemCount: cubit.waiting_consultant!.length,
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
        if(cubit.showWaitingConsultant_details==true){
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
                    if (cubit.showWaitingConsultant_details == false ||
                        cubit.currentWaitingConsultantIndex != index)
                      SizedBox(
                        width: 30.0,
                        height: 30.0,
                        child: IconButton(
                          onPressed: () {
                            cubit.currentWaitingConsultantIndex = index;
                            cubit.showWaitingConsultantDetails(
                                !cubit.showWaitingConsultant_details, index);
                          },
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: ThemeCubit.get(context).darkTheme
                                ? mainTextColor
                                : mainColors,
                          ),
                        ),
                      ),
                    if (cubit.showWaitingConsultant_details == true &&
                        cubit.currentWaitingConsultantIndex == index)
                      SizedBox(
                        width: 30.0,
                        height: 30.0,
                        child: IconButton(
                          onPressed: () {
                            cubit.showWaitingConsultantDetails(!cubit.showWaitingConsultant_details, index);
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
                  ],
                ),
                if (cubit.showWaitingConsultant_details == true &&
                    cubit.currentWaitingConsultantIndex == index)
                  AnimatedContainer(
                    margin: EdgeInsets.only(top: 20.0),
                    duration: const Duration(milliseconds: 120),
                    height: cubit.animatedWaitingConsultantHeight,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: mainColors.withOpacity(0.5), width: 2),
                      borderRadius: BorderRadius.circular(20.0),
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
                            height: 20.0,
                          ),
                          CircleAvatar(
                            radius: 50,
                            backgroundColor:
                            ThemeCubit.get(context).darkTheme
                                ? mainTextColor
                                : mainColors,
                            backgroundImage: NetworkImage(
                              '${item.image}',

                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
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
                                  '- رقم الهاتف :',
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
                            height: 10.0,
                          ),

                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '-  سنين الخبرة :',
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
                              cubit.AcceptConsultant(uid: item.uid!);
                            },
                            text: 'قبول',
                            btnColor: Colors.green,
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
              cubit.currentWaitingConsultantIndex = index;
              cubit.showWaitingConsultantDetails(
                  !cubit.showWaitingConsultant_details, index);
              cubit.inputData(item);
            },
            child: Dismissible(
              direction: DismissDirection.startToEnd,
              resizeDuration: const Duration(milliseconds: 200),
              onDismissed: (direction) {
                showDialog<void>(
                  context: context,
                  builder: (context) =>
                      AlertDialog(
                        backgroundColor: ThemeCubit
                            .get(context)
                            .darkTheme
                            ? mainColors
                            : Colors.white,
                        content: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/images/warning.svg',
                                  width: 25.0,
                                  height: 25.0,
                                  alignment: Alignment.center,
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  'تأكيد حذف الإستشاري ${item.name} ؟',
                                  textDirection: TextDirection.rtl,
                                  style:
                                  Theme
                                      .of(context)
                                      .textTheme
                                      .subtitle1,
                                ),
                              ],
                            ),
                          ),
                        ),
                        contentPadding: EdgeInsets.zero,
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              'الغاء',
                              textDirection: TextDirection.rtl,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText1,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              cubit.deleteConsultant(item.uid);
                              Navigator.pop(context);
                            },
                            child: Text(
                              'حذف',
                              textDirection: TextDirection.rtl,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                );
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
                        cubit.currentWaitingConsultantIndex = index;
                        cubit.showWaitingConsultantDetails(
                            !cubit.showWaitingConsultant_details, index);
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
