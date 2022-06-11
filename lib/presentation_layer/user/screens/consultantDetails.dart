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
  consultantDetails({Key? key , required this.cm}) : super(key: key);

  ConsultantModel cm;
  File? consultantPic;

  @override
  Widget build(BuildContext context) {
    BlocListener<UserLayoutCubit, UserLayoutState>(
        listener: (context, state) {});

    return BlocBuilder<UserLayoutCubit, UserLayoutState>(
        builder: (context, state) {
          var cubit = UserLayoutCubit.get(context);

          return Directionality(
              textDirection: TextDirection.rtl,
              child:  Scaffold(
                body: Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    height: 50,
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.only(left: 5),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.chevron_left_sharp,
                                        color: Colors.indigo,
                                        size: 30,
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                  CircleAvatar(
                                   // backgroundImage: NetworkImage(cm.image!),
                                    //backgroundColor: Colors.lightBlue[100],
                                    radius: 80,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    cm.name!,
                                    style: Theme.of(context).textTheme.headline6,

                                  ),

                                  Text(
                                    cm.speachalist!,
                                    style: Theme.of(context).textTheme.headline6,

                                  ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      for (var i = 0; i < 5; i++)
                                        Icon(
                                          Icons.star_rounded,
                                          color: Colors.indigoAccent,
                                          size: 30,
                                        ),
                                      if (5 - 4 > 0)
                                        for (var i = 0; i < 4 - 4; i++)
                                          Icon(
                                            Icons.star_rounded,
                                            color: Colors.black12,
                                            size: 30,
                                          ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 80,
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 10),
                                    child: Row(
                                      children: [
                                        Text(
                                          ' المجال : ',
                                          style: Theme.of(context).textTheme.subtitle1,

                                        ),
                                        SizedBox(
                                          width: 50,
                                        ),
                                        Text(

                                          cm.department!,
                                          style: Theme.of(context).textTheme.subtitle1,

                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 10),
                                    child: Row(
                                      children: [
                                        Text(
                                          'البريد الإلكتروني : ',
                                          style: Theme.of(context).textTheme.subtitle1,

                                        ),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Text(
                                          cm.email!,
                                          style: Theme.of(context).textTheme.subtitle1,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 10),
                                    child: Row(
                                      children: [
                                        Text(
                                          'رقم الهاتف : ',
                                          style: Theme.of(context).textTheme.subtitle1,

                                        ),
                                        SizedBox(
                                          width: 50,
                                        ),
                                        Text(
                                          cm.phone!,
                                          style: Theme.of(context).textTheme.subtitle1,
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 10),
                                    child: Row(
                                      children: [
                                        Text(
                                          'سنوات الخبرة : ',
                                          style: Theme.of(context).textTheme.subtitle1,

                                        ),
                                        SizedBox(
                                          width: 50,
                                        ),
                                        Text(
                                         cm.yearsofExperience!,
                                          style: Theme.of(context).textTheme.subtitle1,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 100,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                    child: defaultButton(
                                        function: (){

                                        },
                                        text: ' طلب إستشارة',
                                        fontSize: 20,
                                        radius: 10.0,
                                        height: 59,
                                        btnColor: mainColors,
                                        width: double.infinity
                                    ),
                                  ),

                                  SizedBox(
                                    height: 40,
                                  ),
                                ],
                              ),
                            ))
          );




        });
  }}
