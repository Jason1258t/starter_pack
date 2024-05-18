import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../local/preferences/preferences.dart';
import 'token_model.dart';

class ApiServiceData {
  final Token token;
  final Dio dio;
  final PreferencesService prefs;
  final BehaviorSubject exceptionsStream;
  Future? requiredFuture;
  final Function(Token) refreshToken;

  ApiServiceData(this.token, this.dio, this.prefs, this.exceptionsStream,
      this.refreshToken);
}
