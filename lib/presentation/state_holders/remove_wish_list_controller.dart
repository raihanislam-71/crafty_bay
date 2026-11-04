import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utils/urls.dart';
import 'package:get/get.dart';

class RemoveWishListController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  String? get errorMessage => _errorMessage;

  Future<bool> removeWishList(int productId) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkCaller networkCaller = Get.find<NetworkCaller>();


    final NetworkResponse response = await networkCaller.getRequest(
      url: Urls.removeWishList(productId),
    );

    if (response.isSuccess && response.responseData['msg'] == 'success') {
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.responseData is Map<String, dynamic>
          ? response.responseData['msg']?.toString()
          : response.errorMassage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
