import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:hall_booking_app/models/venuemodel.dart';
import 'package:hall_booking_app/routes/app_routes.dart';
import 'package:hall_booking_app/views/auth/login.dart';
import 'package:hall_booking_app/views/auth/signup.dart';
import 'package:hall_booking_app/views/bookings/viewdetails.dart';
import 'package:hall_booking_app/views/home/home.dart';
import 'package:hall_booking_app/views/settings/settings.dart';
import 'package:hall_booking_app/views/splash/splash.dart';

class AppPages {
  static final List<GetPage>pages = [
    GetPage(name: AppRoutes.login, page: ()=>LoginPage()),
    GetPage(name: AppRoutes.splash, page: ()=>SplashScreen()),
    GetPage(name: AppRoutes.signup, page: ()=> SignUpPage()),
    GetPage(name: AppRoutes.home, page: ()=> VenueListPage()),
    GetPage(name: AppRoutes.viewDetails, page: ()=> VenueDetailsPage(venue: Get.arguments as VenueModel,)),
    GetPage(name: AppRoutes.settings, page: ()=> SettingsPage()),
  ];
}