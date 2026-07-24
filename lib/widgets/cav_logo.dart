import 'package:flutter/material.dart';

import '../app/design_tokens.dart';

class CavLogo extends StatelessWidget {
  const CavLogo({super.key, this.size = 72});

  final double size;

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
