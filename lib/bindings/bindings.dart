import 'package:get/get.dart';
import 'package:hall_booking_app/get%20controllers/auth.dart';

class AppBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(AuthController(),permanent: true);
  }
}