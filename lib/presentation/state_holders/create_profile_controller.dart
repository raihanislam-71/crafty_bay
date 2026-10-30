import 'package:crafty_bay/data/models/create_profile_model.dart';
import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utils/urls.dart';
import 'package:crafty_bay/presentation/state_holders/auth_controller.dart';
import 'package:crafty_bay/presentation/state_holders/otp_verification_controller.dart';
import 'package:get/get.dart';

class CreateProfileController extends GetxController {
  bool _inProgress = false;

  String? _errorMassage;

  bool get inProgress => _inProgress;

  String? get errorMassage => _errorMassage;

  Future<bool> createProfile(CreateProfileModel model, [String? token]) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final String? authToken =
        token ??
        AuthController.accessToken ??
        (Get.isRegistered<OtpVerificationController>()
            ? Get.find<OtpVerificationController>().accessToken
            : null);

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(
          url: Urls.createProfile,
          body: model.toJson(),
          token: authToken,
        );

    if (response.isSuccess && response.responseData['msg'] == 'success') {
      if (authToken != null && authToken.isNotEmpty) {
        await Get.find<AuthController>().saveAccessToken(authToken);
      }
      _errorMassage = null;
      isSuccess = true;
    } else {
      _errorMassage = response.errorMassage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
