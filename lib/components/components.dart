import 'package:consultme/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

import '../Bloc/adminBloc/cubit/admin_cubit.dart';
import '../Bloc/consultantBloc/cubit/consultant_cubit.dart';
import '../presentation_layer/presentation_layer_manager/color_manager/color_manager.dart';
import '../presentation_layer/presentation_layer_manager/font_manager/fontmanager.dart';
import '../shard/style/iconly_broken.dart';
import '../shard/style/theme/cubit/cubit.dart';

Widget buildCustomText(
        {required String text,
        Color? color,
        double? size,
        String? fontFamily,
        FontWeight? fontWight,
        TextStyle? style}) =>
    Text(text, style: style);

Widget mostImportantItem({
  Function()? ontap,
  double? height,
  double? width,
}) =>
    InkWell(
      borderRadius: BorderRadius.circular(20),
      radius: 20,
      onTap: ontap,
      child: Row(
        children: [
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                color: ColorManager.myWhite,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.2),
                    offset: Offset(2, 2),
                    blurRadius: 4,
                    spreadRadius: 0.5,
                  )
                ]),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: height,
                  width: width! / 2,
                  child: Padding(
                    padding: EdgeInsets.all(1),
                    child: Column(
                      children: const [
                        Text(
                          'كورونا والعالم',
                          style: TextStyle(
                              fontFamily: FontConst.fontFamily,
                              fontWeight: FontWeightManager.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'فيروسات كورونا هي عائلة من الفيروسات التي يمكنها أن تسبب أمراضًا مثل الزكام والالتهاب التنفُّسي الحاد الوخيم (السارس) ومتلازمة الشرق الأوسط التنفُّسية (ميرس). في عام 2019، اُكتشِف نوع جديد من فيروسات كورونا تسبب في تفشي مرض كان منشأه في الصين.',
                          style: TextStyle(
                              fontFamily: FontConst.fontFamily,
                              fontWeight: FontWeightManager.regular),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 7,
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: height,
                  width: width / 2,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(profileImageUri),
                      fit: BoxFit.cover,
                    ),
                    color: ColorManager.myBlue,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );

////
///messageitem
//////
///
/// Todo this component Not Used
Widget messageItem({double? width, double? height}) => Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 5,
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        height: height! * 0.14,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.black,
              radius: 40,
              backgroundImage: NetworkImage(
                profileImageUri,
              ),
            ),
            SizedBox(width: width! * 0.03),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.03,
                ),
                Text(
                  'علي محمد علي',
                  style: TextStyle(
                      color: HexColor('#929BB0'),
                      fontFamily: FontConst.fontFamily,
                      fontWeight: FontWeightManager.bold),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  'دكتور أسنان',
                  style: TextStyle(
                      color: HexColor('#929BB0'),
                      fontFamily: FontConst.fontFamily,
                      fontWeight: FontWeightManager.light),
                )
              ],
            )
          ],
        ),
      ),
    );

////
void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) => false,
    );

// Toast in all app
void showToast({
  required String message,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 14.0,
    );

// enum
enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}

Widget buildDialog({
  required context,
  required String title,
  required Widget child,
}) =>
    AlertDialog(
      backgroundColor:
          ThemeCubit.get(context).darkTheme ? backGroundDark : Colors.white,
      title: Text(
        title,
        textDirection: TextDirection.rtl,
        style: Theme.of(context).textTheme.subtitle1,
      ),
      contentPadding: EdgeInsets.zero,
      content: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
              color: ThemeCubit.get(context).darkTheme
                  ? backGroundDark
                  : Colors.white,
              child: child),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'الغاء',
            textDirection: TextDirection.rtl,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ],
    );

