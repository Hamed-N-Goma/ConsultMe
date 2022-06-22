import 'package:consultme/Bloc/userBloc/cubit/userlayoutcubit_cubit.dart';
import 'package:consultme/components/components.dart';
import 'package:consultme/models/AppoinmentModel.dart';
import 'package:consultme/presentation_layer/presentation_layer_manager/color_manager/color_manager.dart';
import 'package:consultme/presentation_layer/user/screens/TechnicalSupportScreen.dart';
import 'package:consultme/shard/style/theme/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FollowAppointmentScreen extends StatelessWidget {
  final AppointmentModel model;

  const FollowAppointmentScreen({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserLayoutCubit, UserLayoutState>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              titleSpacing: 12.0,
              title: Text(
                'التفاصيل',
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
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                padding: const EdgeInsetsDirectional.all(16.0),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '* في حاله وجود خطأ في التفاصيل يرجى المتابعه من خلال ',
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 10.0,
                                  ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        InkWell(
                          onTap: () {
                            navigateTo(context, const TechnicalSupportScreen());
                          },
                          child: Text(
                            'الدعم الفني',
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      fontWeight: FontWeight.w900,
                                      decoration: TextDecoration.underline,
                                    ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5.0),
                    Container(
                      width: double.infinity,
                      height: 1.0,
                      color: separator,
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    buildBoxCheckColor(),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            'أسم المستشار : ',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            model.consultName!,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            'التخصص : ',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            model.consultSp!,
                            textAlign: TextAlign.center,
                            // maxLines: 1,
                            // overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            'تاريخ الطلب : ',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            model.time!,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                'سبب / نوع الإستشارة : ',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                model.resson!,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                    buildReplay(),
                    const SizedBox(
                      height: 10.0,
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

  Widget buildBoxCheckColor() => Builder(builder: (context) {
        if (model.MeetTime != null) {
          if (model.accept!) {
            return Container(
              height: 50.0,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadiusDirectional.circular(8.0),
              ),
              alignment: AlignmentDirectional.center,
              child: const Text(
                'تمت الموافقه عليه',
                style: TextStyle(fontSize: 18.0, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            );
          } else {
            return Container(
              height: 50.0,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadiusDirectional.circular(8.0),
              ),
              alignment: AlignmentDirectional.center,
              child: const Text(
                'تم الرفض ',
                style: TextStyle(fontSize: 18.0, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            );
          }
        } else {
          return Container(
            height: 50.0,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadiusDirectional.circular(8.0),
            ),
            alignment: AlignmentDirectional.center,
            child: const Text(
              'أنتظر حني يتم الموافقة علي الطلب',
              style: TextStyle(fontSize: 18.0, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          );
        }
      });

  Widget buildReplay() => Builder(builder: (context) {
        if (model.accept == true) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  'موعد المقابلة : ',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  model.MeetTime!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ],
          );
        } else {
          return Row();
        }
      });
}
