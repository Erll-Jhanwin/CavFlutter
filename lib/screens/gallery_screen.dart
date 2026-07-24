import 'package:flutter/material.dart';

import '../app/design_tokens.dart';
import '../data/cav_repository.dart';
import '../widgets/adaptive_grid.dart';
import '../widgets/cav_app_header.dart';
import '../widgets/cav_cards.dart';
import '../widgets/responsive_content.dart';

/// Displays all gallery entries in a responsive grid.
class GalleryScreen extends StatelessWidget {
  /// Creates the gallery screen.
  const GalleryScreen({super.key});

  /// Builds the gallery header and responsive tile grid.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CavAppHeader(
        title: 'Gallery',
        subtitle: 'Studio, event, and café work samples',
      ),
      body: SafeArea(
        child: ResponsiveContent(
          child: ListView(
            padding: const EdgeInsets.only(
              top: CavSpacing.lg,
              bottom: CavSpacing.xl,
            ),
            children: [
              CavAdaptiveGrid(
                minItemWidth: 250,
                children: CavRepository.galleryItems
                    .map((item) => GalleryTile(item: item))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
