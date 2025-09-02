import 'package:get/get.dart';
import 'package:hall_booking_app/get%20controllers/usercontroller.dart';
import 'package:hall_booking_app/views/bookings/history.dart';

class AppBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(Usercontroller());
    Get.lazyPut(()=>BookingHistoryPage());
  }
}