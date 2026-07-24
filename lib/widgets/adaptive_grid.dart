import 'package:flutter/material.dart';

import '../app/design_tokens.dart';

/// Lays out children in a responsive grid with one to four columns.
class CavAdaptiveGrid extends StatelessWidget {
  /// Creates a grid whose columns respect [minItemWidth] where possible.
  const CavAdaptiveGrid({
    super.key,
    required this.children,
    this.minItemWidth = 280,
    this.spacing = CavSpacing.md,
    this.runSpacing = CavSpacing.md,
  });

  final List<Widget> children;
  final double minItemWidth;
  final double spacing;
  final double runSpacing;

  /// Calculates item width from the available constraints and builds the grid.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;
        // Clamp columns so cards remain readable without exceeding four columns.
        final columns = (availableWidth / minItemWidth).floor().clamp(1, 4);
        final itemWidth =
            (availableWidth - (spacing * (columns - 1))) / columns;

        return Wrap(
          spacing: spacing,
          runSpacing: runSpacing,
          children: children
              .map((child) => SizedBox(width: itemWidth, child: child))
              .toList(),
        );
      },
    );
  }
}
