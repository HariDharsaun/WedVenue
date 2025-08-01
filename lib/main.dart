import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hall_booking_app/bindings/bindings.dart';
import 'package:hall_booking_app/firebase_options.dart';
import 'package:hall_booking_app/get%20controllers/auth.dart';
import 'package:hall_booking_app/routes/app_pages.dart';
import 'package:hall_booking_app/themes/themes.dart';
import 'package:hall_booking_app/views/auth/login.dart';
import 'package:hall_booking_app/views/home/home.dart';
import 'package:hall_booking_app/views/pagestack/pagestack.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(AuthController(),permanent: true);
  runApp(const MainApp());
}


class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: AppBindings(),
      home: Obx(()
      {
        if(authController.isLoggedIn)
        {
          return Pagestack();
        }
        else{
          return LoginPage();
        }
      }
      ),
      getPages: AppPages.pages,
      theme: Themes.light_theme,
      darkTheme: Themes.dark_theme,
      themeMode: ThemeMode.system,
    );
  }
}
