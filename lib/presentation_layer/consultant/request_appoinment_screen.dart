import 'package:consultme/Bloc/consultantBloc/cubit/consultant_cubit.dart';
import 'package:consultme/Bloc/consultantBloc/cubit/consultant_states.dart';
import 'package:consultme/models/AppoinmentModel.dart';
import 'package:consultme/presentation_layer/consultant/request_appointment_details.dart';
import 'package:consultme/presentation_layer/presentation_layer_manager/color_manager/color_manager.dart';
import 'package:consultme/shard/style/theme/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/components.dart';


class RequestAppoinmentScreen extends StatelessWidget {
  const RequestAppoinmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConsultantCubit, ConsultantStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ConsultantCubit.get(context);
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: dashAppBar(
              title: 'الطلبات',
              context: context,
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    smallDashBoardTitleBox(
                        svgImage:'assets/images/call.svg',
                        svg: true,
                        title: 'طلبات الأستشارة '),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      height: 500.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          8.0,
                        ),
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      child: ListView.separated(
                        padding: const EdgeInsetsDirectional.all(10.0),
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) => AppoinmentsItem(
                          item: cubit.appointments![index],
                          cubit: cubit,
                          context: context,
                        ),
                        separatorBuilder: (context, index) => Container(
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          width: double.infinity,
                          height: 1.0,
                          color: separator,
                        ),
                        itemCount: cubit.appointments!.length,
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


Widget AppoinmentsItem({
  required BuildContext context,
  required ConsultantCubit cubit,
  required AppointmentModel item,
}) {
  return InkWell(
    onTap: (){
      if(item.userID != null){
        navigateTo(context, RequestAppoinmentDetails(
          appoItem: item,
        ));
      }else{
        showToast(message: 'لا يوجد طلبات حاليا!!', state: ToastStates.WARNING);
      }
    },
    child: Row(
      children: [
        Expanded(
          child: Text(
            item.userName == null ? 'فارغ' :item.userName!,
            style: Theme.of(context).textTheme.bodyText1,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          child: Text(
            item.userEmail == null ? 'فارغ' :item.userEmail!,
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          width: 30.0,
          height: 30.0,
          child: IconButton(
            onPressed: () {
              navigateTo(context, RequestAppoinmentDetails(
                appoItem: item,
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


