class AuthRepository {
  AuthRepository._();

  static AuthRepository? _instance;

  factory AuthRepository() {
    _instance ??= AuthRepository._();
    return _instance!;
  }
}
