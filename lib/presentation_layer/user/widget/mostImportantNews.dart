import 'package:cached_network_image/cached_network_image.dart';
import 'package:consultme/Bloc/userBloc/cubit/userlayoutcubit_cubit.dart';
import 'package:consultme/components/components.dart';
import 'package:consultme/models/PostModel.dart';
import 'package:consultme/presentation_layer/user/screens/postsDetails.dart';
import 'package:consultme/shard/style/theme/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:consultme/models/consultantmodel.dart';

import '../../presentation_layer_manager/color_manager/color_manager.dart';
import '../../presentation_layer_manager/font_manager/fontmanager.dart';

class MostImportnatNews extends StatelessWidget {
  final height, width;
  final PostModel post;
  ConsultantModel? consultantModel;

   MostImportnatNews(
      {Key? key, this.height, this.width, required this.post})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserLayoutCubit.get(context).getConsultById(post.uid);
    consultantModel = UserLayoutCubit.get(context).consult;
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      radius: 20,
      onTap: () {
        navigateTo(
            context,
            PostsDetails(
              model: post,
            ));
      },
      child: Row(
        children: [
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                color:ThemeCubit.get(context).darkTheme
                    ? mainColors
                    : Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.2),
                    offset: Offset(2, 2),
                    blurRadius: 4,
                    spreadRadius: 0.5,
                  )
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height,
                  width: width! / 2,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          post.title!,
                          style: Theme.of(context).textTheme.headline6!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Text(
                          post.text!,
                          style: Theme.of(context).textTheme.bodyText2!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: height,
                  width: width / 2,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(post.postImage!),
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
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
