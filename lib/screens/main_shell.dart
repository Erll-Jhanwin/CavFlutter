import 'package:flutter/material.dart';

import '../app/design_tokens.dart';

import 'about_screen.dart';
import 'coffee_screen.dart';
import 'events_screen.dart';
import 'home_screen.dart';
import 'studio_screen.dart';

/// Hosts the primary application destinations and bottom navigation.
class MainShell extends StatefulWidget {
  /// Creates the stateful destination shell.
  const MainShell({super.key});

  /// Creates the state that tracks the selected destination.
  @override
  State<MainShell> createState() => _MainShellState();
}

/// Maintains the active page while preserving each page in an [IndexedStack].
class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;

  late final List<Widget> _pages = [
    // Keep destination state alive while switching navigation tabs.
    HomeScreen(onNavigate: _selectPage),
    const StudioScreen(),
    const EventsScreen(),
    const CoffeeScreen(),
    const AboutScreen(),
  ];

  /// Selects the destination at [index] and rebuilds the navigation shell.
  void _selectPage(int index) {
    setState(() => _selectedIndex = index);
  }

  /// Builds the current destination and persistent bottom navigation bar.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: CavColors.surface,
          border: Border(
            top: BorderSide(color: CavColors.line.withValues(alpha: 0.76)),
          ),
          boxShadow: CavShadows.soft(CavColors.secondary),
        ),
        child: SafeArea(
          top: false,
          child: NavigationBar(
            selectedIndex: _selectedIndex,
            onDestinationSelected: _selectPage,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.photo_camera_outlined),
                selectedIcon: Icon(Icons.photo_camera),
                label: 'Studio',
              ),
              NavigationDestination(
                icon: Icon(Icons.event_outlined),
                selectedIcon: Icon(Icons.event),
                label: 'Events',
              ),
              NavigationDestination(
                icon: Icon(Icons.local_cafe_outlined),
                selectedIcon: Icon(Icons.local_cafe),
                label: 'Café',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline),
                selectedIcon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
