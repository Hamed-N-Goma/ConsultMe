import 'package:consultme/presentation_layer/presentation_layer_manager/font_manager/fontmanager.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../presentation_layer_manager/color_manager/color_manager.dart';

Widget category(context) {
  return Column(children: [
    InkWell(
      radius: 30,
      borderRadius: const BorderRadius.all(Radius.circular(50)),
      onTap: () {
        print('tapped');
      },
      child: Card(
        color: Theme.of(context).cardColor,
        child: Container(
          padding: const EdgeInsets.all(5),
          child: const FaIcon(
            FontAwesomeIcons.airbnb,
            size: 60,
            color: ColorManager.myBlack,
          ),
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(80))),
      ),
    ),
    const SizedBox(
      height: 10,
    ),
    Text(
      'data',
      style: Theme.of(context).textTheme.bodyText1,
    )
  ]);
}
