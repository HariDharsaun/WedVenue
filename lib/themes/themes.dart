import 'package:flutter/material.dart';

class Themes {
  static ThemeData dark_theme = ThemeData(
    colorScheme: ColorScheme.dark(
      primary: Color(0xFFfbf4fc),
      background: Colors.black54,
      secondary: Colors.grey,
    )
  );

  static ThemeData light_theme = ThemeData(
    colorScheme: ColorScheme.light(
      background: Color(0xFFfbf4fc),
      primary: Colors.grey.shade700,
      secondary: Colors.white
    )
  );
}