import 'package:flutter/material.dart';

import '../app/design_tokens.dart';

class ResponsiveContent extends StatelessWidget {
  const ResponsiveContent({
    super.key,
    required this.child,
    this.maxWidth = 1040,
    this.withPagePadding = true,
  });

  final Widget child;
  final double maxWidth;
  final bool withPagePadding;

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
