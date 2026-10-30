import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/models/slider_list_model.dart';
import 'package:crafty_bay/data/models/slider_model.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utils/urls.dart';
import 'package:get/get.dart';

class SliderListController extends GetxController {
  bool _inProgress = false;
  List<SliderModel> _sliderList = [];
  String? _errorMessage;

  bool get inProgress => _inProgress;
  List<SliderModel> get sliderList => _sliderList;
  String? get errorMessage => _errorMessage;

  Future<bool> getSliderList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.sliderListUrl,
    );

    if (response.isSuccess) {
      _sliderList =
          SliderListModel.fromJson(response.responseData).sliderList ?? [];
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
