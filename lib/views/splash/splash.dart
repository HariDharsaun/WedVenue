import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:hall_booking_app/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    ColorScheme theme = Theme.of(context).colorScheme;
    double media_height = MediaQuery.of(context).size.height;
    double media_width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [logo(media_height, media_width)],
                ),
                SizedBox(height: 15),
                Text(
                  'WedVenue',
                  style: TextStyle(
                    color: Color(0xFFd053d4),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  "Find your perfect wedding venue",
                  style: TextStyle(color: theme.primary, fontSize: 15),
                ),
                SizedBox(height: 40),
                Column(
                  children: [
                    features("1000+ Premium Wedding Venues", Color(0xFFd053d4)),
                    SizedBox(height: 15),
                    features(
                      "Instant Booking & Confirmation",
                      Colors.blueGrey.shade300,
                    ),
                    SizedBox(height: 15),
                    features("Verified Venues & Reviews", Color(0xFFd053d4)),
                    SizedBox(height: 35),
                  ],
                ),
                getstartButton(
                  media_width,
                  Color(0xFFd053d4),
                  Colors.white,
                  "Get Started",
                  () {Get.offNamed(AppRoutes.signup);},
                ),
                SizedBox(height: 15),
                getstartButton(
                  media_width,
                  Color(0xFFfbf4fc),
                  Colors.purple,
                  "Already have an account?",
                  () {Get.offNamed(AppRoutes.login);},
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "Make your dream wedding come true",
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget logo(double height, double width) {
    return Container(
      alignment: Alignment.center,
      width: height * 0.2,
      height: width * 0.2,
      decoration: BoxDecoration(
        color: Color(0xFFd053d4),
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.favorite, color: Colors.white, size: height * 0.06),
    );
  }

  Widget features(String content, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        dot(color),
        SizedBox(width: 10),
        Text(
          content,
          style: TextStyle(color: Colors.grey.shade600),
        ),
      ],
    );
  }

  Widget dot(Color color) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }

  Widget getstartButton(
    double width,
    Color color,
    Color t_color,
    String content,
    Callback func,
  ) {
    return GestureDetector(
      onTap: func,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        width: width * 0.7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: BoxBorder.all(color: Colors.purple, width: 1),
          color: color,
        ),
        child: Text(content, style: TextStyle(color: t_color)),
      ),
    );
  }
}
