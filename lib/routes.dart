import 'package:flutter/material.dart';

import 'detail.dart';
import 'git.dart';
import 'main.dart';

class Routes {
  //Route name constants
  static const String Root = '/';
  static const String CardDetail_ = 'detail';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    // print(settings);
    Map args = new Map();
    if (settings.arguments != null) {
      args = settings.arguments as Map<dynamic, dynamic>;
    }

    switch (settings.name) {
      case Root:
        return MaterialPageRoute(builder: (context) => Dashboard());
      case CardDetail_:
        return SlideTopRoute(page: CardDetail());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) {
      return const Scaffold(
        body: Center(
          child: Text("Error Route"),
        ),
      );
    });
  }
}
