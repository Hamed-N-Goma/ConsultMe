import 'package:cached_network_image/cached_network_image.dart';
import 'package:consultme/Bloc/userBloc/cubit/userlayoutcubit_cubit.dart';
import 'package:consultme/components/components.dart';
import 'package:consultme/models/PostModel.dart';
import 'package:consultme/models/consultantmodel.dart';
import 'package:consultme/presentation_layer/presentation_layer_manager/color_manager/color_manager.dart';
import 'package:consultme/presentation_layer/user/screens/appoinment.dart';
import 'package:consultme/presentation_layer/user/screens/consultantDetails.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:consultme/shard/style/theme/cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;



class PostsDetails extends StatelessWidget {
  final PostModel model;
  ConsultantModel? consultantModel;
  PostsDetails({Key? key, required this.model}) : super(key: key);
  var height, width, size;


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserLayoutCubit, UserLayoutState>(
      listener: (context,state){},
      builder: (BuildContext context, Object? state) {
        UserLayoutCubit.get(context).getConsultById(model.uid!);
        consultantModel = UserLayoutCubit.get(context).consult;
        DateTime tempDate =
        DateFormat("yyyy-MM-dd HH:mm:ss").parse(model.dateTime!);
        String date = tempDate.toString().substring(0, 16);

        return Directionality(
          textDirection: ui.TextDirection.rtl,
          child: Scaffold(
            appBar: dashAppBar(
              title:  '${consultantModel!.speachalist!}',
              context: context,
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children:  [
                      Stack(
                        alignment: Alignment.topLeft,
                        children:  [

                          CachedNetworkImage(
                            imageUrl: '${model.postImage}',
                            placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>  Container(
                              alignment: Alignment.center,
                              height: 200.0,
                              child: Icon(Icons.error,
                                color: ThemeCubit.get(context).darkTheme
                                    ? mainTextColor
                                    : mainColors,),
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            height: 20.0,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft:  Radius.circular(32.0),
                                topRight: Radius.circular(32.0),
                              ),
                              color: ThemeCubit.get(context).darkTheme? backGroundDark : backGround,
                            ),
                          ),
                          Container(
                            height: 5.0,
                            color: ThemeCubit.get(context).darkTheme? backGroundDark : backGround,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      '${model.title}',
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  const SizedBox(height: 18.0,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      '${model.text}',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18.0,),

                  InkWell(
                    onTap: () {
                      navigateTo(
                          context,
                          consultantDetails(
                            consultant: consultantModel!,
                          ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        padding: EdgeInsets.all(16),
                        height: 90,
                        decoration: BoxDecoration(
                            color: ThemeCubit.get(context).darkTheme
                                ?  mainColors
                                : Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 3),
                                  color: HexColor('#404863').withOpacity(0.2),
                                  blurRadius: 10)
                            ]),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            consultantImage(),
                            const SizedBox(width: 16),
                            consultantDetales(context, consultantModel),
                            const SizedBox(width: 50),
                            Spacer(),
                            rate(context, consultantModel),
                            const SizedBox(width: 16),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Text(
                     date,
                      style: Theme.of(context).textTheme.bodyText2!,),
                  const SizedBox(height: 5.0,),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget consultantImage() {
    return Container(
      height: 90,
      width: 50,
      decoration: BoxDecoration(
          color: ColorManager.myBlue,
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
              image: NetworkImage(
                '${consultantModel!.image!}',
              ),
              fit: BoxFit.fill)),
    );
  }

  Widget consultantDetales(context, allConsultants) {
    return Builder(builder: (context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            '${consultantModel!.name}',
            style: Theme.of(context).textTheme.bodyText1,
          ),

          Text(
            '${consultantModel!.speachalist} - ${consultantModel!.department} ',
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      );
    });
  }

  Widget rate(context, consultant) {
    return Builder(builder: (context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            double.parse(consultant.rating!.toStringAsFixed(2)).toString(),
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(
            width: 6,
          ),
          FaIcon(
            FontAwesomeIcons.solidStar,
            color: ColorManager.myYallow,
            size: 20,
          ),
        ],
      );
    });
  }
}



