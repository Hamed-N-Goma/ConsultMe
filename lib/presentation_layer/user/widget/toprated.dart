import 'package:consultme/presentation_layer/presentation_layer_manager/color_manager/color_manager.dart';
import 'package:consultme/presentation_layer/presentation_layer_manager/font_manager/fontmanager.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../const.dart';

class Toprated extends StatelessWidget {
  const Toprated({Key? key}) : super(key: key);

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
        height: 110,
        decoration: BoxDecoration(
            color: Colors.white,
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
            consultantDetales(),
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
      height: 77,
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

  Widget consultantDetales() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '4.8',
              style: TextStyle(
                color: HexColor('#929BB0'),
                fontSize: 16,
                fontFamily: FontConst.fontFamily,
                fontWeight: FontWeightManager.bold,
              ),
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
              child: const FaIcon(
                FontAwesomeIcons.commentDots,
                color: ColorManager.myGrey,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            InkWell(
              onTap: () {},
              child: const FaIcon(
                FontAwesomeIcons.calendarPlus,
                color: ColorManager.myGrey,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          'علي محمد علي',
          style: TextStyle(
              color: HexColor('#929BB0'),
              fontFamily: FontConst.fontFamily,
              fontWeight: FontWeightManager.bold),
        ),
        const SizedBox(
          height: 12,
        ),
        Text(
          'دكتور أسنان',
          style: TextStyle(
              color: HexColor('#929BB0'),
              fontFamily: FontConst.fontFamily,
              fontWeight: FontWeightManager.light),
        )
      ],
    );
  }
}
