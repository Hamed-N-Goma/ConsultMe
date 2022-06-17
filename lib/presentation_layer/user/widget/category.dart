import 'package:consultme/components/components.dart';
import 'package:consultme/models/categorymodel.dart';
import 'package:consultme/models/consultantmodel.dart';
import 'package:consultme/presentation_layer/user/screens/categoryDetails.dart';
import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  final CategoryModel categotyItem;
  final List<ConsultantModel> allConsultants;
  Category({
    Key? key,
    required this.categotyItem,
    required this.allConsultants,
  }) : super(key: key);
  List<ConsultantModel> spechalist = [];

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      InkWell(
          radius: 30,
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          onTap: () {
            divideChoosingCategory();
            navigateTo(
                context,
                CategoryDetails(
                  spechalist: spechalist,
                  categotyItem: categotyItem,
                ));
          },
          child: CircleAvatar(
            backgroundImage: NetworkImage(categotyItem.image!),
            radius: 40,
          )),
      const SizedBox(
        height: 10,
      ),
      Text(
        categotyItem.name!,
        style: Theme.of(context).textTheme.bodyText1,
      )
    ]);
  }

  void divideChoosingCategory() {
    allConsultants.forEach((element) {
      spechalist = allConsultants
          .where((element) => element.speachalist == categotyItem.name)
          .toList();
    });
  }
}
