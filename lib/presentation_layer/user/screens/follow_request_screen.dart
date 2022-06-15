import 'package:consultme/Bloc/userBloc/cubit/userlayoutcubit_cubit.dart';
import 'package:consultme/components/components.dart';
import 'package:consultme/models/AppoinmentModel.dart';
import 'package:consultme/presentation_layer/presentation_layer_manager/color_manager/color_manager.dart';
import 'package:consultme/presentation_layer/user/screens/follow_request_details.dart';
import 'package:consultme/shard/style/theme/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';



class FollowRequestsScreen extends StatelessWidget {
  const FollowRequestsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserLayoutCubit, UserLayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              titleSpacing: 12.0,
              title: Text(
                'متابعه طلباتي',
                style: Theme.of(context).textTheme.headline6,
              ),
              actions: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 8.0),
                  child: Container(
                    padding: const EdgeInsets.all(0.0),
                    width: 34.0,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: SvgPicture.asset(
                        'assets/images/back_arrow.svg',
                        width: 18.0,
                        height: 18.0,
                        color: ThemeCubit.get(context).darkTheme
                            ? mainTextColor
                            : mainColors,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            body: Builder(
              builder: (context){
                if(state is GetAppointmentsSuccessState){
                  if(validation(context)){
                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: SvgPicture.asset(
                              'assets/images/no_data.svg',
                              height: 300.0,
                            ),
                          ),
                          Text(
                            '" لا يوجد طلبات حاليا "',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          const SizedBox(height: 20.0,),
                        ],
                      ),
                    );
                  }else{
                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '* يجب مراعاه الارشادات التاليه',
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                fontSize: 14.0,
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Row(
                              children: [
                                Container(
                                  width: 10.0,
                                  height: 10.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadiusDirectional.circular(3.0),
                                    color: Colors.green,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  'تمت الموافقه علي طلبكم',
                                  style:
                                  Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 10.0,
                                  ),
                                ),
                                const SizedBox(
                                  width: 14.0,
                                ),
                                Container(
                                  width: 10.0,
                                  height: 10.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadiusDirectional.circular(3.0),
                                    color: Colors.amber,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  'جاري الرد علي طلبكم',
                                  style:
                                  Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 10.0,
                                  ),
                                ),
                                const SizedBox(
                                  width: 14.0,
                                ),
                                Container(
                                  width: 10.0,
                                  height: 10.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadiusDirectional.circular(3.0),
                                    color: Colors.red,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  'تم رفض طلبكم',
                                  style:
                                  Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 10.0,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8.0),
                            Container(
                              width: double.infinity,
                              height: 1.0,
                              color: separator,
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            Conditional.single(
                              context: context,
                              conditionBuilder: (BuildContext context) => UserLayoutCubit.get(context).appointments != null ,
                              widgetBuilder: (BuildContext context) => buildOrderScreen(context),
                              fallbackBuilder: (BuildContext context) => buildOrderShimmerScreen(context),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                }else{
                  return const Center(child: CircularProgressIndicator(),);
                }
              },
            ),
          ),
        );
      },
    );
  }
}


Widget buildOrderScreen(context) => Column(
  children: [

    Builder(builder: (context) {
      if(UserLayoutCubit.get(context).appointments!.isEmpty){
        return const SizedBox(height: 2.0,);
      }else{
        return Column(
          children: [
            smallDashBoardTitleBox(
                svgImage: 'assets/images/call.svg',
                svg: true,
                title: 'طلبات الإستشارة'),
            const SizedBox(height: 15.0),
            SizedBox(
              height:UserLayoutCubit.get(context).appointments!.length == 1 ? 105 : 210,
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) =>
                    buildGuestItem(context, UserLayoutCubit.get(context).appointments![index]),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 8.0,
                ),
                itemCount: UserLayoutCubit.get(context).appointments!.length,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
          ],
        );
      }
    }),
  ],
);



Widget buildGuestItem(context,AppointmentModel  model) => Padding(
  padding: const EdgeInsets.symmetric(horizontal: 8.0),
  child: buildEnquiry(
    context,
    height: 100.0,
    state: model.MeetTime != null ? model.accept == true  ? StatusStates.ACCEPT : StatusStates.REJECT :StatusStates.WAITING,
    body: Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children:[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 2.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child:  Text(
                      'الأسم: ${model.consultName}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),

                  SizedBox(
                    width: double.infinity,
                    child:  Text(
                      'تاريخ الطلب: ${model.time}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: (){
                navigateTo(
                  context,
                  FollowAppointmentScreen(model: model),
                );
              },
              child: Text(
                'عرض التفاصيل',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  decoration:TextDecoration.underline,
                ),

              ),
            ),
          ],
        ),

      ),
    ),
  ),
);

Widget buildOrderShimmerScreen(context) => Column(
  children: [
    Shimmer.fromColors(
      child: Container(
        height: 50.0,
        width: double.infinity,
        color: baseColor,
      ),
      baseColor: baseColor,
      highlightColor: highlightColor,
    ),
    const SizedBox(height: 15.0),
    SizedBox(
      height: 215,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) =>
            buildRequestShimmerItem(context),
        separatorBuilder: (context, index) => const SizedBox(
          height: 8.0,
        ),
        itemCount: 10,
      ),
    ),
    const SizedBox(
      height: 20.0,
    ),
    Shimmer.fromColors(
      child: Container(
        height: 50.0,
        width: double.infinity,
        color: baseColor,
      ),
      baseColor: baseColor,
      highlightColor: highlightColor,
    ),
    const SizedBox(height: 15.0),
    SizedBox(
      height: 215,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) =>
            buildRequestShimmerItem(context),
        separatorBuilder: (context, index) => const SizedBox(
          height: 8.0,
        ),
        itemCount: 10,
      ),
    ),
    const SizedBox(
      height: 20.0,
    ),
  ],
);

Widget buildRequestShimmerItem(context) => Padding(
  padding: const EdgeInsets.symmetric(horizontal: 8.0),
  child:  Shimmer.fromColors(
    child: Container(
      height: 100.0,
      width: double.infinity,
      color: baseColor,
    ),
    baseColor: baseColor,
    highlightColor: highlightColor,
  ),
);

validation (context) {
  if(UserLayoutCubit.get(context).appointments!.isEmpty ){
    return true;
  }
  return false;
}