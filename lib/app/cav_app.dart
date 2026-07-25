import 'package:flutter/material.dart';

import '../screens/splash_screen.dart';
import 'theme.dart';

/// Configures the application shell, theme, and initial splash route.
class CavApp extends StatelessWidget {
  /// Creates the root application widget.
  const CavApp({super.key});

  /// Builds the Material application using the CAV theme.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Frame & Brew',
      debugShowCheckedModeBanner: false,
      theme: CavTheme.light(),
      home: const SplashScreen(),
    );
  }
}
