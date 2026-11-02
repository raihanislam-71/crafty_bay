import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utils/urls.dart';
import 'package:crafty_bay/presentation/state_holders/cart_list_controller.dart';
import 'package:get/get.dart';

class AddToCartController extends GetxController {
  bool _inProgress = false;

  String? _errorMassage;

  bool get inProgress => _inProgress;

  String? get errorMassage => _errorMassage;

  Future<bool> addToCart(
    int productId,
    String color,
    String size,
    int quantity,
  ) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(
          url: Urls.addToCart,
          body: {
            "product_id": productId,
            "color": color,
            "size": size,
            "qty": quantity,
          },
        );

    if (response.isSuccess && response.responseData['msg'] == 'success') {
      _errorMassage = null;
      isSuccess = true;
      if (Get.isRegistered<CartListController>()) {
        await Get.find<CartListController>().getCartList();
      }
    } else {
      _errorMassage = response.errorMassage ??
          (response.responseData is Map<String, dynamic>
              ? response.responseData['msg']?.toString()
              : null) ??
          'Failed to add to cart';
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
