import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:consultme/Bloc/CallBloc/call_cubit.dart';
import 'package:consultme/Bloc/userBloc/cubit/userlayoutcubit_cubit.dart';
import 'package:consultme/components/components.dart';
import 'package:consultme/const.dart';
import 'package:consultme/models/consultantmodel.dart';
import 'package:consultme/presentation_layer/user/screens/Call.dart';
import 'package:consultme/presentation_layer/user/screens/chat.dart';
import 'package:consultme/presentation_layer/user/screens/chatDetailsScreen.dart';
import 'package:consultme/presentation_layer/user/screens/edit_profile.dart';
import 'package:consultme/presentation_layer/user/screens/follow_request_screen.dart';
import 'package:consultme/presentation_layer/user/screens/home.dart';
import 'package:consultme/presentation_layer/user/screens/more.dart';
import 'package:consultme/presentation_layer/user/screens/search.dart';
import 'package:consultme/shard/style/iconly_broken.dart';
import 'package:consultme/shard/style/theme/cubit/cubit.dart';
import 'package:fancy_snackbar/fancy_snackbar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../../presentation_layer_manager/color_manager/color_manager.dart';

class UserLayout extends StatefulWidget {
  const UserLayout({Key? key}) : super(key: key);

  @override
  State<UserLayout> createState() => _UserLayoutState();
}

class _UserLayoutState extends State<UserLayout> {
  List<Widget> screens = [Home(), Search(), UserChat(), More()];
  int _selectedIndex = 0;
  late ConsultantModel consult;
  late String RTCtoken;


  initalMessage() async {
    var message = await FirebaseMessaging.instance.getInitialMessage();

    if (message != null) {

      if(message.data['type'] == 1 ){
        BlocProvider.of<UserLayoutCubit>(context).getConsultChat();
        navigateTo(context, UserChat());
      }
      else if(message.data['type'] == 2 ){
        BlocProvider.of<UserLayoutCubit>(context).getAppoinments();
        navigateTo(context, FollowRequestsScreen());
      }

    }
  }

