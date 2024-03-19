import 'package:flutter/cupertino.dart';

import '../../utils/animations.dart';
import '../../widgets/scaffold.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 16,
            ),
            AppAnimations.circleIndicator
          ],
        ),
      ),
      canPop: false,
    );
  }
}
