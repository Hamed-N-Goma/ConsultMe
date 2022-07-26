import 'package:consultme/components/components.dart';
import 'package:consultme/presentation_layer/admin/admin_home_screen.dart';
import 'package:consultme/presentation_layer/consultant/consultant_home_screen.dart';
import 'package:consultme/presentation_layer/presentation_layer_manager/color_manager/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class AddingSuccessScreen extends StatelessWidget {
  const AddingSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 50.0,),
          Center(
            child:SvgPicture.asset(
              'assets/images/phone.svg',
            ),
          ),
          const SizedBox(height: 12.0,),
          Text(
            '" تمت الإضافه بنجاح "',
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: 20.0,),
          Container(
            width: double.infinity,
            height: 70.0 ,
            padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 30.0),
            child: defaultButton(
                function: () {
                  navigateTo(context, AdminHomeScreen());
                },
                text: 'العودة ',
                btnColor: mainColors),
          ),
        ],
      ),
    );
  }
}
