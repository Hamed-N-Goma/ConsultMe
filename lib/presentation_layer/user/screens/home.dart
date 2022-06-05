import 'package:carousel_slider/carousel_slider.dart';
import 'package:consultme/components/components.dart';
import 'package:consultme/const.dart';
import 'package:consultme/presentation_layer/user/widget/category.dart';
import 'package:consultme/presentation_layer/user/widget/mostimportant.dart';
import 'package:consultme/presentation_layer/user/widget/toprated.dart';
import 'package:flutter/material.dart';

import '../../presentation_layer_manager/color_manager/color_manager.dart';
import '../../presentation_layer_manager/font_manager/fontmanager.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildLayout(context);
  }

  Widget buildLayout(context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: buildCustomText(
                text: "التخصصات",
                color: ColorManager.myBlack,
                fontFamily: FontConst.fontFamily,
                fontWight: FontWeightManager.bold,
                size: 18),
          ),
          const SizedBox(
            height: 15,
          ),
          buildCategoryList(),
          const SizedBox(
            height: 15,
          ),
          buildRowMostImportantText(context),
          const SizedBox(
            height: 15,
          ),
          buildMostImportantList(),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: buildCustomText(
                text: "الأعلى تقييمآ :",
                color: ColorManager.myBlack,
                fontFamily: FontConst.fontFamily,
                fontWight: FontWeightManager.bold,
                size: 18),
          ),
          const SizedBox(
            height: 15,
          ),
          buildTopRatedConsultant(),
        ],
      ),
    );
  }

  Widget buildCategoryList() {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 120,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => category(),
              separatorBuilder: (context, index) => const SizedBox(width: 5),
              itemCount: 30,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildMostImportantList() {
    return SizedBox(
        height: 150,
        width: double.infinity,
        child: CarouselSlider.builder(
            itemCount: 10,
            itemBuilder: (context, index, pageindex) => buildMostImportant(),
            options: CarouselOptions(
                height: 140,
                autoPlay: true,
                autoPlayCurve: Curves.slowMiddle,
                viewportFraction: 0.8,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                aspectRatio: 16 / 9,
                enableInfiniteScroll: true)));
  }

  Widget buildTopRatedConsultant() {
    return ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        primary: false,
        shrinkWrap: true,
        itemBuilder: (context, index) => Toprated(),
        separatorBuilder: (context, index) => const Divider(
              thickness: 16,
              color: Colors.transparent,
            ),
        itemCount: 20);
  }

  Widget buildRowMostImportantText(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: buildCustomText(
            text: "مواضيع رآئجه :",
            color: ColorManager.myBlack,
            fontWight: FontWeightManager.bold,
            fontFamily: FontConst.fontFamily,
            size: 18,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, viewAllImportantArtcle);
          },
          child: buildCustomText(
            text: 'عرض الكل',
            color: ColorManager.myBlack,
            fontWight: FontWeightManager.regular,
            fontFamily: FontConst.fontFamily,
            size: 14,
          ),
        ),
      ],
    );
  }
}
