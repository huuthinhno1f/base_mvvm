class AppEndpoint {
  AppEndpoint._();

  static const String baseUrl = "http://thietkeapp.asia/api/v1";
  static const String baseImageUrl = "http://thietkeapp.asia/";

  static const int connectionTimeout = 15000;
  static const int receiveTimeout = 15000;
  static const String keyAuthorization = "Authorization";

  static const int success = 200;
  static const int errorToken = 401;
  static const int errorValidate = 422;
  static const int errorSever = 500;
  static const int errorDisconnect = -1;

  static const String DEFAULT = '/default';
}
