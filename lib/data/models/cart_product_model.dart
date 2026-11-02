class CartProductModel {
  int? id;
  String? title;
  num? price;
  String? image;

  CartProductModel({this.id, this.title, this.price, this.image});

  CartProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = num.tryParse(json['price']?.toString() ?? '');
    image = json['image'];
  }
}
