import 'package:flutter/material.dart';

import '../app/design_tokens.dart';

/// Centers content within a maximum width and applies responsive page padding.
class ResponsiveContent extends StatelessWidget {
  /// Creates responsive content with an optional [maxWidth] and page inset.
  const ResponsiveContent({
    super.key,
    required this.child,
    this.maxWidth = 1040,
    this.withPagePadding = true,
  });

  final Widget child;
  final double maxWidth;
  final bool withPagePadding;

  /// Builds the constrained layout using padding based on viewport width.
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final horizontalPadding = size.width < 360
        ? CavSpacing.md
        : size.width < 720
        ? CavSpacing.lg
        : CavSpacing.xl;

    return LayoutBuilder(
      builder: (context, constraints) {
        // Keep content centered while allowing narrow screens to use all space.
        return Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: maxWidth,
              minWidth: constraints.maxWidth < maxWidth
                  ? constraints.maxWidth
                  : maxWidth,
            ),
            child: Padding(
              padding: withPagePadding
                  ? EdgeInsets.symmetric(horizontal: horizontalPadding)
                  : EdgeInsets.zero,
              child: child,
            ),
          ),
        );
      },
    );
  }
}
