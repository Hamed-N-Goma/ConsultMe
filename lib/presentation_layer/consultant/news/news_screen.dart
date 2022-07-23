import 'dart:ui' as ui;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:consultme/Bloc/consultantBloc/cubit/consultant_cubit.dart';
import 'package:consultme/Bloc/consultantBloc/cubit/consultant_states.dart';
import 'package:consultme/components/components.dart';
import 'package:consultme/models/PostModel.dart';
import 'package:consultme/presentation_layer/presentation_layer_manager/color_manager/color_manager.dart';
import 'package:consultme/shard/style/theme/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';


import 'add_news_screen.dart';
import 'news_dash_details_screen.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConsultantCubit, ConsultantStates>(
      listener: (context, state) {
        if (state is DelNewsSuccessStates) {
          Navigator.pop(context);
        }
        if (state is DelNewsLoadingStates) {
          showDialog<void>(
              context: context,
              builder: (context) => waitingDialog(context: context));
        }
        if (state is DelNewsErrorStates) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var cubit = ConsultantCubit.get(context);
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
                padding: const EdgeInsets.all(20.0),
                child: Builder(
                  builder: (context) {
                    if (state is GetNewsLoadingStates) {
                      return const SizedBox(
                          width: double.infinity,
                          height: 300.0,
                          child: Center(child: CircularProgressIndicator()));
                    } else {
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
                                model: ConsultantCubit.get(context).posts[index],
                                cubit: cubit),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 16,
                            ),
                            itemCount: ConsultantCubit.get(context).posts.length,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          defaultButton(
                            text: 'إضافة المنشور جديد',
                            function: () {
                              navigateTo(context, AddPostScreen());
                            },
                            btnColor: mainColors,
                            width: double.infinity,
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget buildNewsItem({
  context,
  required PostModel model,
  required ConsultantCubit cubit,
}) {
  DateTime tempDate =
      DateFormat("yyyy-MM-dd").parse(model.dateTime!);
  String date = tempDate.toString().substring(0, 10);

  return Dismissible(
    direction: DismissDirection.startToEnd,
    resizeDuration: const Duration(milliseconds: 200),
    onDismissed: (direction) {
      showDialog<void>(
        context: context,
        builder: (context) =>
            AlertDialog(
              backgroundColor: ThemeCubit
                  .get(context)
                  .darkTheme
                  ? mainColors
                  : Colors.white,
              content: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/warning.svg',
                        width: 25.0,
                        height: 25.0,
                        alignment: Alignment.center,
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        'تأكيد حذف المنشور ؟',
                        style:
                        Theme
                            .of(context)
                            .textTheme
                            .subtitle1,
                      ),
                    ],
                  ),
                ),

              contentPadding: EdgeInsets.zero,
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'الغاء',
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyText1,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    cubit.DeletePost(model.postID);
                    Navigator.pop(context);
                  },
                  child: Text(
                    'حذف',
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.red),
                  ),
                ),
              ],
            ),
      );
    },
    background: Container(
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadiusDirectional.circular(8.0),
      ),
      padding: const EdgeInsets.all(5.0),
      alignment: AlignmentDirectional.centerStart,
      child: const Icon(
        Icons.delete_forever,
        color: Colors.white,
      ),
    ),
    key: UniqueKey(),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(
          8.0,
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
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            date,
                            style: TextStyle(
                              color: separator,
                              fontSize: 10.0,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          alignment: Alignment.bottomLeft,
                          child: InkWell(
                            child: Text(
                              'عرض المزيد',
                              style:
                                  Theme.of(context).textTheme.bodyText2!.copyWith(
                                        decoration: TextDecoration.underline,
                                      ),
                            ),
                            onTap: () {
                              navigateTo(
                                  context,
                                  NewsDashDetailsScreen(
                                    model: model,
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
    ),
  );
}
