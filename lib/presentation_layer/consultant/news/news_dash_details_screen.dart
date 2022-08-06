import 'package:cached_network_image/cached_network_image.dart';
import 'package:consultme/Bloc/consultantBloc/cubit/consultant_cubit.dart';
import 'package:consultme/Bloc/consultantBloc/cubit/consultant_states.dart';
import 'package:consultme/components/components.dart';
import 'package:consultme/models/PostModel.dart';
import 'package:consultme/presentation_layer/consultant/news/editPost.dart';
import 'package:consultme/presentation_layer/presentation_layer_manager/color_manager/color_manager.dart';
import 'package:consultme/shard/style/theme/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../shard/style/iconly_broken.dart';


class NewsDashDetailsScreen extends StatelessWidget {

   PostModel model;
   NewsDashDetailsScreen({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConsultantCubit, ConsultantStates>(
      listener: (context,state){},
      builder: (BuildContext context, Object? state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: dashAppBar(
              title:  '${model.title}',
              context: context,
              action: IconButton(
                icon: Icon(
                    IconBroken.Edit,
                  color: ThemeCubit.get(context).darkTheme
                      ? mainTextColor
                      : mainColors,
                ),
                onPressed: () { 
                  navigateTo(context, EditPost(postModel: model,));
                },
              ),
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children:  [
                      Stack(
                        alignment: Alignment.topLeft,
                        children:  [

                          CachedNetworkImage(
                            imageUrl: '${model.postImage}',
                            placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>  Container(
                                alignment: Alignment.center,
                                height: 200.0,
                                child: Icon(Icons.error,
                                  color: ThemeCubit.get(context).darkTheme
                                      ? mainTextColor
                                      : mainColors,),
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            height: 20.0,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft:  Radius.circular(32.0),
                                topRight: Radius.circular(32.0),
                              ),
                              color: ThemeCubit.get(context).darkTheme? backGroundDark : backGround,
                            ),
                          ),
                          Container(
                            height: 5.0,
                            color: ThemeCubit.get(context).darkTheme? backGroundDark : backGround,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      '${model.title}',
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  const SizedBox(height: 18.0,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      '${model.text}',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}


