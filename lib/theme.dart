import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class AppColors {
  static const Color backgroundStart = Color(0xFF0F0A2A);
  static const Color backgroundEnd = Color(0xFF0A0A1A);
  static const Color primary = Color(0xFF6C5CE7);
  static const Color primaryLight = Color(0xFFA29BFE);
  static const Color gold = Color(0xFFFFD700);
  static const Color goldBg = Color(0x15FFD700);
  static const Color goldBorder = Color(0x60FFD700);
  static const Color mint = Color(0xFF55EFC4);
  static const Color amber = Color(0xFFF9A826);
  static const Color danger = Color(0xFFFF6B6B);
  static const Color chakra = Color(0xFFDDA0DD);
  static const Color lunar = Color(0xFFC0C0FF);
  static const Color tealStart = Color(0xFF008180);
  static const Color tealMid = Color(0xFF00B1A6);
  static const Color tealEnd = Color(0xFFE5F3EE);
  static const Color surface = Color(0x10FFFFFF);
  static const Color surfaceBorder = Color(0x15FFFFFF);
  static const Color surfaceLight = Color(0x0AFFFFFF);
  static const Color surfaceBorderLight = Color(0x20FFFFFF);
  static const Color textSecondary = Color(0x60FFFFFF);
  static const Color textTertiary = Color(0x80FFFFFF);
  static const Color textMuted = Color(0x40FFFFFF);
  static const Color textSubtle = Color(0x35FFFFFF);
  static const Color white = Color(0xFFFFFFFF);
}

abstract final class AppGradients {
  static const LinearGradient background = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [AppColors.backgroundStart, AppColors.backgroundEnd],
  );

  static const LinearGradient primaryButton = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [AppColors.primary, AppColors.primaryLight],
  );

  static const LinearGradient goldButton = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [AppColors.gold, AppColors.amber],
  );

  static const LinearGradient greenButton = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [AppColors.mint, Color(0xFF2ED8A3)],
  );

  static const LinearGradient tealLogo = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.tealStart, AppColors.tealMid, AppColors.tealEnd],
  );

  static const LinearGradient darkOverlay = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.transparent, AppColors.backgroundEnd],
  );

  static const LinearGradient heroOverlay = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.0, 0.85],
    colors: [Color(0x000F0A2A), Color(0xFF0F0A2A)],
  );
}

abstract final class AppTheme {
  static ThemeData get dark {
    final base = ThemeData.dark(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: AppColors.backgroundEnd,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.primaryLight,
        surface: AppColors.backgroundEnd,
      ),
      textTheme: GoogleFonts.urbanistTextTheme(base.textTheme).apply(
        bodyColor: AppColors.white,
        displayColor: AppColors.white,
      ),
    );
  }
}
