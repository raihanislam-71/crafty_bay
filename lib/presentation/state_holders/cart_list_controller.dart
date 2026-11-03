import 'package:crafty_bay/data/models/cart_item_model.dart';
import 'package:crafty_bay/data/models/cart_list_model.dart';
import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/services/cart_storage_service.dart';
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
      _cartList.fold<num>(0, (total, item) => total + (item.totalPrice));

  Future<bool> getCartList() async {
    bool isSuccess = false;
    _inProgress = true;
    _errorMessage = null;
    update();

    // Load saved quantities from local storage
    final Map<int, int> savedQuantities = await CartStorageService.loadQuantities();
    _localQuantities.addAll(savedQuantities);

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.cartList,
    );

    if (response.isSuccess && response.responseData['msg'] == 'success') {
      _cartList = CartListModel.fromJson(response.responseData).cartList ?? [];

      for (final CartItemModel item in _cartList) {
        final int? itemId = item.id;
        if (itemId == null) continue;
        item.quantity = _localQuantities[itemId] ?? item.quantity;
        _localQuantities.putIfAbsent(itemId, () => item.quantity);
      }

      isSuccess = true;
    } else {
      _errorMessage = response.errorMassage ?? 'Failed to load cart list';
    }

    _inProgress = false;
    update();
    return isSuccess;
  }

  void removeItem(int itemId) {
    _cartList.removeWhere((item) => item.id == itemId);
    _localQuantities.remove(itemId);
    CartStorageService.removeQuantity(itemId);
    update();
  }

  Future<void> updateQuantity(int itemId, int quantity) async {
    if (quantity < 1) return;
    final CartItemModel item =
        _cartList.firstWhere((element) => element.id == itemId);
    item.quantity = quantity;
    _localQuantities[itemId] = quantity;
    await CartStorageService.saveQuantity(itemId, quantity);
    update();
  }
}
