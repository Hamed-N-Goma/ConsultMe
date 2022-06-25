import 'package:consultme/Bloc/adminBloc/cubit/admin_cubit.dart';
import 'package:consultme/Bloc/consultantBloc/cubit/consultant_cubit.dart';
import 'package:consultme/Bloc/userBloc/cubit/userlayoutcubit_cubit.dart';
import 'package:consultme/approute.dart';
import 'package:consultme/moduls/login/login_screen.dart';
import 'package:consultme/presentation_layer/admin/admin_home_screen.dart';
import 'package:consultme/presentation_layer/consultant/consultant_home_screen.dart';
import 'package:consultme/presentation_layer/user/user_layout/home_user_layout.dart';
import 'package:consultme/shard/network/local/cache_helper.dart';
import 'package:consultme/shard/network/remote/dio_helper.dart';
import 'package:consultme/shard/style/theme/cubit/cubit.dart';
import 'package:consultme/shard/style/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'shard/style/theme/cubit/states.dart';

Future BackgroundMessage(RemoteMessage message) async {
  print(
      "================================== Background Notafecation ================================");

  print("${message.notification!.body}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(BackgroundMessage);

  DioHelper.init();
  await CacheHelper.init();

  Widget? widget;
  bool? isDark = CacheHelper.getData(key: 'isDark');
  String? uId = CacheHelper.getData(key: 'uId');
  String? userType = CacheHelper.getData(key: 'type');

  if (uId != null) {
    if (userType == "user") {
      widget = UserLayout();
    } else if (userType == "Consultant") {
      widget = ConsultantHomeScreen();
    } else if (userType == "admin") {
      widget = AdminHomeScreen();
    }
  } else {
    widget = LoginScreen();
  }

  runApp(MyApp(widget: widget, isDark: isDark));
}

class MyApp extends StatelessWidget {
  final Widget? widget;
  final bool? isDark;
  MyApp({Key? key, required this.widget, this.isDark}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) =>
              ThemeCubit()..changeTheme(fromShared: isDark),
        ),
        BlocProvider(
            create: (BuildContext context) => ConsultantCubit()
              ..getConsultantData()
              ..getPosts()
              ..getAppoinments()
              ..getUsersChat()),
        BlocProvider(
            create: (BuildContext context) => AdminCubit()
              ..getAdminData()
              ..getUserInSecurity()
              ..getData()
              ..getUsers()
              ..getCategorys()),
        BlocProvider(
            create: (BuildContext context) => UserLayoutCubit()
              ..GetUserInfo()
              ..getCategory()
              ..getConsultants()
              ..getFavorite()
              ..getAllPosts()
              ..getConsultChat()
              ..getAppoinments()
              ..getConsultChat()),
      ],
      child: BlocConsumer<ThemeCubit, ThemeStates>(
          listener: (BuildContext context, state) {},
          builder: (BuildContext context, Object? state) {
            return MaterialApp(
              home: widget,
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: ThemeCubit.get(context).darkTheme
                  ? ThemeMode.dark
                  : ThemeMode.light,
            );
          }),
    );
  }
}
