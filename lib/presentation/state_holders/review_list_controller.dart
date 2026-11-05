import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/models/review_list_model.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utils/urls.dart';
import 'package:get/get.dart';

class ReviewListController extends GetxController {
  bool _inProgress = false;
  ReviewListModel _reviewListModel = ReviewListModel();
  String? _errorMessage;

  bool get inProgress => _inProgress;
  ReviewListModel get reviewListModel => _reviewListModel;
  String? get errorMessage => _errorMessage;

  Future<bool> getReviewList(int productId) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.reviewList(productId),
    );

    if (response.isSuccess) {
      _reviewListModel = ReviewListModel.fromJson(response.responseData);
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