AppBar dashAppBar({
  required String title,
  required context,
  Widget? action,
  bool? pop = true,
}) =>
    AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
      actions: [
        if (action != null) action,
        Container(
          margin: const EdgeInsets.all(10.0),
          width: 30.0,
          child: IconButton(
            icon: Icon(
              Icons.brightness_4,
              color: ThemeCubit.get(context).darkTheme
                  ? mainTextColor
                  : mainColors,
            ),
            onPressed: () {
              ThemeCubit.get(context).changeTheme();
            },
          ),
        ),
        if (pop == true)
          Container(
            padding: const EdgeInsets.all(0.0),
            width: 30.0,
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(
                IconBroken.Arrow___Left_2,
                color: ThemeCubit.get(context).darkTheme
                    ? mainTextColor
                    : mainColors,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
      ],
    );

Widget defaultDashBoardTitleBox({
  String? img,
  required String title,
  bool? svg = false,
  String? svgImage,
}) =>
    Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: mainColors,
        borderRadius: BorderRadius.circular(8.0),
      ),
      height: 88.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            width: 20,
          ),
          Align(
            alignment: AlignmentDirectional.center,
            child: svg == false
                ? Image.asset(
                    img!,
                    width: 50.0,
                    height: 50.0,
                  )
                : SvgPicture.asset(
                    svgImage!,
                    width: 50.0,
                    height: 50.0,
                  ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Text(title,
              style: TextStyle(
                color: finesColor,
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center),
        ],
      ),
    );

Widget defaultFormField(
        {required TextEditingController controller,
        required TextInputType type,
        Function? onSubmit,
        // Function? onChange,
        ValueChanged<String>? onChange,
        Function? onTap,
        bool isPassword = false,
        required Function validate,
        String? label,
        String? hint,
        required IconData prefix,
        IconData? suffixIcon,
        void Function()? onPressedsufix,
        bool isClickable = true,
        required context}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: (s) {
        onSubmit;
      },
      onChanged: onChange,
      //     (s) {
      //   onChange;
      // },
      onTap: () {
        onTap;
      },
      validator: (s) {
        validate;
      },
      cursorColor: mainColors,
      decoration: InputDecoration(
        hintText: hint,
        suffixIcon: IconButton(
          icon: Icon(suffixIcon),
          onPressed: onPressedsufix,
        ),
        hintStyle: Theme.of(context).textTheme.bodyText1,
        labelText: label,
        labelStyle:
            Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey),
        prefixIcon: Icon(
          prefix,
          color: Colors.grey,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        border: const OutlineInputBorder(),
      ),
    );

Widget defaultButton2({
  double? width,
  double? height,
  double? fontSize,
  EdgeInsets? marginSize,
  required VoidCallback function,
  required String text,
  required Color btnColor,
  required style,
}) =>
    Container(
      width: width,
      height: height,
      margin: marginSize,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text,
          style: style,
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(8.0),
          bottomRight: Radius.circular(8.0),
        ),
        color: btnColor,
      ),
    );

Widget defaultButton({
  double? width,
  double? height,
  double? radius = 8.0,
  double? fontSize,
  EdgeInsets? marginSize,
  required VoidCallback function,
  required String text,
  required Color btnColor,
}) =>
    Container(
      width: width,
      height: height,
      margin: marginSize,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius!,
        ),
        color: btnColor,
      ),
    );

Widget waitingDialog({required context}) => AlertDialog(
      backgroundColor:
          ThemeCubit.get(context).darkTheme ? mainColors : Colors.white,
      contentPadding: EdgeInsets.zero,
      content: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color:
                  ThemeCubit.get(context).darkTheme ? mainColors : Colors.white,
            ),
            height: 120.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(
                  height: 12.0,
                ),
                Text(
                  'برجاء الأنتظار ...',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ],
            )),
      ),
    );
Widget dashTextFormField({
  required TextEditingController controller,
  required TextInputType type,
  required String hint,
  required context,
}) =>
    Container(
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
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: Theme.of(context).textTheme.bodyText1,
          contentPadding: const EdgeInsetsDirectional.all(5.0),
        ),
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );

Widget whiteBoard(
  context, {
  double? height = 250.0,
  int? maxLine = 10,
  String? hint = '',
  TextEditingController? controller,
}) =>
    Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        color:
            ThemeCubit.get(context).darkTheme ? finesColorDark : Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey, width: 1),
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextFormField(
          controller: controller,
          scrollPhysics: const BouncingScrollPhysics(),
          cursorColor:
              ThemeCubit.get(context).darkTheme ? mainTextColor : mainColors,
          maxLines: maxLine,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            hintStyle: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ),
    );
Widget defaultTitleBox({
  required String img,
  required String title,
}) =>
    Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      height: 88.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            width: 20,
          ),
          Align(
            alignment: AlignmentDirectional.center,
            child: SvgPicture.asset(
              img,
              width: 68.0,
              height: 68.0,
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Text(
            title,
            style: TextStyle(
              color: finesColor,
              fontSize: 20.0,
            ),
          ),
        ],
      ),
    );
