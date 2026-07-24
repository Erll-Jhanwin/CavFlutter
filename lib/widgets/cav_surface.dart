import 'package:flutter/material.dart';

import '../app/design_tokens.dart';

class CavSurface extends StatelessWidget {
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

class _PressableSurface extends StatefulWidget {
  const _PressableSurface({required this.child, required this.enabled});

  final Widget child;
  final bool enabled;

  @override
  State<_PressableSurface> createState() => _PressableSurfaceState();
}

class _PressableSurfaceState extends State<_PressableSurface> {
  bool _pressed = false;

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
