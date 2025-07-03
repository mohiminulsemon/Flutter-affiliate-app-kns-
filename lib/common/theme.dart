import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.teal,
    scaffoldBackgroundColor: const Color(0xFF0f0f2d),
    cardColor: const Color(0xFF1c1c3c),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white10,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      labelStyle: const TextStyle(color: Colors.white70),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white24),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.teal, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      errorStyle: const TextStyle(color: Colors.redAccent),
    ),
  );
}
