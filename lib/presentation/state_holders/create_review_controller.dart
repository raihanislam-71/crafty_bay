import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utils/urls.dart';
import 'package:get/get.dart';

class CreateReviewController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  String? get errorMessage => _errorMessage;

  Future<bool> createReview({
    required int productId,
    required String description,
    required String rating,
  }) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().postRequest(
      url: Urls.createProductReview,
      body: {
        "description": description,
        "product_id": productId,
        "rating": rating,
      },
    );

    if (response.isSuccess && response.responseData['msg'] == 'success') {
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMassage ??
          (response.responseData is Map<String, dynamic>
              ? response.responseData['msg']?.toString()
              : null) ??
          'Failed to create review';
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
