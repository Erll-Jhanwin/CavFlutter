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

/// Builds the CAV landing page and routes requests to primary destinations.
class HomeScreen extends StatelessWidget {
  /// Creates the home screen with a navigation callback for destination indexes.
  const HomeScreen({super.key, required this.onNavigate});

  final ValueChanged<int> onNavigate;

  /// Builds the responsive home dashboard and gallery preview.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CavAppHeader(
        title: 'Frame & Brew',
        subtitle: 'Photo studio, photo services, and café',
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
                subtitle: 'Recent looks across studio, event, and café work.',
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

/// Arranges the hero, service, metric, and feature cards for each breakpoint.
class _BentoDashboard extends StatelessWidget {
  /// Creates a dashboard that forwards destination changes to [onNavigate].
  const _BentoDashboard({required this.onNavigate});

  final ValueChanged<int> onNavigate;

  /// Builds a stacked mobile layout or a two-column desktop composition.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // The dashboard changes composition rather than merely shrinking cards.
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
                subtitle: 'Browse 14 café drinks before you arrive.',
                icon: Icons.local_cafe_outlined,
                imageAsset: 'assets/PICS/menu_drinks/cappuccino.jpg',
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
                        subtitle: 'Browse 14 café drinks before you arrive.',
                        icon: Icons.local_cafe_outlined,
                        imageAsset: 'assets/PICS/menu_drinks/cappuccino.jpg',
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

/// Displays the primary studio call to action over a responsive hero image.
class _HeroBentoCard extends StatelessWidget {
  /// Creates a hero card that uses [onNavigate] for its actions.
  const _HeroBentoCard({required this.onNavigate});

  final ValueChanged<int> onNavigate;

  /// Builds the hero card with breakpoint-specific typography and spacing.
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        // Tune hero text and height independently for phone and tablet widths.
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
                      'assets/PICS/business/Store.jpg',
                      fit: BoxFit.cover,
                      alignment: narrow
                          ? Alignment.center
                          : Alignment.centerLeft,
                      errorBuilder: (context, error, stackTrace) {
                        return const CavImageFallback();
                      },
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
                            label: 'Studio / Photo Services / Café',
                            color: Colors.white.withValues(alpha: 0.18),
                            foreground: Colors.white,
                          ),
                          SizedBox(
                            height: narrow ? CavSpacing.xl : CavSpacing.xxl,
                          ),
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 620),
                            child: Text(
                              'Book studio sessions, photo services, and café pickups.',
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
                              'Choose a 15-minute studio session, request photo coverage, or browse the café menu.',
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
                                label: const Text('Café menu'),
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

/// Creates the service shortcuts displayed below or beside the hero card.
class _ServiceBentoGrid extends StatelessWidget {
  /// Creates a service grid that forwards tile taps to [onNavigate].
  const _ServiceBentoGrid({required this.onNavigate});

  final ValueChanged<int> onNavigate;

  /// Builds service definitions and maps them to interactive tiles.
  @override
  Widget build(BuildContext context) {
    final services = [
      _BentoAction(
        title: 'Photo Studio',
        subtitle: 'Five 15-minute session packages',
        icon: Icons.photo_camera_outlined,
        index: 1,
        imageAsset: 'assets/PICS/solo/solo pic portrait.jpg',
      ),
      _BentoAction(
        title: 'Events',
        subtitle: 'Events and outdoor photoshoots',
        icon: Icons.event_available_outlined,
        index: 2,
        imageAsset: 'assets/PICS/events/event (3).jpg',
      ),
      _BentoAction(
        title: 'Café',
        subtitle: '14 drinks in four categories',
        icon: Icons.local_cafe_outlined,
        index: 3,
        imageAsset: 'assets/PICS/menu_drinks/sparkling_mango.jpg',
      ),
      _BentoAction(
        title: 'Profile',
        subtitle: 'Address and social contacts',
        icon: Icons.contact_phone_outlined,
        index: 4,
        imageAsset: 'assets/PICS/solo/solo pic portrait (2).jpg',
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

/// Displays one image-backed shortcut for a CAV service.
class _ServiceBentoTile extends StatelessWidget {
  /// Creates a service tile from [service] and its tap callback.
  const _ServiceBentoTile({required this.service, required this.onTap});

  final _BentoAction service;
  final VoidCallback onTap;

  /// Builds the service image, label, icon, and navigation affordance.
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

/// Displays the key service metrics with a compact responsive arrangement.
class _MetricStrip extends StatelessWidget {
  /// Creates the metric strip.
  const _MetricStrip();

  /// Builds metrics in a column on narrow layouts and a row otherwise.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 360;
        final metrics = [
          const _MetricTile(
            value: '5',
            label: 'Studio packages',
            icon: Icons.auto_awesome_outlined,
          ),
          const _MetricTile(
            value: '14',
            label: 'Café drinks',
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

/// Displays one numeric metric with its label and icon.
class _MetricTile extends StatelessWidget {
  /// Creates a metric tile from its [value], [label], and [icon].
  const _MetricTile({
    required this.value,
    required this.label,
    required this.icon,
  });

  final String value;
  final String label;
  final IconData icon;

  /// Builds the colored metric surface.
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

/// Displays an image-backed feature card that navigates on tap.
class _FeatureBentoCard extends StatelessWidget {
  /// Creates a feature card from its content and [onTap] callback.
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

  /// Builds the feature copy beside its supporting image.
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

/// Displays compact pill-shaped text over the hero image.
class _Pill extends StatelessWidget {
  /// Creates a pill using [color] and [foreground] for its palette.
  const _Pill({
    required this.label,
    required this.color,
    required this.foreground,
  });

  final String label;
  final Color color;
  final Color foreground;

  /// Builds the rounded label container.
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

/// Holds the display data and destination index for a service shortcut.
class _BentoAction {
  /// Creates immutable service shortcut data.
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
