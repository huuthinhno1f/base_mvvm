import 'package:flutter/material.dart';

import 'navigation/navigation_screen.dart';

class Routers {
  static const String navigation = "/navigation";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    var arguments = settings.arguments;
    switch (settings.name) {
      case navigation:
        return animRoute(const NavigationScreen(), name: navigation);
        break;
      default:
        return animRoute(Container(
            child:
                Center(child: Text('No route defined for ${settings.name}'))
          ), name: "/error"
        );
    }
  }

  static Route animRoute(Widget page,
      {Offset? beginOffset, required String name, Object? arguments}) {
    return PageRouteBuilder(
      settings: RouteSettings(name: name, arguments: arguments),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = beginOffset ?? const Offset(0.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  static const Offset _center = Offset(0.0, 0.0);
  static const Offset _top = Offset(0.0, 1.0);
  static const Offset _bottom = Offset(0.0, -1.0);
  static const Offset _left = Offset(-1.0, 0.0);
  static const Offset _right = Offset(1.0, 0.0);
}
