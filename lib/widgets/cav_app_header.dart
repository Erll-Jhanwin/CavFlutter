import 'package:flutter/material.dart';

import '../app/design_tokens.dart';
import 'cav_logo.dart';

/// Provides the shared responsive app bar used by application screens.
class CavAppHeader extends StatelessWidget implements PreferredSizeWidget {
  /// Creates a header with optional subtitle, actions, logo, and primary CTA.
  const CavAppHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.primaryLabel,
    this.primaryIcon,
    this.onPrimaryPressed,
    this.secondaryAction,
    this.onNotificationsPressed,
    this.notificationCount = 0,
    this.onProfilePressed,
    this.profileTooltip = 'Open profile',
    this.showLogo = false,
    this.automaticallyImplyLeading = true,
  });

  final String title;
  final String? subtitle;
  final String? primaryLabel;
  final IconData? primaryIcon;
  final VoidCallback? onPrimaryPressed;
  final Widget? secondaryAction;
  final VoidCallback? onNotificationsPressed;
  final int notificationCount;
  final VoidCallback? onProfilePressed;
  final String profileTooltip;
  final bool showLogo;
  final bool automaticallyImplyLeading;

  /// Returns the toolbar height, increasing it when a subtitle is present.
  @override
  Size get preferredSize => Size.fromHeight(subtitle == null ? 64 : 74);

  /// Builds the responsive app bar and conditionally visible actions.
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.sizeOf(context).width;
    // Use compact controls when the full action label would crowd the bar.
    final compact = width < 560;
    final hasPrimaryAction =
        primaryLabel != null && primaryIcon != null && onPrimaryPressed != null;

    return AppBar(
      toolbarHeight: preferredSize.height - 1,
      automaticallyImplyLeading: automaticallyImplyLeading,
      leadingWidth: showLogo ? 58 : null,
      leading: showLogo
          ? Padding(
              padding: const EdgeInsets.only(left: CavSpacing.sm),
              child: Center(child: CavLogo(size: compact ? 34 : 38)),
            )
          : null,
      titleSpacing: showLogo ? CavSpacing.xs : CavSpacing.sm,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          height: 1,
          color: CavColors.line.withValues(alpha: 0.72),
        ),
      ),
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: 0,
              height: 1.05,
            ),
          ),
          if (subtitle != null && !compact) ...[
            const SizedBox(height: 2),
            Text(
              subtitle!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.2,
              ),
            ),
          ],
        ],
      ),
      actions: [
        ?secondaryAction,
        if (onNotificationsPressed != null)
          _HeaderIconAction(
            tooltip: 'Notifications',
            icon: Icons.notifications_none_outlined,
            onPressed: onNotificationsPressed!,
            badgeCount: notificationCount,
          ),
        if (onProfilePressed != null)
          _HeaderIconAction(
            tooltip: profileTooltip,
            icon: Icons.person_outline,
            onPressed: onProfilePressed!,
          ),
        if (hasPrimaryAction)
          Padding(
            padding: const EdgeInsets.only(
              left: CavSpacing.xs,
              right: CavSpacing.sm,
            ),
            child: compact
                ? IconButton.filled(
            tooltip: primaryLabel,
            onPressed: onPrimaryPressed,
            icon: Icon(primaryIcon),
            style: IconButton.styleFrom(
              backgroundColor: CavColors.secondary,
              foregroundColor: Colors.white,
              fixedSize: const Size(40, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(CavRadii.pill),
                      ),
                    ),
                  )
                : FilledButton.icon(
                    style: FilledButton.styleFrom(
                      minimumSize: Size(compact ? 42 : 46, 40),
                      padding: EdgeInsets.symmetric(
                        horizontal: compact ? CavSpacing.sm : CavSpacing.md,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(CavRadii.pill),
                      ),
                    ),
                    onPressed: onPrimaryPressed,
                    icon: Icon(primaryIcon, size: 18),
                    label: compact
                        ? const SizedBox.shrink()
                        : Text(
                            primaryLabel!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                  ),
          ),
      ],
    );
  }
}

/// Renders a circular header action with an optional notification badge.
class _HeaderIconAction extends StatelessWidget {
  /// Creates a header action using [tooltip], [icon], and [onPressed].
  const _HeaderIconAction({
    required this.tooltip,
    required this.icon,
    required this.onPressed,
    this.badgeCount = 0,
  });

  final String tooltip;
  final IconData icon;
  final VoidCallback onPressed;
  final int badgeCount;

  /// Builds the action button and adds a compact count badge when needed.
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final button = IconButton(
      tooltip: tooltip,
      onPressed: onPressed,
      icon: Icon(icon, size: 21),
      style: IconButton.styleFrom(
        backgroundColor: CavColors.surface,
        foregroundColor: theme.colorScheme.secondary,
        fixedSize: const Size(40, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(CavRadii.pill),
          side: const BorderSide(color: CavColors.line),
        ),
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(right: CavSpacing.xs),
      child: badgeCount > 0
          ? Badge(
              label: Text(badgeCount > 9 ? '9+' : '$badgeCount'),
              child: button,
            )
          : button,
    );
  }
}
