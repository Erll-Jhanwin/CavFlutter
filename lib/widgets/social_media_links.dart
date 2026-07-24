import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../app/design_tokens.dart';

/// Describes one social platform, its official icon, and its public URL.
class SocialMediaLink {
  /// Creates an immutable social link definition.
  const SocialMediaLink({
    required this.label,
    required this.url,
    required this.icon,
    required this.color,
  });

  final String label;
  final String url;
  final FaIconData icon;
  final Color color;
}

/// Provides the official CAV social links used across the app.
class CavSocialLinks {
  /// Prevents instantiation because the link definitions are static.
  const CavSocialLinks._();

  static const all = [
    SocialMediaLink(
      label: 'Facebook',
      url: 'https://www.facebook.com/profile.php?id=61567073794924',
      icon: FontAwesomeIcons.facebookF,
      color: Color(0xFF1877F2),
    ),
    SocialMediaLink(
      label: 'Instagram',
      url: 'https://www.instagram.com/cavstudiocafe/',
      icon: FontAwesomeIcons.instagram,
      color: Color(0xFFE4405F),
    ),
    SocialMediaLink(
      label: 'TikTok',
      url: 'https://www.tiktok.com/@cav.photo.studio?is_from_webapp=1&sender_device=pc',
      icon: FontAwesomeIcons.tiktok,
      color: Color(0xFF111111),
    ),
  ];
}

/// Opens social URLs through the operating system and reports failures inline.
class SocialMediaLinkLauncher {
  /// Prevents instantiation because launching is provided as a static helper.
  const SocialMediaLinkLauncher._();

  /// Opens [link] in the native app or the default browser when available.
  static Future<void> open(BuildContext context, SocialMediaLink link) async {
    final uri = Uri.parse(link.url);
    var opened = false;

    try {
      // External application mode lets Android/iOS route universal links to an
      // installed social app, while desktop and web use the default browser.
      opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      opened = false;
    }

    if (!opened && context.mounted) {
      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
        SnackBar(content: Text('Unable to open ${link.label}.')),
      );
    }
  }
}

/// Displays reusable, responsive social media buttons with hover and ripple feedback.
class SocialMediaLinks extends StatelessWidget {
  /// Creates a horizontal social-links row using [links] or the CAV defaults.
  const SocialMediaLinks({super.key, this.links = CavSocialLinks.all});

  final List<SocialMediaLink> links;

  /// Builds platform buttons that remain compact on narrow screens.
  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: CavSpacing.sm,
      runSpacing: CavSpacing.sm,
      children: links
          .map(
            (link) => Tooltip(
              message: 'Open ${link.label}',
              child: IconButton(
                onPressed: () => SocialMediaLinkLauncher.open(context, link),
                icon: FaIcon(link.icon, size: 19),
                style: IconButton.styleFrom(
                  backgroundColor: link.color.withValues(alpha: 0.1),
                  foregroundColor: link.color,
                  hoverColor: link.color.withValues(alpha: 0.18),
                  overlayColor: link.color.withValues(alpha: 0.22),
                  fixedSize: const Size(44, 44),
                  shape: const CircleBorder(),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

/// Adds a consistent social-media footer to public-facing app pages.
class CavAppFooter extends StatelessWidget {
  /// Creates the shared footer with an optional supporting [message].
  const CavAppFooter({
    super.key,
    this.message = 'Follow CAV for new studio and café updates.',
  });

  final String message;

  /// Builds the footer copy and social links with responsive spacing.
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(CavSpacing.lg),
      decoration: BoxDecoration(
        color: CavColors.surfaceWarm,
        borderRadius: BorderRadius.circular(CavRadii.card),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 560;
          final content = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Stay connected with CAV',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: CavSpacing.xs),
              Text(
                message,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: CavSpacing.md),
              const SocialMediaLinks(),
            ],
          );

          return compact ? content : Row(children: [Expanded(child: content)]);
        },
      ),
    );
  }
}
