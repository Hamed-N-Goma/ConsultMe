import 'package:consultme/Bloc/adminBloc/cubit/admin_cubit.dart';
import 'package:consultme/Bloc/adminBloc/cubit/admin_states.dart';
import 'package:consultme/components/components.dart';
import 'package:consultme/const.dart';
import 'package:consultme/models/UserModel.dart';
import 'package:consultme/presentation_layer/admin/AddCategory.dart';
import 'package:consultme/presentation_layer/admin/complaints/accept/accept_screen.dart';
import 'package:consultme/presentation_layer/admin/complaints/dash_complaints_screen.dart';
import 'package:consultme/presentation_layer/admin/seach.dart';
import 'package:consultme/presentation_layer/presentation_layer_manager/color_manager/color_manager.dart';
import 'package:consultme/shard/style/theme/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class AdminHomeScreen extends StatelessWidget {

  AdminHomeScreen({Key? key}) : super(key: key);
  var size, height, width;


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (BuildContext context, state) {
        if (state is delUserSuccessStates) {
          showToast(
              message:
              ' لقد تم حذف المستخدم بنجاح ',
              state: ToastStates.SUCCESS);
        }
      },
      builder: (BuildContext context, Object? state) {
        var cubit = AdminCubit.get(context);
        size = MediaQuery
            .of(context)
            .size;
        height = size.height;
        width = size.width;
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar:
            dashAppBar(title: 'الإدارة ', context: context, pop: false),
            body: RefreshIndicator(
              onRefresh: () async {
                return cubit.getUserInSecurity();
              },

              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Builder(
                  builder: (context) {
                    if (cubit.adminModel != null) {
                      return Container(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                  child: Image.asset(
                                    'assets/images/logo.png',
                                    width: 80.0,
                                    height: 80.0,
                                  ),
                                ),
                                const SizedBox(
                                  width: 12.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cubit.adminModel!.name,
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 2.0,
                                    ),
                                    Text(
                                      cubit.adminModel!.userType.toString(),
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 22.0,
                            ),

                            Container(
                              width: double.infinity,
                              height: 1.0,
                              color: separator,
                            ),
                            const SizedBox(
                              height: 12.0,
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'عدد الخبراء المتاحين',
                                        textAlign: TextAlign.center,
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        'عدد الخبراء الغير متاحين',
                                        textAlign: TextAlign.center,
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                          '${cubit.accepted_consultant
                                              ?.length}',
                                          textAlign: TextAlign.center,
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .headline6!
                                              .copyWith(color: Colors.green)
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                          '${cubit.waiting_consultant?.length}',
                                          textAlign: TextAlign.center,
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .headline6!
                                              .copyWith(color: Colors.red)
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 20.0,),

                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'عدد المستخدمين',
                                        textAlign: TextAlign.center,
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        'عدد المنشورات',
                                        textAlign: TextAlign.center,
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${cubit.users?.length}',
                                        textAlign: TextAlign.center,
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        '${cubit.posts?.length}',
                                        textAlign: TextAlign.center,
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 12.0,
                            ),
                            Container(
                              width: double.infinity,
                              height: 1.0,
                              color: separator,
                            ),
                            const SizedBox(
                              height: 12.0,
                            ),
                            InkWell(
                            onTap: () {
                                  navigateTo(context, const acceptScreen());
                                  },
                             child : buildOthersIten(
                                name: 'إداره الخبراء',
                                context: context,
                                icon: FontAwesomeIcons.userDoctor,
                              ),
                            ),
                            const SizedBox(
                              height: 12.0,
                            ),
                            InkWell(
                              onTap: () {
                                cubit.getCategorys();
                                navigateTo(context,  AddCategoy());
                              },
                              child: buildOthersIten(
                                  name: 'اضافة قسم ',
                                  context: context,
                                  icon: FontAwesomeIcons.addressBook,
                        ),
                            ),
                            const SizedBox(
                              height: 12.0,
                            ),
                            InkWell(
                              onTap: () {
                                navigateTo(context,  DashComplimentsScreen());
                              },
                              child: buildOthersIten(
                                  name: 'الشكاوي',
                                  context: context,
                                  icon: FontAwesomeIcons.personCircleExclamation,
                                  ),
                            ),
                            const SizedBox(
                              height: 12.0,
                            ),
                            InkWell(
                              onTap: () {
                                navigateTo(context,  SearchUsers());
                              },
                              child: buildOthersIten(
                                  name: 'المستخدمين',
                                  context: context,
                                  icon: FontAwesomeIcons.users,
                       ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            InkWell(
                              onTap: () {
                                showDialog<void>(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    backgroundColor: ThemeCubit.get(context).darkTheme
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
                                              'تأكيد الخروج من الحساب ؟',
                                              textDirection: TextDirection.rtl,
                                              style:
                                              Theme.of(context).textTheme.subtitle1,
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
                                          style: Theme.of(context).textTheme.bodyText1,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          signOut(context);
                                        },
                                        child: Text(
                                          'تأكيد',
                                          textDirection: TextDirection.rtl,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: Text(
                                'تسجيل خروج',
                                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontWeight: FontWeight.bold, color: Colors.red),
                              ),
                            ),
                            const SizedBox(
                              height: 12.0,
                            ),

                          ],
                        ),
                      );
                    } else {
                      return Container(alignment: Alignment.center,
                        margin: const EdgeInsetsDirectional.all(100.0),
                        child: const CircularProgressIndicator(),);
                    }
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildSecurityCard(context, UserModel model) =>
      Column(
        children: [
          Container(
            width: double.infinity,
            height: 115,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                8.0,
              ),
              color: ThemeCubit
                  .get(context)
                  .darkTheme
                  ? mainColors
                  : containerFollowStudent,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [

                      CircleAvatar(
                        radius: 25.0,
                        backgroundColor: ThemeCubit
                            .get(context)
                            .darkTheme
                            ? mainTextColor
                            : mainColors,
                        child: Container(
                          alignment: Alignment.center,
                          height: 80.0,
                          child: Icon(Icons.error,
                            color: ThemeCubit
                                .get(context)
                                .darkTheme
                                ? mainColors
                                : mainTextColor,
                          ),
                        ),
                      ),

                      const SizedBox(
                        width: 10.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(model.name,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText2),
                          Text('${model.email}',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText2),
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                defaultButton2(
                  function: () {
                    AdminCubit.get(context).delUser(model);
                  },
                  text: 'حذف المستخدم ',
                  width: double.infinity,
                  height: 32.0,
                  btnColor: Colors.red,
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.white),
                ),
              ],
            ),
          )
        ],
      );

}