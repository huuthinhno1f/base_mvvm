import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:logger/logger.dart';
import '../configs/configs.dart';
import 'app_prefs.dart';

class AppClients extends DioForNative {
  static const String GET = "GET";
  static const String POST = "POST";
  static const String PUT = "PUT";
  static const String DELETE = "DELETE";

  static AppClients? _instance;
  static Logger logger = Logger();

  factory AppClients({String baseUrl = AppEndpoint.BASE_URL, BaseOptions? options}) {
    _instance ??= AppClients._(baseUrl: baseUrl);
    if (options != null) _instance!.options = options;
    _instance!.options.baseUrl = baseUrl;
    return _instance!;
  }

  AppClients._({String baseUrl = AppEndpoint.BASE_URL, BaseOptions? options}) : super(options) {
    interceptors.add(InterceptorsWrapper(
          onRequest: _requestInterceptor,
          onResponse: _responseInterceptor,
          onError: _errorInterceptor,
        ));
    this.options.baseUrl = baseUrl;
  }

  _requestInterceptor(RequestOptions options, RequestInterceptorHandler handler) async {
    String? accessToken = AppPrefs.accessToken;
    options.headers = {'Authorization': 'Bearer $accessToken'};
    logger.d("${options.method}: ${options.uri}\nHeaders: ${options.headers}");

    switch (options.method) {
      case AppClients.GET:
        logger.d("Params: ${options.queryParameters}");
        break;
      default:
        if (options.data is Map) {
          logger.d("Params: ${options.data}");
          options.data = FormData.fromMap(options.data);
        } else if (options.data is FormData) {
          logger.d("Params: ${options.data.fields}");
          logger.d("Files: ${(options.data as FormData).files}");
        }
        break;
    }
    options.connectTimeout = AppEndpoint.connectionTimeout;
    options.receiveTimeout = AppEndpoint.receiveTimeout;
    handler.next(options);
  }

  _responseInterceptor(Response response, ResponseInterceptorHandler handler) {
    logger.i(
        "Response ${response.requestOptions.uri}: ${response.statusCode}\nData: ${response.data}");
    handler.next(response);
  }

  _errorInterceptor(DioError dioError, ErrorInterceptorHandler handler) {
    logger
        .e("${dioError.type} - Error ${dioError.message}\nData: ${dioError.response?.data ?? ''}");
    handler.next(dioError);
  }
}
