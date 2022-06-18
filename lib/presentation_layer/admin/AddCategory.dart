import 'package:consultme/Bloc/adminBloc/cubit/admin_cubit.dart';
import 'package:consultme/Bloc/adminBloc/cubit/admin_states.dart';
import 'package:consultme/components/components.dart';
import 'package:consultme/presentation_layer/consultant/success_screen.dart';
import 'package:consultme/presentation_layer/presentation_layer_manager/color_manager/color_manager.dart';
import 'package:consultme/shard/style/theme/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';


class AddCategoy extends StatelessWidget {
  AddCategoy({Key? key}) : super(key: key);

  var nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {
        if(state is CreateCategorySuccessState ){
          navigateTo(context, const AddingSuccessScreen());
        }
        if(state is CreateCategoryLoadingState ){
          showDialog<void>(
              context: context,
              builder: (context)=> waitingDialog(context: context)
          );
        }
        if (state is CreateCategoryErrorState ){
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var cubit = AdminCubit.get(context);
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: dashAppBar(
              title: 'إضافة قسم جديد',
              context: context,
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    dashTextFormField(
                      hint: 'اسم القسم ',
                      controller: nameController,
                      context: context,
                      type: TextInputType.text,
                    ),
                    const SizedBox(height: 12.0,),
                    Builder(
                        builder: (context) {
                          if(cubit.categImage != null){
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
                                              image:FileImage(cubit.categImage!),
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
                                    cubit.getcategImage();
                                  },
                                  decoration:  InputDecoration(
                                    suffixIcon: IconButton(
                                      onPressed: (){
                                        cubit.getcategImage();
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
                                    hintText: 'صورة ترمز للقسم',
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
                          name: nameController.text,
                          cubit: cubit,
                        );
                      },
                      text: 'إضافة الخبر',
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
  required String name,
  required AdminCubit cubit,
}){
  if(name.isEmpty){
    showToast(message: 'أدخل اسم القسم ', state: ToastStates.ERROR);
  }else if(cubit.categImage == null){
    cubit.AddCategory(
      name: name,
    );
    //showToast(message: 'أدخل الصورة', state: ToastStates.ERROR);
  }else{
    cubit.uploadcategImage(
      name: name,
    );
  }
}