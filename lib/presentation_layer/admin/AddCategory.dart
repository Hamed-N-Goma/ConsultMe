import 'package:cached_network_image/cached_network_image.dart';
import 'package:consultme/Bloc/adminBloc/cubit/admin_cubit.dart';
import 'package:consultme/Bloc/adminBloc/cubit/admin_states.dart';
import 'package:consultme/Bloc/userBloc/cubit/userlayoutcubit_cubit.dart';
import 'package:consultme/components/components.dart';
import 'package:consultme/models/categorymodel.dart';
import 'package:consultme/presentation_layer/admin/success_screen.dart';
import 'package:consultme/presentation_layer/presentation_layer_manager/color_manager/color_manager.dart';
import 'package:consultme/shard/style/theme/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'EditCategory.dart';


class AddCategoy extends StatelessWidget {
  AddCategoy({Key? key}) : super(key: key);

  var nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {
        if(state is CreateCategorySuccessState ){
          AdminCubit.get(context).categImage = null ;
          nameController.clear();
          navigateTo(context, const AddingSuccessScreen());
        }
        else if (state is CreateCategoryLoadingState){
          showDialog<void>(
              context: context,
              builder: (context)=> waitingDialog(context: context)
          );
        }
        else if (state is DeleteCategoryLoadingState){
          showDialog<void>(
              context: context,
              builder: (context)=> waitingDialog(context: context)
          );
        }
        else if (state is CreateCategoryErrorState ){
          Navigator.pop(context);
        }
        else if (state is DeleteCategorySuccessState){
          Navigator.pop(context);

        }
      },
      builder: (context, state) {
        var cubit = AdminCubit.get(context);
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: dashAppBar(
              title: 'إضافة تخصص جديد',
              context: context,
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    dashTextFormField(
                      hint: 'اسم التخصص ',
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
                                        cubit.removecategImage();
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
                              padding: const EdgeInsets.only(bottom: 40.0),
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
                                    hintText: 'صورة ترمز للتخصص',
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
                      text: 'إضافة القسم',
                      width: double.infinity,
                      height: 47.0,
                      btnColor: mainColors,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => buildCategoryItem(
                          context: context,
                          model: AdminCubit.get(context).categorys[index],
                          cubit: cubit),
                      separatorBuilder: (context, index) =>
                      const SizedBox(
                        height: 16,
                      ),
                      itemCount: AdminCubit.get(context).categorys.length,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'ملاحظة : اسحب القسم لحذفه',
                      textDirection: TextDirection.rtl,
                      style:
                      Theme
                          .of(context)
                          .textTheme
                          .bodyText1,
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

Widget buildCategoryItem({
  context,
  required CategoryModel model,
  required AdminCubit cubit,
}) {

  return Dismissible(
    direction: DismissDirection.startToEnd,
    resizeDuration: const Duration(milliseconds: 200),
    onDismissed: (direction) {
        showDialog<void>(
          context: context,
          builder: (context) =>
              AlertDialog(
                backgroundColor: ThemeCubit
                    .get(context)
                    .darkTheme
                    ? mainColors
                    : Colors.white,
                content: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/warning.svg',
                          width: 25.0,
                          height: 25.0,
                          alignment: Alignment.center,
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          'سيتم حذف جميع مستشارين ${model.name}',
                          textDirection: TextDirection.rtl,
                          style:
                          Theme
                              .of(context)
                              .textTheme
                              .bodyText1,
                        ),

                      ],
                    ),
                  ),
                ),
                contentPadding: EdgeInsets.zero,
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'الغاء',
                      textDirection: TextDirection.rtl,
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyText1,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      cubit.DeleteCategory(model);
                      cubit.DeleteAllConsultByCategory(model);
                       Navigator.pop(context);
                    },
                    child: Text(
                      'حذف',
                      textDirection: TextDirection.rtl,
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.red),
                    ),
                  ),
                ],
              ),
        );

    },

    background: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadiusDirectional.circular(8.0),
        ),
        padding: const EdgeInsets.all(5.0),
        alignment: AlignmentDirectional.centerStart,
        child: const Icon(
          Icons.delete_forever,
          color: Colors.white,
        ),
      ),
    ),
    key: UniqueKey(),
    child: InkWell(
      onTap: () {
        navigateTo(context, EditCategory(categoryModel: model,));
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: mainColors.withOpacity(0.2), width: 3),
          borderRadius: BorderRadius.circular(
            20.0,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100.0,
              height: 90.0,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                  child: CachedNetworkImage(
                    imageUrl: '${model.image}',
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  height: 80.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          '${model.name}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
