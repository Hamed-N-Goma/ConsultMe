import 'package:cached_network_image/cached_network_image.dart';
import 'package:consultme/Bloc/userBloc/cubit/userlayoutcubit_cubit.dart';
import 'package:consultme/models/PostModel.dart';
import 'package:consultme/presentation_layer/presentation_layer_manager/color_manager/color_manager.dart';
import 'package:consultme/presentation_layer/presentation_layer_manager/font_manager/fontmanager.dart';
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
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
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
                  padding: EdgeInsets.only(left: 10, right: 10, top: 15),
                  child: mostImportantItem(
                      width: width - 20,
                      cubit: cubit,
                      model: UserLayoutCubit.get(context).posts[index]
                  )),
              separatorBuilder: (context, index) => const SizedBox(),
              itemCount: UserLayoutCubit.get(context).posts.length ),
        ),
      ),
    );
  }
}
