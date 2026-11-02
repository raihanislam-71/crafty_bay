import 'package:crafty_bay/presentation/state_holders/cart_list_controller.dart';
import 'package:get/get.dart';

class BottomNavBarController extends GetxController {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void changeIndex(int index) {
    _selectedIndex = index;
    if (_selectedIndex == 2 && Get.isRegistered<CartListController>()) {
      Get.find<CartListController>().getCartList();
    }
    update();
  }

  void selectCategory() {
    changeIndex(1);
  }

  void selectCart() {
    changeIndex(2);
  }

  void backToHome() {
    changeIndex(0);
  }
}
