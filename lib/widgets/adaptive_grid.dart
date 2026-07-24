import 'package:flutter/material.dart';

import '../app/design_tokens.dart';

class CavAdaptiveGrid extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;
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
