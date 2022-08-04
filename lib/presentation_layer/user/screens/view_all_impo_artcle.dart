import 'package:cached_network_image/cached_network_image.dart';
import 'package:consultme/Bloc/userBloc/cubit/userlayoutcubit_cubit.dart';
import 'package:consultme/models/PostModel.dart';
import 'package:consultme/presentation_layer/presentation_layer_manager/color_manager/color_manager.dart';
import 'package:consultme/presentation_layer/presentation_layer_manager/font_manager/fontmanager.dart';
import 'package:consultme/presentation_layer/user/screens/postsDetails.dart';
import 'package:consultme/presentation_layer/user/widget/mostImportantNews.dart';
import 'package:consultme/shard/style/theme/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../components/components.dart';
import 'dart:ui' as ui;
class ViewAll extends StatelessWidget {
  ViewAll({Key? key}) : super(key: key);
  var size, width, height;

  @override
  Widget build(BuildContext context) {
    var cubit = UserLayoutCubit.get(context);

    return Directionality(
        textDirection: ui.TextDirection.rtl,
        child: Scaffold(
          appBar: dashAppBar(
            title: 'إستشرني',
            context: context,
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Builder(
                builder: (context) {
                //  if (state is GetNewsLoadingStates) {
               //     return const SizedBox(
               //         width: double.infinity,
              //          height: 300.0,
              //          child: Center(child: CircularProgressIndicator()));
               //   } else {
                    return Column(
                      children: [

                        const SizedBox(
                          height: 20.0,
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => buildNewsItem(
                              context: context,
                              model: UserLayoutCubit.get(context).posts[index],
                              cubit: cubit),
                          separatorBuilder: (context, index) =>
                          const SizedBox(
                            height: 16,
                          ),
                          itemCount: UserLayoutCubit.get(context).posts.length,
                        ),
                      ],
                    );
                  }
                ),
              ),
            ),
          ),

  );}
}

Widget buildNewsItem({
  context,
  required PostModel model,
  required UserLayoutCubit cubit,
}) {
  DateTime tempDate =
  DateFormat("yyyy-MM-dd").parse(model.dateTime!);
  String date = tempDate.toString().substring(0, 10);

  return  Container(
      decoration: BoxDecoration(
        border: Border.all(color: mainColors.withOpacity(0.5), width: 2),
        borderRadius: BorderRadius.circular(
          10.0,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120.0,
            height: 100.0,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: CachedNetworkImage(
                imageUrl: '${model.postImage}',
                placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>  Container(
                  alignment: Alignment.center,
                  height: 80.0,
                  child: Icon(Icons.error,
                    color: ThemeCubit.get(context).darkTheme
                        ? mainTextColor
                        : mainColors,),
                ),
                fit:BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: SizedBox(
                height: 80.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${model.title}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            date,
                            style:  Theme.of(context).textTheme.bodyText1?.copyWith
                              (
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          alignment: Alignment.bottomLeft,
                          child: InkWell(
                            child: Text(
                              'عرض المنشور',
                              style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            onTap: () {
                              navigateTo(
                                  context,
                                  PostsDetails(
                                    post : model,
                                  ));
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  ;
}
