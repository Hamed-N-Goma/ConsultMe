import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:consultme/Bloc/userBloc/cubit/userlayoutcubit_cubit.dart';
import 'package:consultme/models/categorymodel.dart';
import 'package:consultme/models/consultantmodel.dart';
import 'package:consultme/models/favoriteModel.dart';
import 'package:consultme/presentation_layer/user/widget/toprated.dart';
import 'package:consultme/shard/style/iconly_broken.dart';
import 'package:consultme/shard/style/theme/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategoryDetails extends StatelessWidget {
  final List<ConsultantModel> spechalist;
  final CategoryModel categotyItem;

  CategoryDetails(
      {Key? key, required this.spechalist, required this.categotyItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(categotyItem.name!,
              style: Theme.of(context).textTheme.bodyLarge),
          centerTitle: true,
          elevation: 5,
        ),
        body: buildMain(),
      ),
    );
  }

  Widget buildMain() {
    return ConditionalBuilder(
        builder: (context) => buildCategoryList(),
        condition: spechalist.isNotEmpty,
        fallback: (context) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(FontAwesomeIcons.neos)],
              ),
            ));
  }

  Widget buildCategoryList() {
    return ListView.separated(
        itemBuilder: (context, index) => Toprated(
            consultant: spechalist[index],
            favoriteUid:
                BlocProvider.of<UserLayoutCubit>(context).favoriteList),
        separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
        itemCount: spechalist.length);
  }

  Widget buildSearchfallback() {
    return Expanded(
      child: SizedBox(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              IconBroken.Search,
              color: Colors.grey[400],
              size: 150,
            ),
            Text(
              'إبحث عن مستشار',
            )
          ],
        ),
      )),
    );
  }
}
