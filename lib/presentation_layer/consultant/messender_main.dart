import 'package:consultme/Bloc/consultantBloc/cubit/consultant_cubit.dart';
import 'package:consultme/Bloc/consultantBloc/cubit/consultant_states.dart';
import 'package:consultme/components/components.dart';
import 'package:consultme/models/UserModel.dart';
import 'package:consultme/presentation_layer/consultant/chatDetailsScreen.dart';
import 'package:consultme/presentation_layer/presentation_layer_manager/color_manager/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import '../../../shard/style/theme/cubit/cubit.dart';

class ConsultChatitem extends StatelessWidget {
  ConsultChatitem(UserModel this.User, BuildContext context, {Key? key})
      : super(key: key);
  var size, width, height;

  UserModel User;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConsultantCubit, ConsultantStates>(
        listener: (context, state) {
          if (state is deleteMessagesLoadingStates){
            showDialog<void>(
                context: context,
                builder: (context)=> waitingDialog(context: context)
            );
          }
          else if(state is deleteMessagesSuccessStates ){
            showToast(message: 'تم حذف الرسائل بنجاح', state: ToastStates.SUCCESS);
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          size = MediaQuery.of(context).size;
          height = size.height;
          width = size.width;
          var cubit = ConsultantCubit.get(context);
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
                              'حذف جميع رسائل ${User.name}',
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
                          cubit.DeleteMessages(User);
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
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                color: mainColors,
                borderRadius: BorderRadiusDirectional.circular(8.0),
              ),
              padding: const EdgeInsets.all(5.0),
              alignment: AlignmentDirectional.centerStart,
              child: const Icon(
                Icons.delete_sweep,
                color: Colors.white,
              ),
            ),
          ),
          key: UniqueKey(),
          child: InkWell(
            onTap: () {
              navigateTo(
                  context,
                  ConsultChatDetails(
                    User: User,
                  ));
            },
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 5,
                bottom: 5,
              ),
              child: Container(
                padding: const EdgeInsets.all(16),
                height: 100,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UserImage(),
                    SizedBox(width: width * 0.03),
                    UserDetales(height, context),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
  ///////
  ///Widgets
  /////

  Widget UserImage() {
    return CircleAvatar(
      backgroundColor: Colors.black,
      radius: 40,
      backgroundImage: NetworkImage(
        '${User.image!}',
      ),
    );
  }

  Widget UserDetales(double height, context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${User.name}',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Text(
          '${User.email}',
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }
}
