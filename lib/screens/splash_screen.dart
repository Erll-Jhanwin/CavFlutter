import 'dart:async';

import 'package:flutter/material.dart';

import '../app/design_tokens.dart';
import '../widgets/cav_logo.dart';
import '../widgets/cav_surface.dart';
import 'main_shell.dart';

/// Displays the branded loading screen before entering the main shell.
class SplashScreen extends StatefulWidget {
  /// Creates the splash screen.
  const SplashScreen({super.key});

  /// Creates the state responsible for the timed transition.
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

/// Manages the splash timer and its cleanup during widget removal.
class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  /// Starts the delayed transition to the main application shell.
  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 2), () {
      // Avoid navigation if the timer fires after the screen was removed.
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(builder: (_) => const MainShell()),
      );
    });
  }

  /// Cancels the transition timer before disposing the state.
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  /// Builds the centered branded splash content and entrance animation.
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(CavSpacing.xl),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - (CavSpacing.xl * 2),
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.94, end: 1),
                      duration: const Duration(milliseconds: 620),
                      curve: Curves.easeOutCubic,
                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value.clamp(0.0, 1.0),
                          child: Transform.scale(scale: value, child: child),
                        );
                      },
                      child: CavSurface(
                        color: CavColors.surface,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const CavLogo(size: 78),
                            const SizedBox(height: CavSpacing.lg),
                            Text(
                              'Frame & Brew',
                              textAlign: TextAlign.center,
                              style: theme.textTheme.headlineSmall,
                            ),
                            const SizedBox(height: CavSpacing.xs),
                            Text(
                              'Photo studio, photo services, and café',
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(height: CavSpacing.lg),
                            SizedBox(
                              width: 38,
                              height: 38,
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                                color: theme.colorScheme.secondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
