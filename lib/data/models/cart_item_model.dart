import 'package:crafty_bay/data/models/cart_product_model.dart';

class CartItemModel {
  int? id;
  int? productId;
  String? color;
  String? size;
  int quantity = 1;
  num? price;
  CartProductModel? product;

  CartItemModel({
    this.id,
    this.productId,
    this.color,
    this.size,
    this.quantity = 1,
    this.price,
    this.product,
  });

  CartItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    color = json['color'];
    size = json['size'];
    quantity = int.tryParse(json['qty']?.toString() ?? '1') ?? 1;
    price = num.tryParse(json['price']?.toString() ?? '0');
    product = json['product'] != null
        ? CartProductModel.fromJson(json['product'])
        : null;
  }

  num get unitPrice => product?.price ?? price ?? 0;

  num get totalPrice => unitPrice * quantity;
}
