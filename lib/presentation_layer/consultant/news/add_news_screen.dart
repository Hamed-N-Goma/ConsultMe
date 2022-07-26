import 'package:consultme/Bloc/consultantBloc/cubit/consultant_cubit.dart';
import 'package:consultme/Bloc/consultantBloc/cubit/consultant_states.dart';
import 'package:consultme/components/components.dart';
import 'package:consultme/presentation_layer/consultant/success_screen.dart';
import 'package:consultme/presentation_layer/presentation_layer_manager/color_manager/color_manager.dart';
import 'package:consultme/shard/style/theme/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';


class AddPostScreen extends StatelessWidget {
  AddPostScreen({Key? key}) : super(key: key);

  var titleController = TextEditingController();
  var bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConsultantCubit, ConsultantStates>(
      listener: (context, state) {
        if(state is CreatePostSuccessState ){
          bodyController.clear();
          titleController.clear();
          ConsultantCubit.get(context).postImage = null;
          ConsultantCubit.get(context).removePostImage();
          navigateTo(context, const AddingSuccessScreen());
        }
        if(state is CreatePostLoadingState ){
          showDialog<void>(
              context: context,
              builder: (context)=> waitingDialog(context: context)
          );
        }
        if (state is CreatePostErrorState ){
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var cubit = ConsultantCubit.get(context);
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: dashAppBar(
              title: 'إضافة المنشور جديد',
              context: context,
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    dashTextFormField(
                      hint: 'عنوان المنشور',
                      controller: titleController,
                      context: context,
                      type: TextInputType.text,
                    ),
                    const SizedBox(height: 12.0,),
                    whiteBoard(
                        context,
                        hint: 'المحنوى ...',
                        controller: bodyController,
                    ),
                    const SizedBox(height: 12.0,),
                    Builder(
                        builder: (context) {
                          if(cubit.postImage != null){
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 42.0),
                              child: Stack(
                                alignment: AlignmentDirectional.topEnd,
                                children: [
                                  Stack(
                                    alignment: AlignmentDirectional.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                                        child: Container(
                                          width: double.infinity,
                                          height: 280.0,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8.0,),
                                            image: DecorationImage(
                                              image:FileImage(cubit.postImage!),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 288.0,
                                        margin: const EdgeInsets.symmetric(horizontal: 14.0),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8.0),
                                          border: Border.all(color: Colors.grey, width: 1),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 3.0),
                                    child: IconButton(
                                      onPressed: () {
                                        cubit.removePostImage();
                                      },
                                      icon: const CircleAvatar(
                                        radius: 20.0,
                                        child: Icon(
                                          Icons.close,
                                          size: 16.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }else{
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 72.0),
                              child: Container(
                                width: double.infinity,
                                height: 45.0,
                                decoration: BoxDecoration(
                                  color:
                                  ThemeCubit.get(context).darkTheme ? finesColorDark : Colors.white,
                                  borderRadius: BorderRadius.circular(
                                    8.0,
                                  ),
                                  border: Border.all(color: Colors.grey, width: 1),
                                ),
                                child: TextFormField(
                                  onTap: (){
                                    cubit.getPostImage();
                                  },
                                  decoration:  InputDecoration(
                                    suffixIcon: IconButton(
                                      onPressed: (){
                                        cubit.getPostImage();
                                      },
                                      icon: SvgPicture.asset(
                                        'assets/images/upload.svg',
                                        alignment: Alignment.center,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    border: InputBorder.none,
                                    hintStyle: Theme.of(context).textTheme.bodyText1,
                                    contentPadding: const EdgeInsetsDirectional.all(10.0),
                                    hintText: 'صورة المنشور',
                                  ),
                                ),
                              ),
                            );
                          }
                        }
                    ),
                    defaultButton(
                      function: (){
                        validation(
                          context: context,
                          title: titleController.text,
                          body: bodyController.text,
                          cubit: cubit,
                        );
                      },
                      text: 'نشر',
                      width: double.infinity,
                      height: 47.0,
                      btnColor: mainColors,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

void validation({
  required context,
  required String title,
  required String body,
  required ConsultantCubit cubit,
}){
  if(title.isEmpty){
    showToast(message: 'أدخل عنوان الخبر', state: ToastStates.ERROR);
  }else if(body.isEmpty){
    showToast(message: 'أدخل الموضوع', state: ToastStates.ERROR);
  }else if(cubit.postImage == null){
    cubit.createPost(
      dateTime: DateTime.now().toString(),
      text: body,
      title: title,
    );
    //showToast(message: 'أدخل الصورة', state: ToastStates.ERROR);
  }else{
    cubit.uploadPostImage(
      text: body,
      dateTime: DateTime.now().toString(),
      title: title ,
    );
  }
}