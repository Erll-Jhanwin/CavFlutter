import 'package:flutter/material.dart';

import '../app/design_tokens.dart';
import '../data/cav_repository.dart';
import '../widgets/cav_app_header.dart';
import '../widgets/cav_image.dart';
import '../widgets/cav_surface.dart';
import '../widgets/responsive_content.dart';
import '../widgets/section_header.dart';

/// Presents CAV business details, address, email, and social contacts.
class AboutScreen extends StatelessWidget {
  /// Creates the profile and business-information screen.
  const AboutScreen({super.key});

  /// Builds the profile introduction and responsive information tiles.
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final contact = CavRepository.contactDetails;
    return Scaffold(
      appBar: const CavAppHeader(
        title: 'Profile',
        subtitle: 'Business details and contact information',
      ),
      body: SafeArea(
        child: ResponsiveContent(
          child: ListView(
            padding: const EdgeInsets.only(
              top: CavSpacing.lg,
              bottom: CavSpacing.xl,
            ),
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  final compact = constraints.maxWidth < 680;
                  final textColumn = Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: CavSpacing.sm,
                          vertical: CavSpacing.xs,
                        ),
                        decoration: BoxDecoration(
                          color: CavColors.primarySoft,
                          borderRadius: BorderRadius.circular(CavRadii.pill),
                        ),
                        child: Text(
                          'Lipa City, Batangas',
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: CavSpacing.sm),
                      Text(
                        'CAV Photo Studio & Cafe',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0,
                        ),
                      ),
                      const SizedBox(height: CavSpacing.xs),
                      Text(
                        'Studio sessions, photo service booking, and café drinks in one local experience.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  );

                  return CavSurface(
                    padding: const EdgeInsets.all(CavSpacing.sm),
                    color: CavColors.accentSoft,
                    child: compact
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CavImage(
                                asset: 'assets/PICS/business/Store.jpg',
                                aspectRatio: 16 / 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(CavSpacing.md),
                                child: textColumn,
                              ),
                            ],
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 210,
                                child: CavImage(
                                  asset: 'assets/PICS/business/Store.jpg',
                                  aspectRatio: 4 / 3,
                                ),
                              ),
                              const SizedBox(width: CavSpacing.md),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(CavSpacing.sm),
                                  child: textColumn,
                                ),
                              ),
                            ],
                          ),
                  );
                },
              ),
              const SizedBox(height: CavSpacing.xl),
              const SectionHeader(
                title: 'Business Information',
                subtitle: 'Official address, email, and social contacts.',
              ),
              const SizedBox(height: CavSpacing.md),
              LayoutBuilder(
                builder: (context, constraints) {
                  final twoColumns = constraints.maxWidth >= 700;
                  final width = twoColumns
                      ? (constraints.maxWidth - CavSpacing.md) / 2
                      : constraints.maxWidth;
                  final tiles = [
                    _InfoTile(
                      icon: Icons.location_on_outlined,
                      title: 'Address',
                      value: contact.address,
                    ),
                    _InfoTile(
                      icon: Icons.email_outlined,
                      title: 'Email',
                      value: contact.email,
                    ),
                    _InfoTile(
                      icon: Icons.facebook,
                      title: 'Facebook',
                      value: contact.facebook,
                    ),
                    _InfoTile(
                      icon: Icons.camera_alt_outlined,
                      title: 'Instagram',
                      value: contact.instagram,
                    ),
                    _InfoTile(
                      icon: Icons.music_note_outlined,
                      title: 'TikTok',
                      value: contact.tiktok,
                    ),
                  ];

                  return Wrap(
                    spacing: CavSpacing.md,
                    runSpacing: CavSpacing.md,
                    children: tiles
                        .map((tile) => SizedBox(width: width, child: tile))
                        .toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Displays one labeled business-information item with an icon.
class _InfoTile extends StatelessWidget {
  /// Creates an information tile from its icon, title, and value.
  const _InfoTile({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  /// Builds the icon, label, and supporting value row.
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CavSurface(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: CavColors.primarySoft,
              borderRadius: BorderRadius.circular(CavRadii.control),
            ),
            child: Icon(icon, color: theme.colorScheme.secondary, size: 22),
          ),
          const SizedBox(width: CavSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
