import 'package:consultme/components/components.dart';
import 'package:consultme/presentation_layer/user/screens/chatDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../const.dart';
import '../../../models/consultantmodel.dart';
import '../../../shard/style/theme/cubit/cubit.dart';
import '../../presentation_layer_manager/color_manager/color_manager.dart';

class ChatitemConsult extends StatelessWidget {
  ChatitemConsult(ConsultantModel this.conslutant, BuildContext context, {Key? key}) : super(key: key);
  var size, width, height;

  ConsultantModel conslutant;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return InkWell(
      onTap: () {
        navigateTo(context, UserChatDetails(
            consultant : conslutant,
         ));
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
            color: ThemeCubit.get(context).darkTheme
                ? mainColors
                : Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              consultantImage(),
              SizedBox(width: width * 0.03),
              consultantDetales(height, context),
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
        '${conslutant.image!}',
      ),
    );
  }

  Widget consultantDetales(double height, context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 8,
        ),
        Text(
          '${conslutant.name!}',
          style: Theme.of(context).textTheme.bodyText1,
        ),

        Text(
          '${conslutant.speachalist!}',
          style: Theme.of(context).textTheme.bodyText2,
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
