import 'package:cached_network_image/cached_network_image.dart';
import 'package:consultme/Bloc/userBloc/cubit/userlayoutcubit_cubit.dart';
import 'package:consultme/models/PostModel.dart';
import 'package:consultme/presentation_layer/presentation_layer_manager/color_manager/color_manager.dart';
import 'package:consultme/presentation_layer/presentation_layer_manager/font_manager/fontmanager.dart';
import 'package:consultme/presentation_layer/user/widget/mostImportantNews.dart';
import 'package:consultme/shard/style/theme/cubit/cubit.dart';
import 'package:flutter/material.dart';

import '../../../components/components.dart';

class ViewAll extends StatelessWidget {
  ViewAll({Key? key}) : super(key: key);
  var size, width, height;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    var cubit = UserLayoutCubit.get(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 1,
          centerTitle: true,
          title: const Text('مواضيع رآئجه',
              style: TextStyle(
                color: Colors.black,
                fontFamily: FontConst.fontFamily,
                fontWeight: FontWeightManager.bold,
              )),
        ),
        body: Center(
          child: ListView.separated(
              itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: MostImportnatNews(
                      post: cubit.posts[index],
                      height: height * 0.158,
                      width: width,
                    ),
                  ),
              separatorBuilder: (context, index) => const SizedBox(),
              itemCount: UserLayoutCubit.get(context).posts.length),
        ),
      ),
    );
  }
}
