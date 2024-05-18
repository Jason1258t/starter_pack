import 'package:flutter/material.dart';

import 'page_routes/no_animation.dart';
import 'page_routes/animation.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case AppRouteNames.root:
      //   return NoAnimationMaterialPageRoute(
      //       builder: (ctx) => const AppStateWidget());
      // // return NoAnimationMaterialPageRoute(builder: (ctx) => const AppStateWidget());
      default:
        return NoAnimationMaterialPageRoute(
            builder: (ctx) => Container(
                  color: Colors.red,
                ));
    }
  }
}
