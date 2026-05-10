// core/theme/theme_manager.dart

import 'package:flutter/material.dart';
import 'colors_manager.dart';

class ThemeManager {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: ColorsManager.background,
    primaryColor: ColorsManager.primary,
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorsManager.primary,
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: ColorsManager.background,
      foregroundColor: ColorsManager.textPrimary,
    ),
  );
}