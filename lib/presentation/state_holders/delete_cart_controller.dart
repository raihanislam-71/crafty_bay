import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utils/urls.dart';
import 'package:get/get.dart';

class DeleteCartController extends GetxController {
  final Set<int> _deletingItemIds = {};
  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  bool isDeleting(int? itemId) =>
      itemId != null && _deletingItemIds.contains(itemId);

  Future<bool> deleteCartItem(int cartItemId, {int? productId}) async {
    if (_deletingItemIds.contains(cartItemId)) return false;

    _deletingItemIds.add(cartItemId);
    _errorMessage = null;
    update();

    final NetworkCaller networkCaller = Get.find<NetworkCaller>();

    // 1. Backend route in Laravel is Route::get('/DeleteCartList/{id}')
    NetworkResponse response = await networkCaller.getRequest(
      url: Urls.deleteCartItem(cartItemId),
    );

    // 2. If status is 405 (Method Not Allowed), fallback to DELETE request
    if (response.statusCode == 405) {
      response = await networkCaller.deleteRequest(
        url: Urls.deleteCartItem(cartItemId),
      );
    }

    bool isSuccess = response.isSuccess &&
        response.responseData is Map<String, dynamic> &&
        response.responseData['msg'] == 'success';

    // 3. If 0 rows were affected and productId is different, try with productId
    final dynamic data = response.responseData is Map<String, dynamic>
        ? response.responseData['data']
        : null;
    final bool zeroAffected = data == 0 || data == false;

    if ((!isSuccess || zeroAffected) &&
        productId != null &&
        productId != cartItemId) {
      NetworkResponse altResponse = await networkCaller.getRequest(
        url: Urls.deleteCartItem(productId),
      );

      if (altResponse.statusCode == 405) {
        altResponse = await networkCaller.deleteRequest(
          url: Urls.deleteCartItem(productId),
        );
      }

      if (altResponse.isSuccess &&
          altResponse.responseData is Map<String, dynamic> &&
          altResponse.responseData['msg'] == 'success' &&
          altResponse.responseData['data'] != 0) {
        response = altResponse;
        isSuccess = true;
      }
    }

    if (!isSuccess) {
      _errorMessage = response.responseData is Map<String, dynamic>
          ? response.responseData['msg']?.toString()
          : null;
      _errorMessage ??= response.errorMassage ?? 'Failed to delete item';
    }

    _deletingItemIds.remove(cartItemId);
    update();
    return isSuccess;
  }
}
