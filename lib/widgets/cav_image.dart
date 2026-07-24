import 'package:flutter/material.dart';

import '../app/design_tokens.dart';

/// Displays a clipped asset image with an optional overlay widget.
class CavImage extends StatelessWidget {
  /// Creates an image constrained by [aspectRatio] and [radius].
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

  /// Builds the clipped, aspect-ratio-preserving image stack.
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              asset,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const CavImageFallback();
              },
            ),
            ?overlay,
          ],
        ),
      ),
    );
  }
}

/// Displays a branded placeholder when an image asset cannot be loaded.
class CavImageFallback extends StatelessWidget {
  /// Creates the fallback image placeholder.
  const CavImageFallback({super.key});

  /// Builds a neutral placeholder that keeps the surrounding layout intact.
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(color: CavColors.secondarySoft),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.image_not_supported_outlined,
              color: CavColors.secondary,
              size: 32,
            ),
            const SizedBox(height: CavSpacing.xs),
            Text(
              'CAV',
              style: TextStyle(
                color: CavColors.secondary,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w800,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Adds a top-to-bottom dark gradient over an image for readable content.
class CavImageOverlay extends StatelessWidget {
  /// Creates an overlay with the specified base [opacity].
  const CavImageOverlay({super.key, this.opacity = 0.32});

  final double opacity;

  /// Builds the gradient overlay from the supplied opacity.
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
