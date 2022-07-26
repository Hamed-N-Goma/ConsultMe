import 'package:consultme/Bloc/adminBloc/cubit/admin_cubit.dart';
import 'package:consultme/Bloc/adminBloc/cubit/admin_states.dart';
import 'package:consultme/components/components.dart';
import 'package:consultme/models/complaintsModel.dart';
import 'package:consultme/presentation_layer/presentation_layer_manager/color_manager/color_manager.dart';
import 'package:consultme/shard/style/theme/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dash_complaints_details_screen.dart';

class DashComplimentsScreen extends StatelessWidget {
  const DashComplimentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AdminCubit.get(context);
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: dashAppBar(
              title: 'الشكاوى',
              context: context,
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [

                    //complaints
                    smallDashBoardTitleBox(
                        svgImage:'assets/images/review.svg',
                        svg: true,
                        title: 'شكوى عامة'),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      height: 300.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          8.0,
                        ),
                        border: Border.all(color: mainColors.withOpacity(0.6), width: 2),
                      ),
                      child: ListView.separated(
                        padding: const EdgeInsetsDirectional.all(10.0),
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) => ComplaintsItem(
                            item: cubit.complaints![index],
                            cubit: cubit,
                            context: context,
                            index: index,
                        ),
                        separatorBuilder: (context, index) => Container(
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          width: double.infinity,
                          height: 1.0,
                          color: mainColors,
                        ),
                        itemCount: cubit.complaints!.length,
                      ),
                    ),

                    const SizedBox(height: 40.0,),

                    CircleAvatar(
                      radius: 70,
                      backgroundColor: ThemeCubit.get(context).darkTheme
                          ? mainTextColor
                          : mainTextColor,
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: 200.0,
                        height: 200.0,
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



Widget ComplaintsItem({
  required BuildContext context,
  required AdminCubit cubit,
  required ComplaintModel item,
  required int index,
}) {
  return InkWell(
    onTap: (){
      if(item != null){
        navigateTo(context, DashComplimentsDetailsScreen(
          type: 'complaints',
          complaintsItem: item,
        ));
      }else{
        showToast(message: 'لا يوجد تفاصيل حاليا!!', state: ToastStates.WARNING);
      }
    },
    child: Row(
      children: [
        Expanded(
          child: Text(
            item == null ? 'فارغ' :item.name!,
            style: Theme.of(context).textTheme.bodyText1 ,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          child: Text(
            item == null ? 'فارغ' :item.email!,
            style :  Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,

          ),
        ),
        SizedBox(
          width: 30.0,
          height: 30.0,
          child: IconButton(
            onPressed: () {
              navigateTo(context, DashComplimentsDetailsScreen(
                type: 'complaints',
                complaintsItem: item,
              ));
            },
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: ThemeCubit
                  .get(context)
                  .darkTheme
                  ? mainTextColor
                  : mainColors,
            ),
          ),
        ),
      ],
    ),
  );
}


