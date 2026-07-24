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

/// Attempts to open a social URL through the native app or default browser.
Future<bool> openSocialLink(String url) async {
  try {
    return await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
  } catch (_) {
    return false;
  }
}

/// Opens social URLs through the operating system and reports failures inline.
class SocialMediaLinkLauncher {
  /// Prevents instantiation because launching is provided as a static helper.
  const SocialMediaLinkLauncher._();

  /// Opens [link] in the native app or the default browser when available.
  static Future<void> open(BuildContext context, SocialMediaLink link) async {
    // External application mode lets Android/iOS route universal links to an
    // installed social app, while desktop and web use the default browser.
    final opened = await openSocialLink(link.url);

    if (!opened && context.mounted) {
      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
        SnackBar(content: Text('Unable to open ${link.label}.')),
      );
    }
  }
}

/// Displays one responsive row of social media buttons with hover and ripple feedback.
class SocialMediaLinks extends StatelessWidget {
  /// Creates a horizontal social-links row using [links] or the CAV defaults.
  const SocialMediaLinks({super.key, this.links = CavSocialLinks.all});

  final List<SocialMediaLink> links;

  /// Builds platform buttons that remain compact on narrow screens.
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var index = 0; index < links.length; index++) ...[
          if (index > 0) const SizedBox(width: CavSpacing.sm),
          Tooltip(
            message: 'Open ${links[index].label}',
            child: IconButton(
              onPressed: () =>
                  SocialMediaLinkLauncher.open(context, links[index]),
              icon: FaIcon(links[index].icon, size: 19),
              style: IconButton.styleFrom(
                backgroundColor: links[index].color.withValues(alpha: 0.1),
                foregroundColor: links[index].color,
                hoverColor: links[index].color.withValues(alpha: 0.18),
                overlayColor: links[index].color.withValues(alpha: 0.22),
                fixedSize: const Size(44, 44),
                shape: const CircleBorder(),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
