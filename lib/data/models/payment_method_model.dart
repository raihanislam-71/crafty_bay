import 'package:crafty_bay/data/models/payment_method_response_data.dart';

class PaymentMeyhodModel {
  String? msg;
  List<PaymentMethodResponseData>? data;

  PaymentMeyhodModel({this.msg, this.data});

  PaymentMeyhodModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      data = <PaymentMethodResponseData>[];
      json['data'].forEach((v) {
        data!.add(PaymentMethodResponseData.fromJson(v));
      });
    }
  }
}


