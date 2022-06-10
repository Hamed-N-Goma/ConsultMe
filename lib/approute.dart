import 'package:consultme/const.dart';
import 'package:consultme/moduls/login/login_screen.dart';
import 'package:consultme/presentation_layer/user/screens/chatDetailsScreen.dart';
import 'package:consultme/presentation_layer/user/screens/view_all_impo_artcle.dart';
import 'package:consultme/presentation_layer/user/user_layout/home_user_layout.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case userLayoutScreen:
        return MaterialPageRoute(
          builder: (_) => Directionality(
            textDirection: TextDirection.rtl,
            child: LoginScreen(),
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
            builder: (_) => Directionality(
                  textDirection: TextDirection.rtl,
                  child: ChatDetails(),
                ));
    }
  }
}
