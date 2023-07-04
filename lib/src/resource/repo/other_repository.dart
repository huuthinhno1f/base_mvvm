import 'package:base_mvvm/src/resource/model/verify_model.dart';
import 'package:dio/dio.dart';

import '../../configs/configs.dart';
import '../../utils/utils.dart';
import '../resource.dart';

class OtherRepository {
  OtherRepository._();

  static OtherRepository? _instance;

  factory OtherRepository() {
    _instance ??= OtherRepository._();
    return _instance!;
  }
  Future<NetworkState<VerifyModel>> getDefault() async {
    bool isDisconnect = await WifiService.isDisconnect();
    if (isDisconnect) return NetworkState.withDisconnect();

    try {
      Response response = await AppClients().get(AppEndpoint.DEFAULT);
      return NetworkState(
        status: AppEndpoint.SUCCESS,
        data: VerifyModel.fromJson(response.data),
      );
    } on DioError catch (e) {
      return NetworkState.withError(e);
    }
  }
}
