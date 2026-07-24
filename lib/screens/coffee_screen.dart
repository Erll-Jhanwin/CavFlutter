import 'package:flutter/material.dart';

import '../app/design_tokens.dart';
import '../data/cav_repository.dart';
import '../widgets/adaptive_grid.dart';
import '../widgets/cav_app_header.dart';
import '../widgets/cav_cards.dart';
import '../widgets/cav_image.dart';
import '../widgets/cav_surface.dart';
import '../widgets/responsive_content.dart';
import '../widgets/section_header.dart';
import 'order_screen.dart';

class CoffeeScreen extends StatelessWidget {
  const CoffeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CavAppHeader(
        title: 'Coffee',
        subtitle: 'Drinks and pastries for sample pickup orders',
        primaryLabel: 'Order',
        primaryIcon: Icons.shopping_bag_outlined,
        onPrimaryPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) =>
                  OrderScreen(product: CavRepository.coffeeProducts.first),
            ),
          );
        },
      ),
      body: SafeArea(
        child: ResponsiveContent(
          child: ListView(
            padding: const EdgeInsets.only(
              top: CavSpacing.lg,
              bottom: CavSpacing.xl,
            ),
            children: [
              const _CoffeeIntro(),
              const SizedBox(height: CavSpacing.xl),
              const SectionHeader(
                title: 'Coffee Menu',
                subtitle: 'Simple pickup-ready favorites from the cafe.',
              ),
              const SizedBox(height: CavSpacing.md),
              CavAdaptiveGrid(
                minItemWidth: 250,
                children: CavRepository.coffeeProducts
                    .map(
                      (product) => CoffeeProductCard(
                        product: product,
                        onOrder: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => OrderScreen(product: product),
                            ),
                          );
                        },
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CoffeeIntro extends StatelessWidget {
  const _CoffeeIntro();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CavSurface(
      padding: const EdgeInsets.all(CavSpacing.sm),
      color: CavColors.accentSoft,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final wide = constraints.maxWidth >= 720;
          final copy = Padding(
            padding: const EdgeInsets.all(CavSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Chip(label: Text('Cafe pickup')),
                const SizedBox(height: CavSpacing.md),
                Text('Warm drinks, quiet design.', style: theme.textTheme.headlineMedium),
                const SizedBox(height: CavSpacing.sm),
                Text(
                  'Reserve sample drinks and pastries with a focused form designed for quick orders.',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          );

          if (!wide) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CavImage(
                  asset: 'assets/images/cafe_interior.jpg',
                  aspectRatio: 16 / 10,
                  overlay: CavImageOverlay(opacity: 0.12),
                ),
                copy,
              ],
            );
          }

          return Row(
            children: [
              const Expanded(
                child: CavImage(
                  asset: 'assets/images/cafe_interior.jpg',
                  aspectRatio: 16 / 10,
                  overlay: CavImageOverlay(opacity: 0.12),
                ),
              ),
              const SizedBox(width: CavSpacing.sm),
              Expanded(child: copy),
            ],
          );
        },
      ),
    );
  }
}
