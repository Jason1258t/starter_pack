part of '../api_service.dart';

mixin class ApiHandler {
  late final ApiServiceData serviceData;

  Future get(String url,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? data,
      Function(DioException)? handler}) {
    final requestData = RequestData(url,
        data: data,
        queryParams: queryParameters,
        customExceptionHandler: handler);

    return _request(
      requestData: requestData,
      method: MethodsEnum.get,
    );
  }

  Future post(String url,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? data,
      Function(DioException)? handler}) {
    final requestData = RequestData(url,
        data: data,
        queryParams: queryParameters,
        customExceptionHandler: handler);

    return _request(
      requestData: requestData,
      method: MethodsEnum.post,
    );
  }

  Future delete(String url,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? data,
      Function(DioException)? handler}) async {
    final requestData = RequestData(url,
        data: data,
        queryParams: queryParameters,
        customExceptionHandler: handler);

    return _request(
      requestData: requestData,
      method: MethodsEnum.delete,
    );
  }

  // -----------------------------------------------------------------

  Future _request(
      {required MethodsEnum method, required RequestData requestData}) async {
    try {
      Response res;
      res = await _executeMethod(method, requestData);

      return res.data;
    } on DioException catch (e) {
      if (requestData.customExceptionHandler != null) {
        requestData.customExceptionHandler!(e);
      }
      _handleAuthorizationErrors(e, requestData.url);
      _logException(e, requestData);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response<dynamic>> _executeMethod(
      MethodsEnum method, RequestData requestData) async {
    await serviceData.requiredFuture;
    return serviceData.dio.request(requestData.url,
        options: Options(method: methods[method]!),
        queryParameters: requestData.queryParams,
        data: requestData.data);
  }

  /// Нужен чтобы обрабатывать ошибки, связанные с авторизацией. Нужен имеено
  /// здесь чтобы при необходимсоти обновлять токен
  void _handleAuthorizationErrors(DioException e, String url) {}

  /// Логает ошибки
  void _logException(DioException e, RequestData requestData) {
    log('headers: ${serviceData.dio.options.headers}');
    log('error by calling ${requestData.url}');
    log(requestData.toString());
    throw e;
  }
}
