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
import 'gallery_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.onNavigate});

  final ValueChanged<int> onNavigate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CavAppHeader(
        title: 'CAV',
        subtitle: 'Photo studio, events, and coffee',
        showLogo: true,
        automaticallyImplyLeading: false,
        primaryLabel: 'Book studio',
        primaryIcon: Icons.calendar_month_outlined,
        onPrimaryPressed: () => onNavigate(1),
        notificationCount: 2,
        onNotificationsPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No new online notifications.')),
          );
        },
        onProfilePressed: () => onNavigate(4),
        secondaryAction: IconButton(
          tooltip: 'Open gallery',
          style: IconButton.styleFrom(
            backgroundColor: CavColors.surface,
            foregroundColor: Theme.of(context).colorScheme.secondary,
            fixedSize: const Size(40, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(CavRadii.pill),
              side: const BorderSide(color: CavColors.line),
            ),
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(builder: (_) => const GalleryScreen()),
            );
          },
          icon: const Icon(Icons.photo_library_outlined),
        ),
      ),
      body: SafeArea(
        child: ResponsiveContent(
          maxWidth: 1120,
          child: ListView(
            padding: const EdgeInsets.only(
              top: CavSpacing.lg,
              bottom: CavSpacing.xl,
            ),
            children: [
              _BentoDashboard(onNavigate: onNavigate),
              const SizedBox(height: CavSpacing.xl),
              SectionHeader(
                title: 'Gallery Preview',
                subtitle: 'Recent looks across studio, event, and cafe work.',
                action: TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const GalleryScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.arrow_forward_rounded, size: 18),
                  label: const Text('View all'),
                ),
              ),
              const SizedBox(height: CavSpacing.md),
              CavAdaptiveGrid(
                minItemWidth: 260,
                spacing: CavSpacing.md,
                runSpacing: CavSpacing.md,
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

class _BentoDashboard extends StatelessWidget {
  const _BentoDashboard({required this.onNavigate});

  final ValueChanged<int> onNavigate;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 860;

        if (!wide) {
          return Column(
            children: [
              _HeroBentoCard(onNavigate: onNavigate),
              const SizedBox(height: CavSpacing.md),
              _ServiceBentoGrid(onNavigate: onNavigate),
              const SizedBox(height: CavSpacing.md),
              const _MetricStrip(),
              const SizedBox(height: CavSpacing.md),
              _FeatureBentoCard(
                title: 'Coffee Pickup',
                subtitle: 'Reserve drinks and pastries before you arrive.',
                icon: Icons.local_cafe_outlined,
                imageAsset: 'assets/images/coffee_latte.jpg',
                onTap: () => onNavigate(3),
              ),
            ],
          );
        }

        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 7,
                  child: _HeroBentoCard(onNavigate: onNavigate),
                ),
                const SizedBox(width: CavSpacing.md),
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      const _MetricStrip(),
                      const SizedBox(height: CavSpacing.md),
                      _FeatureBentoCard(
                        title: 'Coffee Pickup',
                        subtitle: 'Reserve drinks and pastries before you arrive.',
                        icon: Icons.local_cafe_outlined,
                        imageAsset: 'assets/images/coffee_latte.jpg',
                        onTap: () => onNavigate(3),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: CavSpacing.md),
            _ServiceBentoGrid(onNavigate: onNavigate),
          ],
        );
      },
    );
  }
}

class _HeroBentoCard extends StatelessWidget {
  const _HeroBentoCard({required this.onNavigate});

  final ValueChanged<int> onNavigate;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final compact = width < 420;
        final narrow = width < 560;
        final padding = compact ? CavSpacing.lg : CavSpacing.xl;
        final titleSize = width < 360
            ? 25.0
            : width < 520
            ? 28.0
            : width < 760
            ? 32.0
            : 38.0;
        final minHeight = width < 360
            ? 450.0
            : width < 560
            ? 430.0
            : width < 860
            ? 460.0
            : 430.0;

