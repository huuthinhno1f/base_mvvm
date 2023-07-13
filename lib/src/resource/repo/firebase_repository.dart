import 'package:base_mvvm/src/configs/configs.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../utils/utils.dart';
import '../resource.dart';

class FirebaseRepository {
  FirebaseRepository._();

  static FirebaseRepository? _instance;

  factory FirebaseRepository() {
    _instance ??= FirebaseRepository._();
    return _instance!;
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future verifyPhoneNumber(
      String phoneNumber,
      PhoneVerificationCompleted verificationCompleted,
      PhoneVerificationFailed verificationFailed,
      PhoneCodeSent codeSent,
      PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout) async {
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 120),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  Future<UserCredential> signInWithCredential(AuthCredential authCredential) =>
      _auth.signInWithCredential(authCredential);

  Future<User?> getUser(UserCredential authResult) async {
    final User? user = authResult.user;
    final User? currentUser = _auth.currentUser;
    if (user != null && currentUser != null && user.uid == currentUser.uid) {
      return user;
    }
    return null;
  }

  Future<void> signOut() => _auth.signOut();

  Future<NetworkState> updateFirebaseToken() async {
    bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) return NetworkState.withDisconnect();
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      Response response = await AppClients().post("URL", data: {"fcm_device_token": token});
      return NetworkState(
        status: response.statusCode ?? AppEndpoint.success,
        data: response.data,
      );
    } on DioError catch (e) {
      return NetworkState.withError(e);
    }
  }
}
