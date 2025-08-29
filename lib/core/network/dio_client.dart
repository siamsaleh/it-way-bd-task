import 'package:dio/dio.dart';
import '../../constants/app_constants.dart';
import '../../utils/AppLogger.dart';

class DioClient {
  static Dio create() {
    final dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 15),
        headers: {"Content-Type": "application/json"},
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          AppLogger.logger.i(
            "${AppConstants.logTag} [${options.method}] ${options.uri}",
          );
          return handler.next(options);
        },
        onResponse: (response, handler) {
          AppLogger.logger.i(
            "${AppConstants.logTag} [${response.statusCode}] ${response.data}",
          );
          return handler.next(response);
        },
        onError: (e, handler) {
          AppLogger.logger.e(
            "${AppConstants.logTag} Error [${e.response?.statusCode}] ${e.message}",
          );
          return handler.next(e);
        },
      ),
    );

    return dio;
  }
}