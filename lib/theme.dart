import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class AppColors {
  static const Color backgroundStart = Color(0xFF060608);
  static const Color backgroundMid = Color(0xFF0C0D17);
  static const Color backgroundEnd = Color(0xFF060608);
  static const Color primary = Color(0xFF8D8FF8);
  static const Color primaryLight = Color(0xFFC9CAFF);
  static const Color gold = Color(0xFFFFC96B);
  static const Color goldBg = Color(0x1AFFC96B);
  static const Color goldBorder = Color(0x33FFC96B);
  static const Color mint = Color(0xFF61E8C8);
  static const Color amber = Color(0xFFFFA93E);
  static const Color danger = Color(0xFFFF6B6B);
  static const Color chakra = Color(0xFFDAA2F9);
  static const Color lunar = Color(0xFF9DABFF);
  static const Color tealStart = Color(0xFF1B7C72);
  static const Color tealMid = Color(0xFF35B9A7);
  static const Color tealEnd = Color(0xFFE7F7F4);
  static const Color surface = Color(0x0AFFFFFF);
  static const Color surfaceBorder = Color(0x12FFFFFF);
  static const Color surfaceLight = Color(0x0AFFFFFF);
  static const Color surfaceBorderLight = Color(0x18FFFFFF);
  static const Color textSecondary = Color(0xFFB3B1BA);
  static const Color textTertiary = Color(0xFFD6D3DD);
  static const Color textMuted = Color(0xFF6E6D7C);
  static const Color textSubtle = Color(0xFF4C4B58);
  static const Color white = Color(0xFFF4F1EC);
}

abstract final class AppGradients {
  static const LinearGradient background = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.backgroundStart,
      AppColors.backgroundMid,
      AppColors.backgroundEnd,
    ],
  );

  static const LinearGradient primaryButton = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFFCFB3FF), Color(0xFFFFE9B3)],
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
    final bodyTextTheme = GoogleFonts.manropeTextTheme(base.textTheme);
    final displayTextTheme = GoogleFonts.bricolageGrotesqueTextTheme(
      base.textTheme,
    );
    return base.copyWith(
      scaffoldBackgroundColor: AppColors.backgroundEnd,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.primaryLight,
        surface: AppColors.backgroundEnd,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
      ),
      dividerColor: AppColors.surfaceBorder,
      iconTheme: const IconThemeData(color: AppColors.textSecondary),
      textTheme: bodyTextTheme
          .copyWith(
            displayLarge: displayTextTheme.displayLarge,
            displayMedium: displayTextTheme.displayMedium,
            displaySmall: displayTextTheme.displaySmall,
            headlineLarge: displayTextTheme.headlineLarge,
            headlineMedium: displayTextTheme.headlineMedium,
            headlineSmall: displayTextTheme.headlineSmall,
            titleLarge: displayTextTheme.titleLarge,
          )
          .apply(bodyColor: AppColors.white, displayColor: AppColors.white),
    );
  }
}
