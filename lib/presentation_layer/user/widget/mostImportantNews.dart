import 'package:cached_network_image/cached_network_image.dart';
import 'package:consultme/models/PostModel.dart';
import 'package:consultme/shard/style/theme/cubit/cubit.dart';
import 'package:flutter/material.dart';

import '../../presentation_layer_manager/color_manager/color_manager.dart';
import '../../presentation_layer_manager/font_manager/fontmanager.dart';

class MostImportnatNews extends StatelessWidget {
  final height, width;
  final PostModel post;

  const MostImportnatNews(
      {Key? key, this.height, this.width, required this.post})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      radius: 20,
      onTap: () {},
      child: Row(
        children: [
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                color: ColorManager.myWhite,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height,
                  width: width! / 2,
                  child: Padding(
                    padding: const EdgeInsets.all(1),
                    child: Column(
                      children: [
                        Text(
                          post.title!,
                          style: const TextStyle(
                              fontFamily: FontConst.fontFamily,
                              fontWeight: FontWeightManager.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          post.text!,
                          style: const TextStyle(
                              fontFamily: FontConst.fontFamily,
                              fontWeight: FontWeightManager.regular),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 7,
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: height,
                  width: width / 2,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(post.image!),
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