AppBar defaultAppBar({
  required BuildContext context,
  double? titleSpacing = 12.0,
  bool? showBus = false,
  bool? pop = true,
  bool? bookingDone = false,
  Widget? popToScreen,
  Object? state,
}) =>
    AppBar(
        titleSpacing: titleSpacing,
        automaticallyImplyLeading: false,
        actions: [
          if (showBus == true)
            Container(
              padding: const EdgeInsets.all(0.0),
              width: 30.0,
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: SvgPicture.asset(
                  'assets/icon/bus.svg',
                  width: 18.0,
                  height: 18.0,
                ),
                onPressed: () {
                  // navigateTo(context, const BusScreen());
                },
              ),
            ),
          Container(
            padding: const EdgeInsets.all(0.0),
            width: 30.0,
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(
                Icons.person_outline,
                color: ThemeCubit.get(context).darkTheme
                    ? mainTextColor
                    : mainColors,
              ),
              onPressed: () {
                //AppCubit.get(context).getReviews();
                // if(AppCubit.get(context).profileModel!.isresident){
                //  navigateTo(context, const ProfileScreen());
                //  }else{
                // navigateTo(context,  EditProfileScreen());
                //   }
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(0.0),
            width: 30.0,
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  Icon(
                    IconBroken.Notification,
                    color: ThemeCubit.get(context).darkTheme
                        ? mainTextColor
                        : mainColors,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0, left: 4.0),
                    child: SvgPicture.asset('assets/icon/dot.svg'),
                  ),
                ],
              ),
              onPressed: () {
                // navigateTo(context, const NotificationsScreen());
              },
            ),
          ),
          if (pop == true)
            Container(
              padding: const EdgeInsets.all(0.0),
              width: 30.0,
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(
                  IconBroken.Arrow___Left_2,
                  color: ThemeCubit.get(context).darkTheme
                      ? mainTextColor
                      : mainColors,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          if (bookingDone == true)
            InkWell(
              onTap: () {
                //navigateTo(context, HomeScreen());
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: SvgPicture.asset(
                  'assets/images/back_arrow.svg',
                  color: ThemeCubit.get(context).darkTheme
                      ? mainTextColor
                      : mainColors,
                ),
              ),
            ),
          const SizedBox(
            width: 6.0,
          ),
        ],
        title: Text(
          'أهلا , ${ConsultantCubit.get(context).consultantModel != null ? ConsultantCubit.get(context).consultantModel!.uid : 'xxxxxxxx'}',
          style: Theme.of(context).textTheme.headline6,
        ));

Widget switchedTextFormField({
  required context,
  required AdminCubit cubit,
  required controller,
  bool center = true,
  TextInputType type = TextInputType.text,
  int flex = 1,
}) =>
    Expanded(
      flex: flex,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          hintStyle: Theme.of(context).textTheme.bodyText1,
        ),
        readOnly: cubit.showEdit == true ||
                cubit.showStudentEdit == true ||
                cubit.showWaitingStudentEdit == true
            ? false
            : true,
        enableInteractiveSelection: cubit.showEdit == true ||
                cubit.showStudentEdit == true ||
                cubit.showWaitingStudentEdit == true
            ? true
            : false,
        style: Theme.of(context).textTheme.bodyText1,
        textAlign: center ? TextAlign.center : TextAlign.start,
        keyboardType: type,
      ),
    );

Widget smallDashBoardTitleBox({
  String? img,
  required String title,
  bool? svg = false,
  String? svgImage,
}) =>
    Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: mainColors,
        borderRadius: BorderRadius.circular(8.0),
      ),
      height: 50.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            width: 20,
          ),
          Align(
            alignment: AlignmentDirectional.center,
            child: svg == false
                ? Image.asset(
                    img!,
                    width: 30.0,
                    height: 30.0,
                  )
                : SvgPicture.asset(
                    svgImage!,
                    width: 30.0,
                    height: 30.0,
                  ),
          ),
          const SizedBox(
            width: 16.0,
          ),
          Text(title,
              style: TextStyle(
                color: finesColor,
                fontSize: 18.0,
              ),
              textAlign: TextAlign.center),
        ],
      ),
    );

Widget dashWhiteBoard(
  context, {
  double? height = 200.0,
  int? maxLine = 8,
  required String text,
}) =>
    Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        color:
            ThemeCubit.get(context).darkTheme ? finesColorDark : Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey, width: 1),
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
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Text(
            text,
            maxLines: maxLine,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ),
    );
