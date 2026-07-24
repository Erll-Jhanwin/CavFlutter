import 'package:flutter/material.dart';

import '../app/design_tokens.dart';
import '../widgets/cav_app_header.dart';
import '../widgets/cav_image.dart';
import '../widgets/cav_surface.dart';
import '../widgets/responsive_content.dart';
import '../widgets/section_header.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                          'Sample City, Philippines',
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: CavSpacing.sm),
                      Text(
                        'CAV Photo Studio, Events, and Coffee',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0,
                        ),
                      ),
                      const SizedBox(height: CavSpacing.xs),
                      Text(
                        'Portrait sessions, event coverage, and cafe pickups in one simple local experience.',
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
                                asset: 'assets/images/cafe_interior.jpg',
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
                                  asset: 'assets/images/cafe_interior.jpg',
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
                subtitle: 'Everything needed to reach the studio and cafe.',
              ),
              const SizedBox(height: CavSpacing.md),
              LayoutBuilder(
                builder: (context, constraints) {
                  final twoColumns = constraints.maxWidth >= 700;
                  final width = twoColumns
                      ? (constraints.maxWidth - CavSpacing.md) / 2
                      : constraints.maxWidth;
                  const tiles = [
                    _InfoTile(
                      icon: Icons.location_on_outlined,
                      title: 'Address',
                      value: 'CAV Studio and Cafe, Sample City, Philippines',
                    ),
                    _InfoTile(
                      icon: Icons.schedule_outlined,
                      title: 'Business Hours',
                      value: 'Monday to Sunday, 9:00 AM - 8:00 PM',
                    ),
                    _InfoTile(
                      icon: Icons.phone_outlined,
                      title: 'Contact Number',
                      value: '+63 900 000 0000',
                    ),
                    _InfoTile(
                      icon: Icons.email_outlined,
                      title: 'Email',
                      value: 'hello@cavstudio.example',
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

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

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
