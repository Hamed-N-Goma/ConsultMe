import 'package:consultme/Bloc/adminBloc/cubit/admin_cubit.dart';
import 'package:consultme/Bloc/consultantBloc/cubit/consultant_cubit.dart';
import 'package:consultme/Bloc/userBloc/cubit/user_cubit.dart';
import 'package:consultme/Bloc/userBloc/cubit/userlayoutcubit_cubit.dart';
import 'package:consultme/approute.dart';
import 'package:consultme/moduls/login/login_screen.dart';
import 'package:consultme/shard/network/local/cache_helper.dart';
import 'package:consultme/shard/network/remote/dio_helper.dart';
import 'package:consultme/shard/style/theme/cubit/cubit.dart';
import 'package:consultme/shard/style/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:consultme/shard/bloc_observer.dart';

import 'shard/style/theme/cubit/states.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool? isDark = false;
  await Firebase.initializeApp();

  DioHelper.init();
  await CacheHelper.init();

  runApp(MyApp(appRouter: AppRouter(), isDark: isDark));
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
        BlocProvider(
            create: (BuildContext context) => ConsultantCubit()
              ..getConsultantData()
              ..getPosts()
              ..getAppoinments()
              ..getUsersChat()),
        BlocProvider(
            create: (BuildContext context) => UserCubit()..getUserData()),
        BlocProvider(
            create: (BuildContext context) => AdminCubit()
              ..getAdminData()
              ..getUserInSecurity()
              ..getData()
              ..getUsers()),
        BlocProvider(
            create: (BuildContext context) => UserLayoutCubit()
              ..GetUserInfo()
              ..getCategory()
              ..getConsultants()
              ..getFavorite()),
      ],
      child: BlocConsumer<ThemeCubit, ThemeStates>(
          listener: (BuildContext context, state) {},
          builder: (BuildContext context, Object? state) {
            return MaterialApp(
              home: LoginScreen(),
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
