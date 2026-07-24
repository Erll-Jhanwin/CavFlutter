import 'package:flutter/material.dart';

import '../app/design_tokens.dart';

import 'about_screen.dart';
import 'coffee_screen.dart';
import 'events_screen.dart';
import 'home_screen.dart';
import 'studio_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;

  late final List<Widget> _pages = [
    HomeScreen(onNavigate: _selectPage),
    const StudioScreen(),
    const EventsScreen(),
    const CoffeeScreen(),
    const AboutScreen(),
  ];

  void _selectPage(int index) {
    setState(() => _selectedIndex = index);
  }

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
                label: 'Coffee',
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
