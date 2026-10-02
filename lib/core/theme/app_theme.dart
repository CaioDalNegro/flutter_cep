import 'package:flutter/material.dart';

class AppTheme {
  static const primaryColor = Color(0xff6366f1);
  static const secondaryColor = Color(0xff8B5CF6);
  static const accentColor = Color(0xff06B6D4);
  static const surfaceColor = Color(0xFFF8FAFC);
  static const backgroundColor = Color(0xFFFFFBFF);
  static const errorColor = Color(0xFFEF4444);
  static const successColor = Color(0xFF10B981);
  static const warningColor = Color(0xFFF59E0B);

  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.light,
        primary: primaryColor,
        secondary: secondaryColor,
        tertiary: accentColor,
        surface: surfaceColor,
        error: errorColor,
      ),
      scaffoldBackgroundColor: backgroundColor,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.dark,
        primary: primaryColor,
        secondary: secondaryColor,
        tertiary: accentColor,
        surface: const Color(0xff1E293B),
        error: errorColor,
      ),
      scaffoldBackgroundColor: const Color(0xff0F172A),
    );
  }
}
