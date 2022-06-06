import 'package:consultme/components/components.dart';
import 'package:consultme/const.dart';
import 'package:consultme/presentation_layer/presentation_layer_manager/color_manager/color_manager.dart';
import 'package:consultme/presentation_layer/presentation_layer_manager/font_manager/fontmanager.dart';
import 'package:consultme/shard/style/theme/cubit/cubit.dart';
import 'package:flutter/material.dart';

Widget buildMostImportant(context) {
  return InkWell(
    borderRadius: BorderRadius.circular(20),
    radius: 20,
    onTap: () {
      print("IMPO TAPPED");
    },
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Container(
            width: 260,
            height: 140,
            decoration: BoxDecoration(
                color: ThemeCubit.get(context).darkTheme
                    ? mainColors
                    : Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.2),
                    offset: Offset(2, 3),
                    blurRadius: 4,
                    spreadRadius: 0.5,
                  )
                ]),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildarticle(),
                buildimg(),
              ],
            ),
          ),
        )
      ],
    ),
  );
}

////
///widgets
///

Widget buildimg() {
  return Container(
    height: 140,
    width: 130,
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: NetworkImage(profileImageUri),
        fit: BoxFit.cover,
      ),
      color: ColorManager.myBlue,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
    ),
  );
}

Widget buildarticle() {
  return SizedBox(
    width: 130,
    child: Padding(
      padding: EdgeInsets.all(1),
      child: Column(
        children: [
          Text(
            'كورونا والعالم',
            style: TextStyle(
                fontFamily: FontConst.fontFamily,
                fontWeight: FontWeightManager.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'فيروسات كورونا هي عائلة من الفيروسات التي يمكنها أن تسبب أمراضًا مثل الزكام والالتهاب التنفُّسي الحاد الوخيم (السارس) ومتلازمة الشرق الأوسط التنفُّسية (ميرس). في عام 2019، اُكتشِف نوع جديد من فيروسات كورونا تسبب في تفشي مرض كان منشأه في الصين.',
            style: TextStyle(
                fontFamily: FontConst.fontFamily,
                fontWeight: FontWeightManager.regular),
            overflow: TextOverflow.ellipsis,
            maxLines: 7,
          )
        ],
      ),
    ),
  );
}
