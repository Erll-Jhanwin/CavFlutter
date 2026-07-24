import 'package:flutter/material.dart';

import 'design_tokens.dart';

/// Builds the Material theme used by the CAV application.
class CavTheme {
  /// Prevents instantiation of this static theme factory.
  const CavTheme._();

  /// Returns the configured light theme and component styling.
  static ThemeData light() {
    const colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: CavColors.primary,
      onPrimary: CavColors.ink,
      primaryContainer: CavColors.primarySoft,
      onPrimaryContainer: CavColors.secondary,
      secondary: CavColors.secondary,
      onSecondary: Colors.white,
      secondaryContainer: CavColors.secondarySoft,
      onSecondaryContainer: CavColors.secondary,
      tertiary: CavColors.accent,
      onTertiary: CavColors.ink,
      tertiaryContainer: CavColors.accentSoft,
      onTertiaryContainer: CavColors.secondary,
      error: Color(0xFFBA1A1A),
      onError: Colors.white,
      errorContainer: Color(0xFFFFDAD6),
      onErrorContainer: Color(0xFF410002),
      surface: CavColors.surface,
      onSurface: CavColors.ink,
      surfaceContainerLowest: Colors.white,
      surfaceContainerLow: CavColors.background,
      surfaceContainer: CavColors.surfaceWarm,
      surfaceContainerHigh: CavColors.primarySoft,
      surfaceContainerHighest: CavColors.secondarySoft,
      onSurfaceVariant: CavColors.muted,
      outline: CavColors.line,
      outlineVariant: CavColors.line,
      shadow: CavColors.secondary,
      scrim: Colors.black,
      inverseSurface: CavColors.ink,
      onInverseSurface: Colors.white,
      inversePrimary: CavColors.accent,
    );

    final base = ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      fontFamily: 'Poppins',
    );

    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      colorScheme: colorScheme,
      scaffoldBackgroundColor: CavColors.background,
      visualDensity: VisualDensity.standard,
      textTheme: base.textTheme.apply(
        bodyColor: CavColors.ink,
        displayColor: CavColors.ink,
        fontFamily: 'Poppins',
      ).copyWith(
        displaySmall: base.textTheme.displaySmall?.copyWith(
          fontWeight: FontWeight.w800,
          letterSpacing: 0,
          height: 1.05,
        ),
        headlineMedium: base.textTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.w800,
          letterSpacing: 0,
          height: 1.08,
        ),
        headlineSmall: base.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.w800,
          letterSpacing: 0,
          height: 1.12,
        ),
        titleLarge: base.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w800,
          letterSpacing: 0,
          height: 1.12,
        ),
        titleMedium: base.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w700,
          letterSpacing: 0,
          height: 1.16,
        ),
        bodyLarge: base.textTheme.bodyLarge?.copyWith(height: 1.42),
        bodyMedium: base.textTheme.bodyMedium?.copyWith(height: 1.42),
        labelLarge: base.textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w700,
          letterSpacing: 0,
        ),
      ),
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: CavColors.background.withValues(alpha: 0.96),
        foregroundColor: CavColors.ink,
        titleTextStyle: const TextStyle(
          color: CavColors.ink,
          fontFamily: 'Poppins',
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shadowColor: CavColors.secondary.withValues(alpha: 0.10),
        surfaceTintColor: Colors.transparent,
        color: CavColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(CavRadii.card),
          side: const BorderSide(color: CavColors.line),
        ),
        margin: EdgeInsets.zero,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: CavColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: CavSpacing.lg,
          vertical: CavSpacing.md,
        ),
        prefixIconColor: CavColors.secondary,
        suffixIconColor: CavColors.secondary,
        floatingLabelStyle: const TextStyle(
          color: CavColors.secondary,
          fontWeight: FontWeight.w700,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(CavRadii.control),
          borderSide: BorderSide(
            color: CavColors.secondary.withValues(alpha: 0.14),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(CavRadii.control),
          borderSide: BorderSide(
            color: CavColors.secondary.withValues(alpha: 0.14),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(CavRadii.control),
          borderSide: const BorderSide(color: CavColors.primary, width: 1.6),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: CavColors.secondary,
          foregroundColor: Colors.white,
          minimumSize: const Size(48, 50),
          padding: const EdgeInsets.symmetric(horizontal: CavSpacing.lg),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(CavRadii.control),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: CavColors.secondary,
          padding: const EdgeInsets.symmetric(horizontal: CavSpacing.md),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(CavRadii.control),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: CavColors.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(CavRadii.control),
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: CavColors.accentSoft,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        labelStyle: const TextStyle(
          color: CavColors.secondary,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
        ),
        side: BorderSide.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(CavRadii.pill),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: CavColors.surface,
        indicatorColor: CavColors.primarySoft,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        height: 68,
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            fontWeight: states.contains(WidgetState.selected)
                ? FontWeight.w700
                : FontWeight.w500,
            color: states.contains(WidgetState.selected)
                ? CavColors.secondary
                : CavColors.muted,
          ),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: CavColors.ink,
        contentTextStyle: const TextStyle(
          color: Colors.white,
          fontFamily: 'Poppins',
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(CavRadii.control),
        ),
      ),
    );
  }
}
