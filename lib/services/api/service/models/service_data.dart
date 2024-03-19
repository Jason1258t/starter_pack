import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

import '../../../preferences.dart';
import 'token_model.dart';

class ServiceData {
  final Token token;
  final Dio dio;
  final PreferencesService prefs;
  final BehaviorSubject exceptionsStream;
  Future? requiredFuture;

  ServiceData(this.token, this.dio, this.prefs, this.exceptionsStream);
}
