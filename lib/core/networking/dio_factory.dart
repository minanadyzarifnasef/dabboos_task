import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'api_constants.dart';
import '../helpers/app_utilities.dart';

class DioFactory {
  DioFactory._();

  static Dio? dio;

  static Future<Dio> getDio() async {
    Duration timeOut = const Duration(seconds: 30);
    if (dio == null) {
      dio = Dio(BaseOptions(
        baseUrl: ApiConstants.apiBaseUrl,
      ));
      dio!
        ..options.connectTimeout = timeOut
        ..options.receiveTimeout = timeOut
        ..options.headers = {
          "device-id": await AppUtilities().getUniqueDeviceId(),
        };

      addDioInterceptor();
      return dio!;
    } else {
      return dio!;
    }
  }

  static void addDioInterceptor() {
    dio?.interceptors.addAll([
      PrettyDioLogger(
        requestBody: true,
        requestHeader: false,
        responseHeader: false,
      ),
      // ErrorInterceptor(), // Commented out as providing code for this was not requested/provided
      InterceptorsWrapper(
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
          options.headers['Accept-Language'] = "EN";
          options.headers['Authorization'] = "token";
          return handler.next(options);
        },
        onError: (DioException err, ErrorInterceptorHandler handler) {
          handler.next(err);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          handler.next(response);
        },
      ),
    ]);
  }
}
