import 'package:consultme/Bloc/adminBloc/cubit/admin_cubit.dart';
import 'package:consultme/Bloc/adminBloc/cubit/admin_states.dart';
import 'package:consultme/components/components.dart';
import 'package:consultme/presentation_layer/admin/complaints/accept/consultant_accept__screen.dart';
import 'package:consultme/presentation_layer/admin/complaints/accept/waiting_consultant_accept__screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class acceptScreen extends StatelessWidget {
  const acceptScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit,AdminStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit = AdminCubit.get(context);
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: dashAppBar(title: 'إدارة الخبراء', context: context),
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Builder(
                    builder: (context){
                      if(state is GetAllOrdersLoadingStates){
                        return const SizedBox(
                            width:double.infinity,
                            height: 300.0,
                            child: Center(child: CircularProgressIndicator()));
                      }else{
                        return Column(
                          children: [
                            const SizedBox(height: 20.0,),
                            InkWell(
                              onTap: (){

                                navigateTo(context, AcceptedConsultantsScreen());
                              },
                              child: defaultDashBoardTitleBox(
                                  title: 'تم قبولهم',
                                  svg: true,
                                  svgImage: 'assets/images/check.svg'
                              ),
                            ),
                            const SizedBox(height: 20.0,),
                            InkWell(
                              onTap: (){

                                navigateTo(context, WaitingConsultantsScreen());
                              },
                              child: defaultDashBoardTitleBox(
                                  title: 'قيد الإنتظار',
                                  svg: true,
                                  svgImage: 'assets/images/warn.svg'
                              ),
                            ),

                          ],
                        );
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
}
