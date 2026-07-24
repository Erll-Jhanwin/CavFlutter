import 'package:flutter/material.dart';

import '../data/cav_repository.dart';
import 'studio_screen.dart';

/// Shows the event-specific package list using the shared package layout.
class EventsScreen extends StatelessWidget {
  /// Creates the events screen.
  const EventsScreen({super.key});

  /// Builds the configured event package list.
  @override
  Widget build(BuildContext context) {
    return const PackageListScreen(
      title: 'Events',
      subtitle:
          'Photo service booking for events and outdoor photoshoots.',
      packages: CavRepository.eventPackages,
    );
  }
}
