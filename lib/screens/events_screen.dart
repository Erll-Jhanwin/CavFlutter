import 'package:flutter/material.dart';

import '../data/cav_repository.dart';
import 'studio_screen.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PackageListScreen(
      title: 'Events',
      subtitle:
          'Coverage packages for celebrations, weddings, and corporate programs.',
      packages: CavRepository.eventPackages,
    );
  }
}