        return CavSurface(
          padding: EdgeInsets.zero,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(CavRadii.card),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: minHeight),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/studio_portrait.jpg',
                      fit: BoxFit.cover,
                      alignment: narrow
                          ? Alignment.center
                          : Alignment.centerLeft,
                    ),
                  ),
                  const Positioned.fill(child: CavImageOverlay(opacity: 0.58)),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.all(padding),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _Pill(
                            label: 'Studio / Events / Coffee',
                            color: Colors.white.withValues(alpha: 0.18),
                            foreground: Colors.white,
                          ),
                          SizedBox(
                            height: narrow ? CavSpacing.xl : CavSpacing.xxl,
                          ),
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 620),
                            child: Text(
                              'Book photo sessions, event coverage, and cafe pickups.',
                              maxLines: narrow ? 4 : 3,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.displaySmall?.copyWith(
                                color: Colors.white,
                                fontSize: titleSize,
                                height: 1.08,
                              ),
                            ),
                          ),
                          const SizedBox(height: CavSpacing.sm),
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 560),
                            child: Text(
                              'A polished sample experience for planning CAV services with fast browsing and simple forms.',
                              maxLines: narrow ? 4 : 3,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: Colors.white.withValues(alpha: 0.90),
                                fontSize: compact ? 13.5 : 15,
                                height: 1.38,
                              ),
                            ),
                          ),
                          const SizedBox(height: CavSpacing.lg),
                          Wrap(
                            spacing: CavSpacing.sm,
                            runSpacing: CavSpacing.sm,
                            children: [
                              FilledButton.icon(
                                onPressed: () => onNavigate(1),
                                icon: const Icon(Icons.calendar_month_outlined),
                                label: const Text('Book session'),
                              ),
                              TextButton.icon(
                                onPressed: () => onNavigate(3),
                                icon: const Icon(Icons.local_cafe_outlined),
                                label: const Text('Coffee menu'),
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.white.withValues(
                                    alpha: 0.12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ServiceBentoGrid extends StatelessWidget {
  const _ServiceBentoGrid({required this.onNavigate});

  final ValueChanged<int> onNavigate;

  @override
  Widget build(BuildContext context) {
    final services = [
      _BentoAction(
        title: 'Photo Studio',
        subtitle: 'Portraits and product sets',
        icon: Icons.photo_camera_outlined,
        index: 1,
        imageAsset: 'assets/images/studio_product.jpg',
      ),
      _BentoAction(
        title: 'Events',
        subtitle: 'Weddings and celebrations',
        icon: Icons.event_available_outlined,
        index: 2,
        imageAsset: 'assets/images/event_wedding.jpg',
      ),
      _BentoAction(
        title: 'Coffee Shop',
        subtitle: 'Drinks and pastries',
        icon: Icons.local_cafe_outlined,
        index: 3,
        imageAsset: 'assets/images/cafe_interior.jpg',
      ),
      _BentoAction(
        title: 'Profile',
        subtitle: 'Hours and contact details',
        icon: Icons.contact_phone_outlined,
        index: 4,
        imageAsset: 'assets/images/event_corporate.jpg',
      ),
    ];

    return CavAdaptiveGrid(
      minItemWidth: 220,
      spacing: CavSpacing.md,
      runSpacing: CavSpacing.md,
      children: services
          .map(
            (service) => _ServiceBentoTile(
              service: service,
              onTap: () => onNavigate(service.index),
            ),
          )
          .toList(),
    );
  }
}

class _ServiceBentoTile extends StatelessWidget {
  const _ServiceBentoTile({required this.service, required this.onTap});

  final _BentoAction service;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CavSurface(
      onTap: onTap,
      padding: const EdgeInsets.all(CavSpacing.sm),
      child: Row(
        children: [
          SizedBox(
            width: 74,
            child: CavImage(
              asset: service.imageAsset,
              aspectRatio: 1,
              radius: CavRadii.cardSm,
              overlay: const CavImageOverlay(opacity: 0.12),
            ),
          ),
          const SizedBox(width: CavSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(service.icon, color: theme.colorScheme.secondary),
                const SizedBox(height: CavSpacing.xs),
                Text(
                  service.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  service.subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_rounded, size: 20),
        ],
      ),
    );
  }
}

class _MetricStrip extends StatelessWidget {
  const _MetricStrip();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 360;
        final metrics = [
          const _MetricTile(
            value: '10+',
            label: 'Packages',
            icon: Icons.auto_awesome_outlined,
          ),
          const _MetricTile(
            value: '3',
            label: 'Services',
            icon: Icons.dashboard_customize_outlined,
          ),
        ];

        return compact
            ? Column(
                children: [
                  metrics[0],
                  const SizedBox(height: CavSpacing.md),
                  metrics[1],
                ],
              )
            : Row(
                children: [
                  Expanded(child: metrics[0]),
                  const SizedBox(width: CavSpacing.md),
                  Expanded(child: metrics[1]),
                ],
              );
      },
    );
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({
    required this.value,
    required this.label,
    required this.icon,
  });

  final String value;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CavSurface(
      color: CavColors.secondary,
      padding: const EdgeInsets.all(CavSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: CavColors.accent, size: 26),
          const SizedBox(height: CavSpacing.lg),
          Text(
            value,
            style: theme.textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.78),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureBentoCard extends StatelessWidget {
  const _FeatureBentoCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.imageAsset,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final String imageAsset;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CavSurface(
      onTap: onTap,
      padding: const EdgeInsets.all(CavSpacing.sm),
      color: CavColors.accentSoft,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(CavSpacing.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(icon, color: theme.colorScheme.secondary),
                  const SizedBox(height: CavSpacing.md),
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: CavSpacing.xs),
                  Text(
                    subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: CavSpacing.sm),
          SizedBox(
            width: 132,
            child: CavImage(
              asset: imageAsset,
              aspectRatio: 1,
              radius: CavRadii.cardSm,
            ),
          ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({
    required this.label,
    required this.color,
    required this.foreground,
  });

  final String label;
  final Color color;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: CavSpacing.md,
        vertical: CavSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(CavRadii.pill),
        border: Border.all(color: Colors.white.withValues(alpha: 0.20)),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: foreground,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _BentoAction {
  const _BentoAction({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.index,
    required this.imageAsset,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final int index;
  final String imageAsset;
}
