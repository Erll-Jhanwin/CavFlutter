import 'package:flutter/material.dart';

/// Defines the shared color palette used throughout the application.
class CavColors {
  /// Prevents instantiation of this static token collection.
  const CavColors._();

  static const background = Color(0xFFFAF9F7);
  static const surface = Color(0xFFFFFFFF);
  static const primary = Color(0xFFC8A97E);
  static const secondary = Color(0xFF6F4E37);
  static const accent = Color(0xFFD9B99B);
  static const ink = Color(0xFF1F2937);

  static const surfaceWarm = Color(0xFFF4EFE8);
  static const primarySoft = Color(0xFFF4E7D5);
  static const secondarySoft = Color(0xFFF1E8E0);
  static const accentSoft = Color(0xFFF8EFE8);
  static const muted = Color(0xFF667085);
  static const line = Color(0xFFE9E1D7);
  static const success = Color(0xFF5C7F67);
  static const slate = Color(0xFF354052);
}

/// Defines the shared spacing scale used for layout gaps and padding.
class CavSpacing {
  /// Prevents instantiation of this static token collection.
  const CavSpacing._();

  static const xs = 6.0;
  static const sm = 10.0;
  static const md = 14.0;
  static const lg = 20.0;
  static const xl = 28.0;
  static const xxl = 40.0;
}

/// Defines the shared corner-radius scale for images, cards, and controls.
class CavRadii {
  /// Prevents instantiation of this static token collection.
  const CavRadii._();

  static const image = 20.0;
  static const card = 24.0;
  static const cardSm = 18.0;
  static const control = 16.0;
  static const pill = 999.0;
}

/// Provides reusable shadow recipes for elevated surfaces.
class CavShadows {
  /// Prevents instantiation of this static token collection.
  const CavShadows._();

  /// Returns a soft two-layer shadow using [color] as its tint.
  static List<BoxShadow> soft(Color color) {
    return [
      BoxShadow(
        color: color.withValues(alpha: 0.08),
        blurRadius: 24,
        offset: const Offset(0, 12),
      ),
      BoxShadow(
        color: Colors.white.withValues(alpha: 0.76),
        blurRadius: 4,
        offset: const Offset(0, -2),
      ),
    ];
  }

  /// Returns a single stronger shadow for visibly lifted content.
  static List<BoxShadow> lift(Color color) {
    return [
      BoxShadow(
        color: color.withValues(alpha: 0.12),
        blurRadius: 32,
        offset: const Offset(0, 18),
      ),
    ];
  }
}
