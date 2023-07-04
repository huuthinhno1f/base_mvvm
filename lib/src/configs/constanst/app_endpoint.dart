class AppEndpoint {
  AppEndpoint._();

  static const String BASE_URL = "http://thietkeapp.asia/api/v1";
  static const String BASE_IMAGE_URL = "http://thietkeapp.asia/";

  static const int connectionTimeout = 15000;
  static const int receiveTimeout = 15000;
  static const String keyAuthorization = "Authorization";

  static const int SUCCESS = 200;
  static const int ERROR_TOKEN = 401;
  static const int ERROR_VALIDATE = 422;
  static const int ERROR_SERVER = 500;
  static const int ERROR_DISCONNECT = -1;

  static const String DEFAULT = '/default';
}
