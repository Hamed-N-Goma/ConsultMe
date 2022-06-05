import 'package:consultme/presentation_layer/presentation_layer_manager/font_manager/fontmanager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../const.dart';

class Chatitem extends StatelessWidget {
  Chatitem({Key? key}) : super(key: key);
  var size, width, height;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, chatDetails);
      },
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 5,
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          height: height * 0.14,
          width: width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              consultantImage(),
              SizedBox(width: width * 0.03),
              consultantDetales(height),
            ],
          ),
        ),
      ),
    );
  }
  ///////
  ///Widgets
  /////

  Widget consultantImage() {
    return CircleAvatar(
      backgroundColor: Colors.black,
      radius: 40,
      backgroundImage: NetworkImage(
        profileImageUri,
      ),
    );
  }

  Widget consultantDetales(double height) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: height * 0.04,
        ),
        Text(
          'عبدالله سالم عبدالله',
          style: TextStyle(
              color: Colors.black,
              fontFamily: FontConst.fontFamily,
              fontWeight: FontWeightManager.bold),
        ),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }
}
