import 'package:consultme/const.dart';
import 'package:consultme/presentation_layer/login/login_screen.dart';
import 'package:consultme/presentation_layer/user/screens/chatDetailsScreen.dart';
import 'package:consultme/presentation_layer/user/screens/view_all_impo_artcle.dart';
import 'package:consultme/presentation_layer/user/user_layout/home_user_layout.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginscreen:
        return MaterialPageRoute(
          builder: (_) => Directionality(
            textDirection: TextDirection.rtl,
            child: LoginScreen(),
          ),
        );

      case userLayout:
        return MaterialPageRoute(
          builder: (_) => const Directionality(
            textDirection: TextDirection.rtl,
            child: UserLayout(),
          ),
        );

      case viewAllImportantArtcle:
        return MaterialPageRoute(
          builder: (_) => Directionality(
            textDirection: TextDirection.rtl,
            child: ViewAll(),
          ),
        );

      case chatDetails:
        return MaterialPageRoute(
            builder: (_) => const Directionality(
                  textDirection: TextDirection.rtl,
                  child: ChatDetails(),
                ));
    }
  }
}
