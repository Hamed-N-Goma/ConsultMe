import 'package:consultme/Bloc/login/states.dart';
import 'package:consultme/approute.dart';
import 'package:consultme/presentation_layer/login/login_screen.dart';
import 'package:consultme/shard/style/theme/cubit/cubit.dart';
import 'package:consultme/shard/style/theme/cubit/states.dart';
import 'package:consultme/shard/style/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Bloc/login/cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool? isDark = true;
  await Firebase.initializeApp();
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
