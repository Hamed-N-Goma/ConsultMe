import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:consultme/Bloc/userBloc/cubit/userlayoutcubit_cubit.dart';
import 'package:consultme/presentation_layer/user/widget/messenger_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class Chat extends StatelessWidget {
  Chat({Key? key}) : super(key: key);
  var size, width, height;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserLayoutCubit, UserLayoutState>(
        listener: (context, state) {},
        builder: (context, state) {
          size = MediaQuery
              .of(context)
              .size;
          height = size.height;
          width = size.width;
          return Directionality(
            textDirection: TextDirection.rtl,
            child: ConditionalBuilder(
              condition: UserLayoutCubit
                  .get(context)
                  .conslutants
                  .length > 0,
              builder: (context) =>
                  ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) =>
                          Chatitem(UserLayoutCubit
                              .get(context)
                              .conslutants[index], context),
                      separatorBuilder: (context, index) => myDivider(),
                      itemCount: UserLayoutCubit
                          .get(context)
                          .conslutants
                          .length),
              fallback: (context) => Center(child: CircularProgressIndicator()),

            ),
          );
        },
    );
  }
}

Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);
