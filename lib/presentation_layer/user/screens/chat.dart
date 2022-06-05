import 'package:consultme/const.dart';
import 'package:consultme/presentation_layer/user/widget/messenger_main.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../presentation_layer_manager/color_manager/color_manager.dart';
import '../../presentation_layer_manager/font_manager/fontmanager.dart';

class Chat extends StatelessWidget {
  Chat({Key? key}) : super(key: key);
  var size, width, height;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return ListView.separated(
        itemBuilder: (context, index) => Chatitem(),
        separatorBuilder: (context, index) => Container(
              color: Colors.grey[200],
              height: height * 0.0010,
            ),
        itemCount: 20);
  }
}
