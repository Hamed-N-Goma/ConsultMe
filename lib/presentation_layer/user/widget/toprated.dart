import 'package:consultme/components/components.dart';
import 'package:consultme/models/consultantmodel.dart';
import 'package:consultme/presentation_layer/presentation_layer_manager/color_manager/color_manager.dart';
import 'package:consultme/presentation_layer/user/screens/consultantDetails.dart';
import 'package:consultme/shard/style/theme/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../const.dart';

class Toprated extends StatelessWidget {
  final ConsultantModel consultant;

  Toprated({Key? key, required this.consultant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 5,
      ),
      child: Container(
        padding: EdgeInsets.all(16),
        height: 125,
        decoration: BoxDecoration(
            color: ThemeCubit.get(context).darkTheme
                ? mainColors
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
            consultantDetales(context, consultant),
          ],
        ),
      ),
    );
  }
  ///////
  ///Widgets
  /////

  Widget consultantImage() {
    return Container(
      height: 97,
      width: 90,
      decoration: BoxDecoration(
          color: ColorManager.myBlue,
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
              image: NetworkImage(
                profileImageUri,
              ),
              fit: BoxFit.fill)),
    );
  }

  Widget consultantDetales(context, allConsultants) {
    return Builder(builder: (context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '4.8',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(
                width: 6,
              ),
              FaIcon(
                FontAwesomeIcons.solidStar,
                color: ColorManager.myYallow,
                size: 16,
              ),
              const SizedBox(
                width: 20,
              ),
              InkWell(
                onTap: () {},
                child: FaIcon(
                  FontAwesomeIcons.commentDots,
                  color: ThemeCubit.get(context).darkTheme
                      ? Theme.of(context).primaryIconTheme.color
                      : Theme.of(context).iconTheme.color,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              InkWell(
                onTap: () {
                  navigateTo(
                      context,
                      consultantDetails(
                        consultant: consultant,
                      ));
                },
                child: FaIcon(
                  FontAwesomeIcons.calendarPlus,
                  color: ThemeCubit.get(context).darkTheme
                      ? Theme.of(context).primaryIconTheme.color
                      : Theme.of(context).iconTheme.color,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            '${consultant.name}',
            style: Theme.of(context).textTheme.bodyText2,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            consultant.speachalist as String,
            style: Theme.of(context).textTheme.bodyText2,
          )
        ],
      );
    });
  }
}
