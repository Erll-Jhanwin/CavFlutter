import 'package:flutter/material.dart';

import '../app/design_tokens.dart';
import '../models/cav_item.dart';
import 'cav_image.dart';
import 'cav_surface.dart';

/// Renders a bookable package with its image, inclusions, and booking action.
class PackageCard extends StatelessWidget {
  /// Creates a package card that invokes [onBook] when selected.
  const PackageCard({super.key, required this.package, required this.onBook});

  final CavPackage package;
  final VoidCallback onBook;

  /// Builds the package presentation and booking control.
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _AnimatedCard(
      child: CavSurface(
        padding: const EdgeInsets.all(CavSpacing.xs),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CavImage(
              asset: package.imageAsset,
              aspectRatio: 16 / 10,
              overlay: const CavImageOverlay(opacity: 0.18),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                CavSpacing.md,
                CavSpacing.md,
                CavSpacing.md,
                CavSpacing.sm,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _IconBubble(
                        icon: package.icon,
                        color: theme.colorScheme.secondary,
                      ),
                      const SizedBox(width: CavSpacing.sm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              package.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleMedium,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              package.price,
                              style: theme.textTheme.labelLarge?.copyWith(
                                color: theme.colorScheme.secondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: CavSpacing.sm),
                  Text(
                    package.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: CavSpacing.sm),
                  Wrap(
                    spacing: CavSpacing.xs,
                    runSpacing: CavSpacing.xs,
                    children: package.includes
                        .map((item) => Chip(label: Text(item)))
                        .toList(),
                  ),
                  const SizedBox(height: CavSpacing.md),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: onBook,
                      icon: const Icon(Icons.calendar_month_outlined),
                      label: Text(
                        package.category == CavCategory.studio
                            ? 'Book session'
                            : 'Book photo service',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Renders a coffee product with tags and an order action.
class CoffeeProductCard extends StatelessWidget {
  /// Creates a product card that invokes [onOrder] when selected.
  const CoffeeProductCard({
    super.key,
    required this.product,
    required this.onOrder,
  });

  final CoffeeProduct product;
  final VoidCallback onOrder;

  /// Builds the product presentation and order control.
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _AnimatedCard(
      child: CavSurface(
        padding: const EdgeInsets.all(CavSpacing.xs),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CavImage(asset: product.imageAsset, aspectRatio: 16 / 11),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                CavSpacing.md,
                CavSpacing.md,
                CavSpacing.md,
                CavSpacing.sm,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _IconBubble(
                        icon: product.icon,
                        color: theme.colorScheme.secondary,
                      ),
                      const SizedBox(width: CavSpacing.sm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleMedium,
                            ),
                            Text(
                              product.price,
                              style: theme.textTheme.labelLarge?.copyWith(
                                color: theme.colorScheme.secondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: CavSpacing.sm),
                  Text(
                    product.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: CavSpacing.sm),
                  Wrap(
                    spacing: CavSpacing.xs,
                    runSpacing: CavSpacing.xs,
                    children: product.tags
                        .map((tag) => Chip(label: Text(tag)))
                        .toList(),
                  ),
                  const SizedBox(height: CavSpacing.md),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: onOrder,
                      icon: const Icon(Icons.shopping_bag_outlined),
                      label: const Text('Order for pickup'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Displays a gallery image with its title, caption, and category icon.
class GalleryTile extends StatelessWidget {
  /// Creates a gallery tile for [item].
  const GalleryTile({super.key, required this.item});

  final GalleryItem item;

  /// Builds the image-backed gallery tile.
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _AnimatedCard(
      child: CavSurface(
        padding: const EdgeInsets.all(CavSpacing.xs),
        child: Stack(
          children: [
            CavImage(
              asset: item.imageAsset,
              aspectRatio: 4 / 3,
              overlay: const CavImageOverlay(opacity: 0.42),
            ),
            Positioned(
              left: CavSpacing.md,
              right: CavSpacing.md,
              bottom: CavSpacing.md,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _IconBubble(
                    icon: item.icon,
                    color: Colors.white,
                    inverted: true,
                  ),
                  const SizedBox(height: CavSpacing.xs),
                  Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    item.caption,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white.withValues(alpha: 0.92),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Applies a short entrance animation to card content.
class _AnimatedCard extends StatelessWidget {
  /// Creates an animated wrapper around [child].
  const _AnimatedCard({required this.child});

  final Widget child;

  /// Builds the fading and translating card animation.
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.96, end: 1),
      duration: const Duration(milliseconds: 360),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 20),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}

/// Displays an icon in a rounded bubble, optionally using an inverted style.
class _IconBubble extends StatelessWidget {
  /// Creates an icon bubble using [color] and the optional [inverted] palette.
  const _IconBubble({
    required this.icon,
    required this.color,
    this.inverted = false,
  });

  final IconData icon;
  final Color color;
  final bool inverted;

  /// Builds the icon bubble with its selected color treatment.
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: inverted
            ? Colors.white.withValues(alpha: 0.18)
            : CavColors.accentSoft,
        borderRadius: BorderRadius.circular(CavRadii.control),
      ),
      child: Icon(icon, color: inverted ? Colors.white : color, size: 21),
    );
  }
}
