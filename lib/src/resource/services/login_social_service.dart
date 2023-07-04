// import 'dart:convert';
// import 'dart:developer';
// import 'dart:math' as Math;
//
// import 'package:crypto/crypto.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';
//
// enum SocialType { facebook, google, twitter, apple }
//
// class LoginSocialResult {
//   bool success;
//   dynamic id;
//   String? code;
//   String? accessToken;
//   String? secretToken;
//   SocialType type;
//   String? fullName;
//   String? email;
//   String? avatar;
//
//   bool get isSuccess => success;
//
//   LoginSocialResult(
//       {this.accessToken,
//         this.code,
//         this.secretToken,
//         this.success = false,
//         this.email,
//         required this.type,
//         this.id,
//         this.avatar,
//         this.fullName});
// }
//
// class LoginSocialFirebaseResult {
//   bool success;
//   User? user;
//   String? idToken;
//   String? msg;
//
//   bool get isSuccess => success;
//
//   LoginSocialFirebaseResult({this.success = false, this.msg, this.idToken, this.user});
// }
//
// class SocialService {
//   SocialService._();
//
//   static SocialService? _instance;
//
//   factory SocialService() {
//     if (_instance == null) _instance = SocialService._();
//     return _instance!;
//   }
//
//   // Username: test_jbijwbw_user@tfbnw.net
//   // pass: Werewolf@
//   Future<LoginSocialResult> signInFacebook() async {
//     LoginSocialResult socialResult = LoginSocialResult(type: SocialType.facebook);
//     try {
//       await FacebookAuth.instance.logOut();
//       final LoginResult result = await FacebookAuth.instance.login(
//         permissions: [
//           'email',
//           'public_profile',
//           'user_birthday',
//           'user_friends',
//           'user_gender',
//           'user_link'
//         ],
//       );
//       if (result.status != LoginStatus.success) return socialResult;
//       final AccessToken? accessToken = result.accessToken;
//       if (accessToken == null) throw Exception('AccessToken from facebook null!');
//       final Map<String, dynamic> user = await FacebookAuth.instance
//           .getUserData(fields: "name,email,picture.width(200),birthday,friends,gender,link");
//       log("User: $user");
//       socialResult.id = accessToken.userId;
//       socialResult.accessToken = accessToken.token;
//       socialResult.fullName = user['name'];
//       socialResult.email = user['email'];
//       socialResult.avatar = user['picture']['data']['url'];
//       socialResult.success = true;
//     } catch (error) {
//       log('signInFacebook: $error');
//     }
//     return socialResult;
//   }
//
//   Future<LoginSocialResult> signInGoogle() async {
//     LoginSocialResult result = LoginSocialResult(type: SocialType.google);
//     try {
//       if (await GoogleSignIn().isSignedIn()) await GoogleSignIn().signOut();
//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//       if (googleUser == null) throw Exception('GoogleSignInAccount from google null!');
//       if (await GoogleSignIn().isSignedIn()) {
//         final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//         result.id = googleUser.id;
//         result.fullName = googleUser.displayName;
//         result.email = googleUser.email;
//         result.avatar = googleUser.photoUrl;
//         result.accessToken = googleAuth.accessToken;
//         result.success = true;
//       }
//     } catch (error) {
//       log('signInGoogle: $error');
//     }
//     return result;
//   }
//
//   // Future<LoginSocialResult> signInTwitter() async {
//   //   LoginSocialResult result = LoginSocialResult(type: SocialType.twitter);
//   //   try {
//   //     final twitterLogin = TwitterLogin(
//   //       // Consumer API keys
//   //       apiKey: 'xxxx',
//   //       // Consumer API Secret keys
//   //       apiSecretKey: 'xxxx',
//   //       // Registered Callback URLs in TwitterApp
//   //       // Android is a deeplink
//   //       // iOS is a URLScheme
//   //       redirectURI: 'example://',
//   //     );
//   //     final authResult = await twitterLogin.login();
//   //     if (authResult.status == null) throw Exception('TwitterLogin status null!');
//   //     switch (authResult.status!) {
//   //       case TwitterLoginStatus.loggedIn:
//   //         result.accessToken = authResult.authToken;
//   //         result.secretToken = authResult.authTokenSecret;
//   //         result.success = true;
//   //         break;
//   //       case TwitterLoginStatus.cancelledByUser:
//   //         break;
//   //       case TwitterLoginStatus.error:
//   //         print("SignIn Twitter Error: ${authResult.errorMessage}");
//   //         break;
//   //     }
//   //   } catch (error) {
//   //     log("SignIn Twitter Error: $error");
//   //   }
//   //   return result;
//   // }
//
//   static Future<LoginSocialResult> signInWithApple() async {
//     LoginSocialResult result = LoginSocialResult(type: SocialType.apple);
//     final credential = await SignInWithApple.getAppleIDCredential(scopes: [
//       AppleIDAuthorizationScopes.email,
//       AppleIDAuthorizationScopes.fullName,
//     ]);
//     result.code = credential.authorizationCode;
//     if (credential.identityToken != null) {
//       result.accessToken = credential.identityToken;
//       result.fullName = (credential.givenName ?? '') + (credential.familyName ?? '');
//     }
//     print(credential);
//
//     // This is the endpoint that will convert an authorization code obtained
//     // via Sign in with Apple into a session in your system
//     // final signInWithAppleEndpoint = Uri(
//     //   scheme: 'https',
//     //   host: 'flutter-sign-in-with-apple-example.glitch.me',
//     //   path: '/sign_in_with_apple',
//     //   queryParameters: <String, String>{
//     //     'code': credential.authorizationCode,
//     //     if (credential.givenName != null) 'firstName': credential.givenName!,
//     //     if (credential.familyName != null) 'lastName': credential.familyName!,
//     //     'useBundleId': Platform.isIOS || Platform.isMacOS ? 'true' : 'false',
//     //     if (credential.state != null) 'state': credential.state!,
//     //   },
//     // );
//
//     // final session = await http.Client().post(
//     //   signInWithAppleEndpoint,
//     // );
//
//     // If we got this far, a session based on the Apple ID credential has been created in your system,
//     // and you can now set this as the app's session
//     // print(session);
//     return result;
//   }
// }
//
// class SocialServiceFirebase {
//   SocialServiceFirebase._();
//
//   static SocialServiceFirebase? _instance;
//
//   factory SocialServiceFirebase() {
//     if (_instance == null) _instance = SocialServiceFirebase._();
//     return _instance!;
//   }
//
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   Future<LoginSocialFirebaseResult> signIn(SocialType type) async {
//     LoginSocialFirebaseResult result = LoginSocialFirebaseResult();
//     UserCredential? userCredential;
//     AuthCredential? authCredential;
//     switch (type) {
//       case SocialType.google:
//         authCredential = await _loginGoogle();
//         break;
//       case SocialType.facebook:
//         authCredential = await _loginFacebook();
//         break;
//       case SocialType.apple:
//         authCredential = await _loginApple();
//         break;
//       default:
//         break;
//     }
//
//     if (authCredential != null) {
//       try {
//         userCredential = await _auth.signInWithCredential(authCredential);
//         result.idToken = (await userCredential.user!.getIdToken());
//         result.user = userCredential.user;
//         result.success = true;
//       } catch (e) {
//         print('loginSocial failure: error $e');
//       }
//     } else
//       print('loginSocial failure: authCredential == null');
//     return result;
//   }
//
//   Future<AuthCredential?> _loginGoogle() async {
//     final googleLogin = GoogleSignIn(scopes: ["email"]);
//
//     if (await googleLogin.isSignedIn()) await googleLogin.signOut();
//
//     GoogleSignInAccount? result = await googleLogin.signIn();
//     final auth = await result?.authentication;
//     if (auth != null) {
//       print("${auth.accessToken}");
//       return GoogleAuthProvider.credential(idToken: auth.idToken, accessToken: auth.accessToken);
//     }
//
//     return null;
//   }
//
//   Future<AuthCredential?> _loginFacebook() async {
//     await FacebookAuth.instance.logOut();
//     final LoginResult result = await FacebookAuth.instance.login();
//     switch (result.status) {
//       case LoginStatus.success:
//         print("_loginFacebook ok");
//         print("${result.accessToken!.token}");
//         return FacebookAuthProvider.credential(result.accessToken!.token);
//       case LoginStatus.cancelled:
//         print("_loginFacebook cancel");
//         return null;
//       case LoginStatus.failed:
//         print("_loginFacebook failed: ${result.message}");
//         return null;
//       default:
//         break;
//     }
//   }
//
//   Future<AuthCredential?> _loginApple() async {
//     AuthCredential? authCredential;
//
//     final rawNonce = generateNonce();
//     final nonce = sha256ofString(rawNonce);
//
//     final credential = await SignInWithApple.getAppleIDCredential(scopes: [
//       AppleIDAuthorizationScopes.email,
//       AppleIDAuthorizationScopes.fullName,
//     ], nonce: nonce);
//
//     if (credential.identityToken == null) return authCredential;
//     authCredential = OAuthProvider("apple.com").credential(
//       idToken: credential.identityToken,
//       rawNonce: rawNonce,
//     );
//   }
//
//   /// Generates a cryptographically secure random nonce, to be included in a
//   /// credential request.
//   String generateNonce([int length = 32]) {
//     final charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
//     final random = Math.Random.secure();
//     return List.generate(length, (_) => charset[random.nextInt(charset.length)]).join();
//   }
//
//   /// Returns the sha256 hash of [input] in hex notation.
//   String sha256ofString(String input) {
//     final bytes = utf8.encode(input);
//     final digest = sha256.convert(bytes);
//     return digest.toString();
//   }
// }