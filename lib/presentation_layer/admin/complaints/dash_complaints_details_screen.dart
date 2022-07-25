import 'dart:ui' as ui;
import 'package:consultme/Bloc/adminBloc/cubit/admin_cubit.dart';
import 'package:consultme/Bloc/adminBloc/cubit/admin_states.dart';
import 'package:consultme/components/components.dart';
import 'package:consultme/models/complaintsModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';


class DashComplimentsDetailsScreen extends StatelessWidget {

  DashComplimentsDetailsScreen({
    Key? key,
    required this.type,
    this.complaintsItem,
  }): super(key: key);

  String type;
  ComplaintModel? complaintsItem;

  var managerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {

      },
      builder: (context, state) {

        var cubit = AdminCubit.get(context);
        return Directionality(
          textDirection: ui.TextDirection.rtl,
          child: Scaffold(
            appBar: dashAppBar(
              title: 'الشكاوى',
              context: context,
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [

                      smallDashBoardTitleBox(
                          svgImage:'assets/images/review.svg',
                          svg: true,
                          title:  'شكوى عامة'),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        children: [
                          //code
                          const SizedBox(
                            height: 10.0,
                          ),
                          // name

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
                                  complaintsItem!.name!,
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
                                  complaintsItem!.email!,
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
                                  'الصفة  :',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: SelectableText(
                                  complaintsItem!.userType!,
                                  style: Theme.of(context).textTheme.bodyText1,
                                  textAlign: TextAlign.center,

                                ),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'الشكوى',
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 20.0),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          dashWhiteBoard(
                            context,
                            text: complaintsItem!.complaint!,
                          ),
            ]),
          ),
            ]),
          ),
        ),
        ),
        );
      },
    );
  }
}



