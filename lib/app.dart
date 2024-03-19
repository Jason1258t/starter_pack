import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'feature/auth/bloc/app/app_cubit.dart';
import 'feature/auth/ui/login_screen.dart';
import 'feature/splash/splash_screen.dart';
import 'routes/routes.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      debugShowCheckedModeBanner: false,
      title: 'BCSports',
      onGenerateRoute: AppRoutes.generateRoute,
      builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(1.0)),
          child: child!),
    );
  }
}

class AppStateWidget extends StatelessWidget {
  const AppStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(builder: (context, state) {
      if (state is AppUnAuthState) return const LoginScreen();
      if (state is AppAuthState) return Container();
      if (state is AppInitial) return const SplashScreen();
      return Container();
    });
  }
}
