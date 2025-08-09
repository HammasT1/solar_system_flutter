import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }

  ThemeData get lightTheme => ThemeData(
    primaryColor: const Color(0xFF1E3A8A),
    scaffoldBackgroundColor: const Color(0xFFF5F7FA),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E3A8A),
      foregroundColor: Colors.white,
      elevation: 4,
      shadowColor: Color(0xFF7B61FF),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFF1A202C)),
      bodyMedium: TextStyle(color: Color(0xFF4A5568)),
      headlineSmall: TextStyle(
        color: Color(0xFF1A202C),
        fontWeight: FontWeight.bold,
      ),
    ),
    cardColor: const Color(0xFFE2E8F0),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF00B7D4),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF1E3A8A),
      secondary: Color(0xFF7B61FF),
      surface: Color(0xFFE2E8F0),
      background: Color(0xFFF5F7FA),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Color(0xFF1A202C),
      onBackground: Color(0xFF1A202C),
    ),
  );

  ThemeData get darkTheme => ThemeData(
    primaryColor: const Color(0xFF0F172A),
    scaffoldBackgroundColor: const Color(0xFF0A0E21),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1C2526),
      foregroundColor: Color(0xFFE2E8F0),
      elevation: 4,
      shadowColor: Color(0xFF7B61FF),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFFE2E8F0)),
      bodyMedium: TextStyle(color: Color(0xFFA0AEC0)),
      headlineSmall: TextStyle(
        color: Color(0xFFE2E8F0),
        fontWeight: FontWeight.bold,
      ),
    ),
    cardColor: const Color(0xFF2D3748),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF00B7D4),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF0F172A),
      secondary: Color(0xFF7B61FF),
      surface: Color(0xFF2D3748),
      background: Color(0xFF0A0E21),
      onPrimary: Color(0xFFE2E8F0),
      onSecondary: Color(0xFFE2E8F0),
      onSurface: Color(0xFFE2E8F0),
      onBackground: Color(0xFFE2E8F0),
    ),
  );
}