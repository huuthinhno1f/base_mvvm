import 'package:get_storage/get_storage.dart';
import 'package:rxdart/rxdart.dart';

class AppPrefs {
  AppPrefs._();

  static final GetStorage _box = GetStorage('AppPref');
  static final BehaviorSubject _userBehavior = BehaviorSubject<dynamic>();
  static final BehaviorSubject<int> _numberNotification = BehaviorSubject<int>();

  static initListener() async {
    await GetStorage.init("AppPref");
    _box.listenKey('user', (user) {
      _userBehavior.add(user);
    });

    _box.listenKey('countNotification', (data) {
      _numberNotification.add(data);
    });
  }

  static set appMode(String? data) => _box.write('appMode', data);
  static String? get appMode => _box.read('appMode');

  static set accessToken(String? data) => _box.write('accessToken', data);
  static String? get accessToken => _box.read('accessToken');

  static set countNotification(int? data) => _box.write('countNotification', data);
  static int? get countNotification => _box.read('countNotification');

  static List<String> get historySearch {
    final _ = _box.read('history_search');
    if (_ == null) return [];
    return _ is List<String>
        ? _
        : List<String>.from(_box.read('history_search').map((x) => x.toString()));
  }

  // static set user(UserModel? data) => _box.write('user', data);
  //
  // static UserModel? get user {
  //   final _ = _box.read('user');
  //   if (_ == null) return UserModel();
  //   return _ is UserModel ? _ : UserModel.fromJson(_box.read('user'));
  // }
  //
  // static set version(VersionModel? data) => _box.write('version', data);
  //
  // static VersionModel? get version {
  //   final _ = _box.read('version');
  //   if (_ == null) return VersionModel();
  //   return _ is VersionModel ? _ : VersionModel.fromJson(_box.read('version'));
  // }

  static Stream get watchUser => _userBehavior.stream;
  static Stream<int> get watchNumberNotification => _numberNotification.stream;
}
