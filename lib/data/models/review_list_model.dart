import 'package:crafty_bay/data/models/review_model.dart';

class ReviewListModel {
  String? msg;
  List<ReviewModel>? reviewList;

  ReviewListModel({this.msg, this.reviewList});

  ReviewListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      reviewList = <ReviewModel>[];
      json['data'].forEach((v) {
        reviewList!.add(ReviewModel.fromJson(v));
      });
    }
  }
}



class Profile {
  int? id;
  String? cusName;

  Profile({this.id, this.cusName});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cusName = json['cus_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cus_name'] = cusName;
    return data;
  }
}
