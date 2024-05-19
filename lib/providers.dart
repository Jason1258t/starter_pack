import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'feature/auth/bloc/app/app_cubit.dart';
import 'feature/auth/bloc/auth/auth_cubit.dart';
import 'feature/auth/data/auth_repository.dart';
import 'services/local/preferences/preferences.dart';
import 'services/remote/api/api_service.dart';

final preferencesService = PreferencesService();
final apiService = ApiService(preferencesService: preferencesService);

class MyRepositoryProviders extends StatelessWidget {
  const MyRepositoryProviders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(preferencesService, apiService),
          lazy: false,
        )
      ],
      child: const MyBlocProviders(),
    );
  }
}

class MyBlocProviders extends StatelessWidget {
  const MyBlocProviders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authRepository = RepositoryProvider.of<AuthRepository>(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(authRepository),
          lazy: false,
        ),
        BlocProvider(
            create: (context) => AppCubit(authRepository), lazy: false),
      ],
      child: const MyApp(),
    );
  }
}
