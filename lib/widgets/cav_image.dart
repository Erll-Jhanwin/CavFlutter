import 'package:flutter/material.dart';

import '../app/design_tokens.dart';

class CavImage extends StatelessWidget {
  const CavImage({
    super.key,
    required this.asset,
    this.aspectRatio = 16 / 10,
    this.radius = CavRadii.image,
    this.overlay,
  });

  final String asset;
  final double aspectRatio;
  final double radius;
  final Widget? overlay;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(asset, fit: BoxFit.cover),
            ?overlay,
          ],
        ),
      ),
    );
  }
}

class CavImageOverlay extends StatelessWidget {
  const CavImageOverlay({super.key, this.opacity = 0.32});

  final double opacity;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withValues(alpha: opacity * 0.18),
            Colors.black.withValues(alpha: opacity),
          ],
        ),
      ),
    );
  }
}
