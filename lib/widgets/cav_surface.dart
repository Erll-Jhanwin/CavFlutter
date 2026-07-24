import 'package:flutter/material.dart';

import '../app/design_tokens.dart';

/// Provides the shared styled surface used for cards and interactive panels.
class CavSurface extends StatelessWidget {
  /// Creates a surface with optional tap behavior, shadow, color, and padding.
  const CavSurface({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(CavSpacing.md),
    this.color = CavColors.surface,
    this.radius = CavRadii.card,
    this.onTap,
    this.shadow = true,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color color;
  final double radius;
  final VoidCallback? onTap;
  final bool shadow;

  /// Builds the surface and wraps tappable content in an ink response.
  @override
  Widget build(BuildContext context) {
    return _PressableSurface(
      enabled: onTap != null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        width: double.infinity,
        padding: padding,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(color: CavColors.line.withValues(alpha: 0.76)),
          boxShadow: shadow ? CavShadows.soft(CavColors.secondary) : null,
        ),
        child: onTap == null
            ? child
            : Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(radius),
                  onTap: onTap,
                  child: child,
                ),
              ),
      ),
    );
  }
}

/// Adds press feedback to a surface while leaving disabled content unchanged.
class _PressableSurface extends StatefulWidget {
  /// Creates a press-aware wrapper for [child].
  const _PressableSurface({required this.child, required this.enabled});

  final Widget child;
  final bool enabled;

  /// Creates the mutable state that tracks pointer press feedback.
  @override
  State<_PressableSurface> createState() => _PressableSurfaceState();
}

/// Stores and renders the transient pressed state for [_PressableSurface].
class _PressableSurfaceState extends State<_PressableSurface> {
  bool _pressed = false;

  /// Builds the child with a small scale change while it is pressed.
  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) return widget.child;

    return Listener(
      onPointerDown: (_) => setState(() => _pressed = true),
      onPointerCancel: (_) => setState(() => _pressed = false),
      onPointerUp: (_) => setState(() => _pressed = false),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 130),
        curve: Curves.easeOutCubic,
        scale: _pressed ? 0.985 : 1,
        child: widget.child,
      ),
    );
  }
}
