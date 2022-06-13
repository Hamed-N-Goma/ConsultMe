import 'dart:io';

import 'package:consultme/Bloc/userBloc/cubit/userlayoutcubit_cubit.dart';
import 'package:consultme/components/components.dart';
import 'package:consultme/models/consultantmodel.dart';
import 'package:consultme/presentation_layer/presentation_layer_manager/color_manager/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class consultantDetails extends StatelessWidget {
  final ConsultantModel consultant;

  consultantDetails({Key? key, required this.consultant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocListener<UserLayoutCubit, UserLayoutState>(
        listener: (context, state) {});

    return BlocBuilder<UserLayoutCubit, UserLayoutState>(
        builder: (context, state) {
      var cubit = UserLayoutCubit.get(context);

      return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
              appBar: AppBar(
                title: buildCustomText(text: 'طلب إستشاره'),
              ),
              body: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: NetworkImage(consultant.image!),
                        //backgroundColor: Colors.lightBlue[100],
                        radius: 80,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        consultant.name!,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(
                        consultant.speachalist!,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (var i = 0; i < 5; i++)
                            const Icon(
                              Icons.star_rounded,
                              color: Colors.indigoAccent,
                              size: 30,
                            ),
                          if (5 - 4 > 0)
                            for (var i = 0; i < 4 - 4; i++)
                              const Icon(
                                Icons.star_rounded,
                                color: Colors.black12,
                                size: 30,
                              ),
                        ],
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Text(
                              ' المجال : ',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            Text(
                              consultant.department!,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Text(
                              'البريد الإلكتروني : ',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Text(
                              consultant.email!,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Text(
                              'رقم الهاتف : ',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            Text(
                              consultant.phone!,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Text(
                              'سنوات الخبرة : ',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            Text(
                              consultant.yearsofExperience!,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: defaultButton(
                            function: () {},
                            text: ' طلب إستشارة',
                            fontSize: 20,
                            radius: 10.0,
                            height: 59,
                            btnColor: mainColors,
                            width: double.infinity),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              )));
    });
  }
}
