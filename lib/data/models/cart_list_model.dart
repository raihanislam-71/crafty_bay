import 'package:crafty_bay/data/models/cart_item_model.dart';

class CartListModel {
  String? msg;
  List<CartItemModel> cartList = [];

  CartListModel({this.msg, this.cartList = const []});

  CartListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    final dynamic data = json['data'];
    if (data is List) {
      cartList = data
          .whereType<Map<String, dynamic>>()
          .map(CartItemModel.fromJson)
          .toList();
    }
  }
}
