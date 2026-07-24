import 'package:flutter/material.dart';

import '../app/design_tokens.dart';
import '../data/cav_repository.dart';
import '../models/cav_item.dart';
import '../widgets/adaptive_grid.dart';
import '../widgets/cav_app_header.dart';
import '../widgets/cav_cards.dart';
import '../widgets/cav_image.dart';
import '../widgets/cav_surface.dart';
import '../widgets/responsive_content.dart';
import '../widgets/section_header.dart';
import 'booking_screen.dart';

/// Shows the studio package catalog through the shared package-list screen.
class StudioScreen extends StatelessWidget {
  /// Creates the studio screen.
  const StudioScreen({super.key});

  /// Builds the configured studio package catalog.
  @override
  Widget build(BuildContext context) {
    return PackageListScreen(
      title: 'Photo Studio',
      subtitle: 'Five 15-minute studio session packages at ₱1,000 each.',
      packages: CavRepository.studioPackages,
    );
  }
}

/// Displays a titled, reusable list of bookable [packages].
class PackageListScreen extends StatelessWidget {
  /// Creates a package list with its header copy and package data.
  const PackageListScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.packages,
  });

  final String title;
  final String subtitle;
  final List<CavPackage> packages;

  /// Builds the package introduction and adaptive package-card grid.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CavAppHeader(
        title: title,
        subtitle: subtitle,
        primaryLabel: packages.isNotEmpty &&
                packages.first.category == CavCategory.event
            ? 'Book service'
            : 'Book session',
        primaryIcon: Icons.calendar_month_outlined,
        onPrimaryPressed: packages.isEmpty
            ? null
            : () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => BookingScreen(package: packages.first),
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
              _PackageIntro(
                title: title,
                subtitle: subtitle,
                imageAsset: packages.first.imageAsset,
                countLabel: packages.first.category == CavCategory.event
                    ? 'Events + outdoor photoshoots'
                    : '${packages.length} studio packages',
              ),
              const SizedBox(height: CavSpacing.xl),
              SectionHeader(
                title: 'Available Packages',
                subtitle: packages.first.category == CavCategory.event
                    ? 'Request coverage for events or outdoor photoshoots.'
                    : 'Choose a 15-minute studio session.',
              ),
              const SizedBox(height: CavSpacing.md),
              CavAdaptiveGrid(
                minItemWidth: 280,
                children: packages
                    .map(
                      (package) => PackageCard(
                        package: package,
                        onBook: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => BookingScreen(package: package),
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

/// Presents the package category introduction in a responsive panel.
class _PackageIntro extends StatelessWidget {
  /// Creates an introduction panel from its display text and image asset.
  const _PackageIntro({
    required this.title,
    required this.subtitle,
    required this.imageAsset,
    required this.countLabel,
  });

  final String title;
  final String subtitle;
  final String imageAsset;
  final String countLabel;

  /// Builds the introduction copy beside or below its image.
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CavSurface(
      padding: const EdgeInsets.all(CavSpacing.sm),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final wide = constraints.maxWidth >= 720;
          final copy = Padding(
            padding: const EdgeInsets.all(CavSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Chip(label: Text(countLabel)),
                const SizedBox(height: CavSpacing.md),
                Text(title, style: theme.textTheme.headlineMedium),
                const SizedBox(height: CavSpacing.sm),
                Text(
                  subtitle,
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
                CavImage(
                  asset: imageAsset,
                  aspectRatio: 16 / 10,
                  overlay: const CavImageOverlay(opacity: 0.12),
                ),
                copy,
              ],
            );
          }

          return Row(
            children: [
              Expanded(child: copy),
              const SizedBox(width: CavSpacing.sm),
              Expanded(
                child: CavImage(
                  asset: imageAsset,
                  aspectRatio: 16 / 10,
                  overlay: const CavImageOverlay(opacity: 0.12),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
