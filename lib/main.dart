import 'package:consultme/Bloc/login/states.dart';
import 'package:consultme/approute.dart';
import 'package:consultme/presentation_layer/login/login_screen.dart';
import 'package:consultme/shard/network/local/cache_helper.dart';
import 'package:consultme/shard/style/theme/cubit/cubit.dart';
import 'package:consultme/shard/style/theme/cubit/states.dart';
import 'package:consultme/shard/style/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Bloc/adminBloc/cubit/admin_cubit.dart';
import 'Bloc/consultantBloc/cubit/consultant_cubit.dart';
import 'Bloc/login/cubit.dart';
import 'Bloc/user/cubit/userlayoutcubit_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool? isDark = true;
  await Firebase.initializeApp();

  await CacheHelper.init();
  runApp(MyApp(
    appRouter: AppRouter(),
    isDark: isDark,
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  final bool? isDark;

  const MyApp({Key? key, required this.appRouter, this.isDark})
      : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) =>
                ThemeCubit()..changeTheme(fromShared: isDark),
          ),
          BlocProvider(create: (BuildContext context) => LoginCubit()),
          BlocProvider(
              create: (BuildContext context) =>
                  UserLayoutCubit()..GetUserInfo()),
          BlocProvider(
              create: (BuildContext context) => ConsultantCubit()
                ..getConsultantData()
                ..getPosts()),
          BlocProvider(
              create: (BuildContext context) => AdminCubit()
                ..getAdminData()
                ..getUserInSecurity()
                ..getData()),
        ],
        child: BlocListener<LoginCubit, LoginStates>(
          listener: (context, state) {},
          child: BlocBuilder<ThemeCubit, ThemeStates>(
            builder: (context, state) {
              return MaterialApp(
                home: LoginScreen(),
                debugShowCheckedModeBanner: false,
                theme: lightTheme,
                darkTheme: darkTheme,
                themeMode: ThemeCubit.get(context).darkTheme
                    ? ThemeMode.dark
                    : ThemeMode.light,
              );
            },
          ),
        ));
  }
}
