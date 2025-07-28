import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hall_booking_app/firebase_options.dart';
import 'package:hall_booking_app/routes/app_pages.dart';
import 'package:hall_booking_app/routes/app_routes.dart';
import 'package:hall_booking_app/themes/themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // if using flutterfire CLI
  );
  runApp(const MainApp());
}


class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
      theme: Themes.light_theme,
      darkTheme: Themes.dark_theme,
      themeMode: ThemeMode.system,
    );
  }
}
