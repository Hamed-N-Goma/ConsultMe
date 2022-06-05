import 'package:consultme/presentation_layer/presentation_layer_manager/font_manager/fontmanager.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../presentation_layer_manager/color_manager/color_manager.dart';

Widget category() {
  return Column(children: [
    InkWell(
      radius: 30,
      borderRadius: const BorderRadius.all(Radius.circular(50)),
      onTap: () {
        print('tapped');
      },
      child: Card(
        color: HexColor('#929BB0'),
        child: Container(
          padding: const EdgeInsets.all(5),
          child: const FaIcon(
            FontAwesomeIcons.airbnb,
            size: 60,
            color: ColorManager.myBlack,
          ),
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50))),
      ),
    ),
    const SizedBox(
      height: 10,
    ),
    const Text(
      'data',
      style: TextStyle(fontFamily: FontConst.fontFamily),
    )
  ]);
}
