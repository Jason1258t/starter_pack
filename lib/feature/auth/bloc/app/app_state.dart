part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}

class AppAuthState extends AppState {}

class AppUnAuthState extends AppState {}

class NoInternetState extends AppState {}