  getMessage(){
    FirebaseMessaging.onMessage.listen((event) async {

      if(event.data['type'] == "call" ){
        BlocProvider.of<CallCubit>(context).getCallDetails(
            callerid: event.data['consultId'],
            receiverID: UserLayoutCubit.get(context).userModel!.uid);
        await BlocProvider.of<UserLayoutCubit>(context).getConsultById(event.data['consultId']);
        consult = BlocProvider.of<UserLayoutCubit>(context).consult!;
        RTCtoken = event.data['RTCtoken'];
        navigateTo(context, Call(consultant: consult, calltype:BlocProvider.of<CallCubit>(context).callType, RTCtoken: RTCtoken,));

      }
      else if(event.data['type'] == "appointment" ){
        await BlocProvider.of<UserLayoutCubit>(context).getConsultById(event.data['consultId']);
        consult = BlocProvider.of<UserLayoutCubit>(context).consult!;

        AnimatedSnackBar.rectangle(
          "${consult.name}",
          "لقد تم قبول طلبك , يمكنك بدأ المحادثة .. ",
          type: AnimatedSnackBarType.success,
          brightness: Brightness.dark,
        ).show(
          context,
        );

        FancySnackbar.showSnackbar(
          context,
          snackBarType: FancySnackBarType.success,
          title: "${consult.name}",
          message: "لقد تم قبول طلبك , يمكنك بدأ المحادثة .. ",
          duration: 4,
          onCloseEvent: () {},
        );
      }
      else if(event.data['type'] == "message" ){
       await  BlocProvider.of<UserLayoutCubit>(context).getConsultById(event.data['consultId']);
        consult = BlocProvider.of<UserLayoutCubit>(context).consult!;

        AnimatedSnackBar.rectangle(
          "${consult.name}",
          "لقد تلقيت رسالة جديدة ",
          type: AnimatedSnackBarType.success,
          brightness: Brightness.dark,
        ).show(
          context,
        );

        FancySnackbar.showSnackbar(
          context,
          snackBarType: FancySnackBarType.waiting,
          title: "${consult.name}",
          message: "لقد تلقيت رسالة جديدة ",
          duration: 4,
          onCloseEvent: () {},
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) async {
      if(event.data['type'] == "call" ){
        BlocProvider.of<CallCubit>(context).getCallDetails(
            callerid: event.data['consultId'],
            receiverID: UserLayoutCubit.get(context).userModel!.uid);
        await BlocProvider.of<UserLayoutCubit>(context).getConsultById(event.data['consultId']);
        consult = BlocProvider.of<UserLayoutCubit>(context).consult!;
        RTCtoken = event.data['RTCtoken'];
        navigateTo(context, Call(consultant: consult, calltype:BlocProvider.of<CallCubit>(context).callType, RTCtoken: RTCtoken,));
      }
      else if(event.data['type'] == "appointment" ){
        BlocProvider.of<UserLayoutCubit>(context).getAppoinments();
        navigateTo(context, FollowRequestsScreen());
      }
      else if(event.data['type'] == "message" ){
      await  BlocProvider.of<UserLayoutCubit>(context).getConsultById(event.data['consultId']);
        consult = BlocProvider.of<UserLayoutCubit>(context).consult!;
        navigateTo(context, UserChatDetails(consultant: consult,));
      }

      });
  }


  @override
  void initState() {

    initalMessage();

    getMessage();

  super.initState();
}

  @override
  Widget build(BuildContext context) {
    return BlocListener<CallCubit, CallState>(
        listener: (context, state) async {
      if (state is EndCall) {
        showRating(state.consultId);
      }
    },
    child: BlocBuilder<UserLayoutCubit, UserLayoutState>(
      builder: (context, state) {
        var model = UserLayoutCubit.get(context).userModel;

        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar:
            dashAppBar(
              title: 'إستشرني',
              context: context,
              pop: false,
              action: InkWell(
                onTap: () {
                  navigateTo(context, EditProfile());
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 5 , left: 20),
                  child: CircleAvatar(
                    backgroundImage: model?.image == null
                        ? const AssetImage(
                      "assets/images/user.png",
                    ) as ImageProvider
                        : NetworkImage("${model?.image}"),
                    radius: 15,
                  ),
                ),
              ),
            ),
            //bottom navebar controller
            body: screens[_selectedIndex],


            bottomNavigationBar: Container(
              height: 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.5),
                      offset: Offset(3, 2),
                      blurRadius: 4,
                      spreadRadius: 0.5,
                    )
                  ]),
              child: FlashyTabBar(
                iconSize : 30.0,
                backgroundColor: ThemeCubit.get(context).darkTheme
                    ? mainColors
                    : Theme.of(context).scaffoldBackgroundColor,
                selectedIndex: _selectedIndex,
                showElevation: true,
                onItemSelected: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                items: [
                  FlashyTabBarItem(
                    icon: Icon(Icons.home),
                    title: Text('الرئيسية'),
                  ),
                  FlashyTabBarItem(
                    icon: Icon(Icons.search),
                    title: Text('بحث'),
                  ),
                  FlashyTabBarItem(
                    icon: Icon(Icons.chat),
                    title: Text('الرسائل'),
                  ),
                  FlashyTabBarItem(
                    icon: Icon(Icons.more_horiz),
                    title: Text('أخري'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
    );
  }
  double rating = 0;
  Widget buildRating() {
    return RatingBar.builder(
        itemSize: 40,
        itemBuilder: (context, _) => Icon(IconBroken.Star, color: Colors.amber),
        onRatingUpdate: (rating) {
          setState(() {
            this.rating = rating;
          });
        },
        minRating: 1,
        maxRating: 5);
  }

  void showRating(consultId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Center(
          child: Text(
            "قيم المستشار",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              BlocProvider.of<UserLayoutCubit>(context).sendRating(
                rating: rating,
                sender:
                BlocProvider.of<UserLayoutCubit>(context).userModel!.uid,
                recever: consultId,
              );
              Navigator.pop(context);
            },
            child:  Text(
              "تأكيد",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ],
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildRating(),
          ],
        ),
      ),
    );
  }
}
