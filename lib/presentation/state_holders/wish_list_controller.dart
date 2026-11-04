import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/models/wish_list_model.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utils/urls.dart';
import 'package:get/get.dart';

class WishListController extends GetxController {
  bool _inProgress = false;
  WishListModel _wishListModel = WishListModel();
  String? _errorMessage;

  bool get inProgress => _inProgress;
  WishListModel get wishListModel => _wishListModel;
  String? get errorMessage => _errorMessage;

  Future<bool> getWishList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.wishList,
    );

    if (response.isSuccess) {
      _wishListModel = WishListModel.fromJson(response.responseData);
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMassage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
