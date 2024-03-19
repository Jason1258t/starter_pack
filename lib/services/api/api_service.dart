import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:rxdart/rxdart.dart';

import '../../utils/utils.dart';
import '../preferences.dart';
import 'endpoints.dart';
import 'service/models/service_data.dart';
import 'service/models/token_model.dart';

part 'service/handler.dart';

part 'service/methods.dart';

part 'service/constants.dart';

part 'service/models/request_model.dart';

part 'auth.dart';

class ApiService {
  late final ServiceData _apiData;

  late Future initialized;
  BehaviorSubject<Exception> apiExceptions = BehaviorSubject();

  /// При добавлении новых сервисов необходимо инциализировать их в [_initialServices]
  late final Auth auth;

  ApiService({required PreferencesService preferencesService}) {
    initialized = _init(preferencesService);
  }

  void logout() {
    _apiData.prefs.logout();
    _apiData.token.setJwt('');
    _apiData.dio.options.headers = defaultHeaders;
  }

  Future _initialServices() async {
    auth = Auth(_apiData);
  }

  // -----------------------------------------------------

  Future _init(PreferencesService preferencesService) async {
    await _initializeServiceData(preferencesService);
    await _initialServices();
    await auth.refreshToken(_apiData.token);
  }

  /// Инициализирует классы, необходимые для работы по типу [Dio], [PreferencesService]
  Future _initializeServiceData(PreferencesService preferencesService) async {
    final token = await preferencesService.getToken();
    final dio = Dio(defaultDioOptions)..interceptors.add(PrettyDioLogger());
    _apiData = ServiceData(token, dio, preferencesService, apiExceptions);
    _apiData.requiredFuture = initialized;

    log(token.toString());
  }
}
