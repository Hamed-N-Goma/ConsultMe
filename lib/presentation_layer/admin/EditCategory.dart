import 'dart:io';
import 'package:consultme/Bloc/adminBloc/cubit/admin_cubit.dart';
import 'package:consultme/Bloc/adminBloc/cubit/admin_states.dart';
import 'package:consultme/Bloc/userBloc/cubit/userlayoutcubit_cubit.dart';
import 'package:consultme/presentation_layer/presentation_layer_manager/color_manager/color_manager.dart';
import 'package:consultme/shard/style/iconly_broken.dart';
import 'package:consultme/shard/style/theme/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../components/components.dart';
import '../../models/categorymodel.dart';

class EditCategory extends StatelessWidget {
  EditCategory({Key? key , required this.categoryModel }) : super(key: key);
  CategoryModel categoryModel;

  var nameController = TextEditingController();

  File? imagePicker;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
        builder: (context, state) {
          imagePicker = AdminCubit.get(context).EditcategImage;
          nameController = TextEditingController(text: categoryModel.name);

          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: dashAppBar(
                title: 'تعديل بيانات القسم',
                context: context,
                pop: true,
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: buildEditableCategImg(context, categoryModel, imagePicker),
                      )
                    ],
                  ),
                ),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
               floatingActionButton: Padding(
               padding: const EdgeInsets.all(20.0),
                    child: FloatingActionButton(
                         child: Icon(Icons.edit),
                         backgroundColor: mainColors,
                         onPressed: () {
                           AdminCubit.get(context).updateCategory(
                               name: nameController.text,
                               categoryModel : categoryModel,);
                         },
                    ),
             ),
          ));
        }, listener: (context, state) {
      if (state is EditcategImagePickedSuccessState) {
        AdminCubit.get(context).uploadEditcategImage();
      }
      else if (state is EditCategoryLoadingState) {
        showDialog<void>(
            context: context,
            builder: (context)=> waitingDialog(context: context)
        );
      }
      else if (state is EditCategorySuccessState) {
        AdminCubit.get(context).EditcategImage = null ;
        Navigator.pop(context);
      }
    });
  }

  Widget buildEditableCategImg(context, categoryModel, imagePicker) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [

          const SizedBox(
            height: 5,
          ),
          buildCustomText(
            text: categoryModel!.name,
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 60,
            child: defaultFormField(
                controller: nameController,
                type: TextInputType.name,
                validate: (String? value) {
                  if (value!.isEmpty  ) {
                    return 'اسم القسم فارغ  !';
                  } else if (int.tryParse(value!) == null && value != ''){
                    return 'الرجاء ادخال اسم القسم صحيح';
                  }else {
                    return null;
                  }
                },
                prefix: IconBroken.User,
                context: context,
                label: "إسم القسم "),
          ),
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            height: 120,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                buildEditableImg(
                    context: context,
                    image: categoryModel!.image,
                    imagepicker: imagePicker),
              ],
            ),
          ),


     //     defaultButton(
     //       function: () {
     //         AdminCubit.get(context).updateCategory(
     //           name: nameController.text,
     //           categoryModel : categoryModel,
     //         );
   //         },
    //        text: 'تعديل ',
    //        fontSize: 18,
    //        height: 60.0,
    //        btnColor: mainColors,
     //       width: double.infinity,
    //      ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }


  Widget buildEditableImg({context, image, imagepicker}) {
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: [
        CircleAvatar(
          radius: 54,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          child: CircleAvatar(
            radius: 100.0,
            backgroundImage: imagePicker == null
                ? NetworkImage(image)
                : FileImage(imagepicker) as ImageProvider,
          ),
        ),
        IconButton(
          onPressed: () async {
            AdminCubit.get(context).getEditcategImage();
          },
          icon: const CircleAvatar(
            child: Icon(IconBroken.Image),
            radius: 16.0,
          ),
        ),
      ],
    );
  }

  Widget buildinfoItems(
      {required context, required titleText, required bodyText}) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      buildCustomText(
        text: titleText,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      const SizedBox(
        width: 20,
      ),
    ]);
  }
}
