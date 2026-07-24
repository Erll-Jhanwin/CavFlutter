import 'package:flutter/material.dart';

import '../screens/splash_screen.dart';
import 'theme.dart';

class CavApp extends StatelessWidget {
  const CavApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CAV Photo Studio, Events, and Coffee Shop',
      debugShowCheckedModeBanner: false,
      theme: CavTheme.light(),
      home: const SplashScreen(),
    );
  }
}
