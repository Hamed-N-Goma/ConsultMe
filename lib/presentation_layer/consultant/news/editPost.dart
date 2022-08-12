import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:consultme/Bloc/adminBloc/cubit/admin_cubit.dart';
import 'package:consultme/Bloc/adminBloc/cubit/admin_states.dart';
import 'package:consultme/Bloc/consultantBloc/cubit/consultant_cubit.dart';
import 'package:consultme/Bloc/consultantBloc/cubit/consultant_states.dart';
import 'package:consultme/Bloc/userBloc/cubit/userlayoutcubit_cubit.dart';
import 'package:consultme/models/PostModel.dart';
import 'package:consultme/presentation_layer/consultant/consultant_home_screen.dart';
import 'package:consultme/presentation_layer/presentation_layer_manager/color_manager/color_manager.dart';
import 'package:consultme/shard/style/iconly_broken.dart';
import 'package:consultme/shard/style/theme/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../components/components.dart';

class EditPost extends StatelessWidget {
  EditPost({Key? key , required this.postModel }) : super(key: key);
  PostModel postModel;

  var titleController = TextEditingController();
  var textController = TextEditingController();

  File? imagePicker;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConsultantCubit, ConsultantStates>(
        builder: (context, state) {
          imagePicker = ConsultantCubit.get(context).EditPostImage;
          titleController = TextEditingController(text: postModel.title);
          textController = TextEditingController(text: postModel.text);

          return Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                appBar: dashAppBar(
                  title: 'تعديل بيانات المنشور',
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
                          child: buildEditablePostImg(context, postModel, imagePicker),
                        )
                      ],
                    ),
                  ),
                ),
                floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
                floatingActionButton: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: FloatingActionButton(
                    highlightElevation: 40,
                    child: Icon(Icons.edit),
                    backgroundColor: mainColors,
                    onPressed: () {
                      ConsultantCubit.get(context).updatePost(
                        postModel: postModel,
                        title: titleController.text,
                        text: textController.text,
                      );
                    },
                  ),
                ),
              ));
        }, listener: (context, state) {
      if (state is EditPostImagePickedSuccessState) {
        ConsultantCubit.get(context).uploadEditPostImage();
      }
      else if (state is EditPostLoadingState) {
        showDialog<void>(
            context: context,
            builder: (context)=> waitingDialog(context: context)
        );
      }
      else if (state is EditPostSuccessState) {
        ConsultantCubit.get(context).EditPostImage = null ;
        navigateTo(context, ConsultantHomeScreen());
      }
    });
  }

  Widget buildEditablePostImg(context, postModel, imagePicker) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [

          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 120,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                buildEditableImg(
                    context: context,
                    image: postModel!.postImage,
                    imagepicker: imagePicker),
              ],
            ),
          ),

          const SizedBox(
            height: 50,
          ),

          TextFormField(
            controller: titleController,
            style: Theme.of(context).textTheme.bodyText1,
            validator: (String? value) {
              if (value!.isEmpty  ) {
                return 'العنوان فارغ  !!';
              } else if (int.tryParse(value) == null && value != ''){
                return 'الرجاء ادخال عنوان صحيح';
              }else {
                return null;
              }
            },
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.all(15.0),
              border: const OutlineInputBorder(),
              hintText: "العنوان ",
              hintStyle: const TextStyle(
                fontSize: 15.0,
                color: Colors.grey,
              ),
              enabledBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),

                borderSide: BorderSide(
                  color: mainColors,
                ),
              ),
            ),
          ),

          const SizedBox(
            height: 20,
          ),
          whiteBoard
            (
            context,
            controller: textController,
          ),
          const SizedBox(
            height: 50,
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
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color:
          ThemeCubit.get(context).darkTheme ? finesColorDark : Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: mainColors, width: 2),
          boxShadow: [
            BoxShadow(
              color: ThemeCubit.get(context).darkTheme
                  ? Colors.black.withOpacity(0.5)
                  : Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(5, 5), // changes position of shadow
            ),
          ],
        ),
        child: Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            CircleAvatar(
              radius: 54,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              child:  SizedBox(
                width: 200.0,
                height: 200.0,
                child: CachedNetworkImage(
                  imageUrl: '${image}',
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
            IconButton(
              onPressed: () async {
                ConsultantCubit.get(context).getEditPostImage();
              },
              icon: const CircleAvatar(
                child: Icon(IconBroken.Image),
                radius: 16.0,
              ),
            ),
          ],
        ),
      ),
    );

  }
}
