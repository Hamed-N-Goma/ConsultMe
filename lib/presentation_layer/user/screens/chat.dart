import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:consultme/Bloc/userBloc/cubit/userlayoutcubit_cubit.dart';
import 'package:consultme/components/components.dart';
import 'package:consultme/presentation_layer/user/screens/follow_request_screen.dart';
import 'package:consultme/presentation_layer/user/widget/messenger_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserChat extends StatelessWidget {
  UserChat({Key? key}) : super(key: key);
  var size, width, height;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserLayoutCubit, UserLayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        size = MediaQuery.of(context).size;
        height = size.height;
        width = size.width;
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Builder(
            builder: (context) {
          if (validation(context)) {
            return SingleChildScrollView(
              child: Center(
                  child: buildChatfallback(context)
              ),
            );
          }
          else {
            return
              ConditionalBuilder(
            condition: UserLayoutCubit.get(context).consultantInChat.length >= 0,
            builder: (context) => ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => ChatitemConsult(
                    UserLayoutCubit.get(context).consultantInChat[index], context),
                separatorBuilder: (context, index) => myDivider(),
                itemCount: UserLayoutCubit.get(context).consultantInChat.length),
            fallback: (context) =>   Center(child: buildChatfallback(context)),
          );
        }})
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
      ),
    );

Widget buildChatfallback(context) {
  return SizedBox(
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 100.0,
          ),
          SizedBox(
            width: double.infinity,
            child: SvgPicture.asset(
              'assets/images/chat.svg',
              height: 200.0,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            '" لا توجد دردشات حاليا "',
            style: Theme
                .of(context)
                .textTheme
                .bodyText1,
          ),
          const SizedBox(
            height: 5.0,
          ),
          Container(
            alignment: Alignment.center,
            child: InkWell(
              child: Text(
                'تفقد طلباتك ',
                style:
                Theme.of(context).textTheme.bodyText2!.copyWith(
                  decoration: TextDecoration.underline,
                ),
              ),
              onTap: () {
                navigateTo(
                    context,
                    FollowRequestsScreen());
              },
            ),
          ),
        ],
      ),
    ),
  );
}

validation(context) {
  if (UserLayoutCubit.get(context).consultantInChat.isEmpty) {
    return true;
  }
  return false;
}