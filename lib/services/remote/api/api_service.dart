import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:rxdart/rxdart.dart';

import '../../local/preferences/preferences.dart';
import 'endpoints.dart';
import 'service/models/service_data.dart';
import 'service/models/token_model.dart';

part 'service/handler.dart';

part 'service/methods.dart';

part 'service/constants.dart';

part 'service/models/request_model.dart';

part 'auth.dart';

class ApiService {
  late final ApiServiceData _apiData;
  final List<ApiHandler> _services = [];

  /// Показывает завершена ли инициализация сервиса, если объект завершен,
  /// то сервис готов к работе
  late Future initialized;

  /// Стрим, в который выкидываются ошибки от запросов. Нужен, например, для
  /// AppRepository чтобы отслеживать ошибки авторизации
  BehaviorSubject<Exception> apiExceptions = BehaviorSubject();

  ApiService({required PreferencesService preferencesService}) {
    initialized = _init(preferencesService);
  }

  /// Здесь прописывать геттеры для определенных классов
  /// Перед добавление нового сервиса его также необходимо добавить его в [_initialServices]
  Auth get auth => getService<Auth>();

  /// Позволяет получить подсервис типа [T]
  getService<T extends ApiHandler>() {
    return _services.firstWhere((element) => element is T);
  }

  /// Обновляет токен, используемый при запросах
  refreshToken(Token token) async {
    await _apiData.prefs.saveToken(token);
    _apiData.token.refresh(token.jwt);

    log("________________________");
    log('token refreshed on ${_apiData.token}');
    log("________________________");

    _apiData.dio.options.headers = _getHeadersWithCurrentToken();
    _apiData.prefs.getToken();
  }

  void logout() {
    _apiData.prefs.logout();
    _apiData.token.refresh('');
    _apiData.dio.options.headers = defaultHeaders;
  }

  Future _initialServices() async {
    _services.add(Auth(_apiData));
  }

  // -----------------------------------------------------

  Future _init(PreferencesService preferencesService) async {
    await _initializeServiceData(preferencesService);
    await _initialServices();

    refreshToken(_apiData.token);
  }

  Map<String, dynamic> _getHeadersWithCurrentToken() {
    final Map<String, dynamic> newHeaders = Map.from(defaultHeaders);
    newHeaders['Authorization'] = _apiData.token.bearer;
    return newHeaders;
  }

  /// Инициализирует классы, необходимые для работы по типу [Dio], [PreferencesService]
  Future _initializeServiceData(PreferencesService preferencesService) async {
    await preferencesService.initialized;
    final token = await preferencesService.getToken();
    final dio = Dio(defaultDioOptions)..interceptors.add(PrettyDioLogger());
    _apiData = ApiServiceData(
        token, dio, preferencesService, apiExceptions, refreshToken);
    _apiData.requiredFuture = initialized;
  }
}
