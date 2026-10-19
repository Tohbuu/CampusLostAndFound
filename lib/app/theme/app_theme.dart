import 'package:flutter/material.dart';

abstract final class AppColors {
  static const navy = Color(0xFF183A5A);
  static const navyDark = Color(0xFF102A43);
  static const mint = Color(0xFF72D6B1);
  static const sand = Color(0xFFF5EBDD);
  static const ink = Color(0xFF1C2935);
  static const muted = Color(0xFF617181);
  static const canvas = Color(0xFFF7F9FB);
  static const darkCanvas = Color(0xFF101923);
}

abstract final class AppTheme {
  static ThemeData get light {
    final scheme =
        ColorScheme.fromSeed(
          seedColor: AppColors.navy,
          brightness: Brightness.light,
        ).copyWith(
          primary: AppColors.navy,
          secondary: AppColors.mint,
          surface: Colors.white,
          onSurface: AppColors.ink,
        );

    return _buildTheme(
      scheme,
      scaffoldBackgroundColor: AppColors.canvas,
      isDark: false,
    );
  }

  static ThemeData get dark {
    final scheme =
        ColorScheme.fromSeed(
          seedColor: AppColors.navy,
          brightness: Brightness.dark,
        ).copyWith(
          primary: AppColors.mint,
          secondary: AppColors.mint,
          surface: const Color(0xFF192532),
          onSurface: const Color(0xFFE9F0F5),
        );

    return _buildTheme(
      scheme,
      scaffoldBackgroundColor: AppColors.darkCanvas,
      isDark: true,
    );
  }

  static ThemeData _buildTheme(
    ColorScheme scheme, {
    required Color scaffoldBackgroundColor,
    required bool isDark,
  }) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: scaffoldBackgroundColor,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: scheme.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: scheme.outlineVariant.withValues(alpha: 0.55),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: scheme.primary, width: 1.5),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(48, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(48, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: scheme.surface,
        indicatorColor: AppColors.mint.withValues(alpha: isDark ? 0.22 : 0.38),
        elevation: 0,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      ),
      dividerTheme: DividerThemeData(
        color: scheme.outlineVariant.withValues(alpha: 0.55),
        space: 1,
      ),
    );
  }
}
