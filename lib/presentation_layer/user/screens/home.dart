import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:consultme/Bloc/userBloc/cubit/userlayoutcubit_cubit.dart';
import 'package:consultme/components/components.dart';
import 'package:consultme/models/PostModel.dart';
import 'package:consultme/models/categorymodel.dart';
import 'package:consultme/models/consultantmodel.dart';
import 'package:consultme/models/favoriteModel.dart';
import 'package:consultme/presentation_layer/user/screens/view_all_impo_artcle.dart';
import 'package:consultme/presentation_layer/user/widget/category.dart';
import 'package:consultme/presentation_layer/user/widget/mostImportantNews.dart';
import 'package:consultme/presentation_layer/user/widget/mostimportant.dart';
import 'package:consultme/presentation_layer/user/widget/toprated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation_layer_manager/color_manager/color_manager.dart';
import '../../presentation_layer_manager/font_manager/fontmanager.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  List<ConsultantModel> allConsultants = [];
  List<CategoryModel> categoryList = [];
  List<FavoriteModel> favorite = [];
  List<PostModel> posts = [];


  var size, width, height;
  bool categoryfalg = false;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return BlocListener<UserLayoutCubit, UserLayoutState>(
      listener: (context, state) {
        if (state is GetCategoryDataSucsses) {
          categoryList = state.category;
        }
        if (state is GetConsultanatDataSucsses) {
          allConsultants = state.consultants;
        }
        if (state is GetConsultantToFavoriteSucssesfuly) {
          favorite = state.favoriteConsultant;
          print('from hoooooooooooooooome');
        }
        if (state is GetAllPostsSuccessState) {
          posts = state.posts;
        }

      },
      child: BlocBuilder<UserLayoutCubit, UserLayoutState>(
        builder: (context, state) {
          List<FavoriteModel> myfave =
              BlocProvider.of<UserLayoutCubit>(context).favoriteList;

          if (allConsultants.isNotEmpty &&
              categoryList.isNotEmpty &&
              posts.isNotEmpty) {
            return buildLayout(context, myfave);
          } else {
            return Center(
                child: CircularProgressIndicator(
              color: Theme.of(context).progressIndicatorTheme.color,
            ));
          }
        },
      ),
    );
  }

  Widget buildLayout(context, myfave) {
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
            buildMostImportantList(context),
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
            buildTopRatedConsultant(myfave),
            const SizedBox(
              height: 15,
            ),
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
              itemBuilder: (context, index) => Category(
                categotyItem: categoryList[index],
                allConsultants: allConsultants,
              ),
              separatorBuilder: (context, index) => const SizedBox(width: 7),
              itemCount: categoryList.length,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildMostImportantList(context) {
    return SizedBox(
        height: 150,
        width: double.infinity,
        child: CarouselSlider.builder(
            itemCount: UserLayoutCubit.get(context).posts.length,
            itemBuilder: (context, index, pageindex) => MostImportnatNews(
                post: posts[index], height: height, width: width - 10),
            options: CarouselOptions(
                height: 140,
                autoPlay: true,
                autoPlayCurve: Curves.slowMiddle,
                viewportFraction: 1,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                aspectRatio: 16 / 9,
                enableInfiniteScroll: true)));
  }

  Widget buildTopRatedConsultant(myfave) {
    return ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        primary: false,
        shrinkWrap: true,
        itemBuilder: (context, index) => Toprated(
              consultant: allConsultants[index],
              favoriteUid: myfave,
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
