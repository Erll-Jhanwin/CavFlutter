import 'package:flutter/material.dart';

import '../app/design_tokens.dart';

/// Displays the compact CAV brand mark at the requested [size].
class CavLogo extends StatelessWidget {
  /// Creates a logo with a default size suitable for cards and headers.
  const CavLogo({super.key, this.size = 72});

  final double size;

  /// Builds the branded mark with responsive corner radius and shadow.
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: CavColors.secondary,
        borderRadius: BorderRadius.circular(size >= 64 ? 24 : 16),
        boxShadow: CavShadows.soft(CavColors.secondary),
      ),
      alignment: Alignment.center,
      child: Text(
        'CAV',
        style: theme.textTheme.titleLarge?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          letterSpacing: 0,
        ),
      ),
    );
  }
}
