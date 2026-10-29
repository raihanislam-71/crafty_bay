import 'dart:async';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:get/get.dart';
import '../../data/models/network_response.dart';
import '../../data/utils/urls.dart';

class OtpTimeController extends GetxController{
  int _remainingTime = 120;
  bool _canResend = false;
  bool _inProgress = false;
  Timer? _timer;

  int get remainingTime => _remainingTime;
  bool get canResend => _canResend;
  bool get inProgress => _inProgress;

  @override
  void onInit(){
    super.onInit();
    startTimer();
  }

  void startTimer(){
    _timer?.cancel();
    _remainingTime = 120;
    _canResend = false;
    update();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer){
      if (isClosed) {
        timer.cancel();
        return;
      }
      if(remainingTime > 0){
        _remainingTime--;
        update();
      }else{
        _canResend = true;
        _timer?.cancel();
        update();
      }
    });
  }

 Future<bool> resendCode(String email) async{
    if(!canResend) return false;

    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(url: Urls.verifyEmail(email));

    _inProgress = false;
    if(response.isSuccess && response.responseData['msg'] == 'success'){
      startTimer();
      return true;
    }else{
      _canResend = true;
      update();
      return false;
    }

 }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}