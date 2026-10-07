
import 'dart:async';
import 'package:get/get.dart';

class OtpTimeController extends GetxController{
  int remainingTime = 120;
  bool canResend = false;
  Timer? _timer;

  @override
  void onInit(){
    super.onInit();
    startTimer();
  }

  void startTimer(){
    remainingTime = 120;
    canResend = false;

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer){
      if (isClosed) {
        timer.cancel();
        return;
      }
      if(remainingTime > 0){
        remainingTime--;
        update();
      }else{
        canResend = true;
        _timer?.cancel();
        update();
      }
    });
  }

  void resendCode() {
    if (canResend) {
      startTimer();
      // এখানে API কল করুন
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}