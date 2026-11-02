import 'package:crafty_bay/data/models/cart_item_model.dart';
import 'package:crafty_bay/data/models/cart_list_model.dart';
import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utils/urls.dart';
import 'package:get/get.dart';

class CartListController extends GetxController {
  bool _inProgress = false;
  List<CartItemModel> _cartList = [];
  String? _errorMessage;
  final Map<int, int> _localQuantities = {};

  bool get inProgress => _inProgress;
  List<CartItemModel> get cartList => _cartList;
  String? get errorMessage => _errorMessage;

  num get totalPrice =>
      _cartList.fold<num>(0, (total, item) => total + item.totalPrice);

  Future<bool> getCartList() async {
    _inProgress = true;
    _errorMessage = null;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.cartList,
    );

    if (response.isSuccess &&
        response.responseData is Map<String, dynamic> &&
        response.responseData['msg'] == 'success') {
      final List<CartItemModel> receivedCartList = CartListModel.fromJson(
        response.responseData,
      ).cartList;
      _cartList = receivedCartList;
      for (final CartItemModel item in _cartList) {
        final int? itemId = item.id;
        if (itemId == null) continue;
        item.quantity = _localQuantities[itemId] ?? item.quantity;
        _localQuantities.putIfAbsent(itemId, () => item.quantity);
      }
      _errorMessage = null;
    } else {
      _errorMessage =
          response.errorMassage ??
          (response.responseData is Map<String, dynamic>
              ? response.responseData['msg']?.toString()
              : null) ??
          'Failed to load cart';
    }

    _inProgress = false;
    update();
    return _errorMessage == null;
  }

  void removeItem(int itemId) {
    _cartList.removeWhere((item) => item.id == itemId);
    _localQuantities.remove(itemId);
    update();
  }

  void updateQuantity(CartItemModel item, int quantity) {
    final int? itemId = item.id;
    if (itemId == null || quantity < 1) return;

    item.quantity = quantity;
    _localQuantities[itemId] = quantity;
    update();
  }
}
