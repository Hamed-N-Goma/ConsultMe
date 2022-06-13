import 'package:carousel_slider/carousel_slider.dart';
import 'package:consultme/Bloc/userBloc/cubit/userlayoutcubit_cubit.dart';
import 'package:consultme/components/components.dart';
import 'package:consultme/models/consultantmodel.dart';
import 'package:consultme/presentation_layer/user/screens/view_all_impo_artcle.dart';
import 'package:consultme/presentation_layer/user/widget/category.dart';
import 'package:consultme/presentation_layer/user/widget/mostimportant.dart';
import 'package:consultme/presentation_layer/user/widget/toprated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation_layer_manager/color_manager/color_manager.dart';
import '../../presentation_layer_manager/font_manager/fontmanager.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  late List<ConsultantModel> allConsultants;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserLayoutCubit, UserLayoutState>(
      builder: (context, state) {
        if (state is GitConsultantsDataSucsess) {
          allConsultants = state.consultants;
          return buildLayout(context);
        } else if (state is ChangeThemeSuccessState) {
          return buildLayout(context);
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).indicatorColor,
            ),
          );
        }
      },
    );
  }

  Widget buildLayout(context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
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
                  style: Theme.of(context).textTheme.bodyText1),
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
                  style: Theme.of(context).textTheme.bodyText1),
            ),
            const SizedBox(
              height: 15,
            ),
            buildTopRatedConsultant(),
          ],
        ),
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
              itemBuilder: (context, index) => category(context),
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
            itemBuilder: (context, index, pageindex) =>
                buildMostImportant(context),
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
        itemBuilder: (context, index) => Toprated(
              consultant: allConsultants[index],
            ),
        separatorBuilder: (context, index) => const Divider(
              thickness: 16,
              color: Colors.transparent,
            ),
        itemCount: allConsultants.length);
  }

  Widget buildRowMostImportantText(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: buildCustomText(
            text: "مواضيع رآئجه :",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        TextButton(
          onPressed: () {
            navigateTo(context, ViewAll());
          },
          child: buildCustomText(
            text: 'عرض الكل',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ],
    );
  }
}
