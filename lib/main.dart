import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hall_booking_app/routes/app_pages.dart';
import 'package:hall_booking_app/routes/app_routes.dart';
import 'package:hall_booking_app/themes/themes.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.signup,
      getPages: AppPages.pages,
      theme: Themes.light_theme,
      darkTheme: Themes.dark_theme,
      themeMode: ThemeMode.system,
    );
  }
}
