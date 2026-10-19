import 'package:flutter/material.dart';

import '../../../core/widgets/feature_placeholder.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Discover')),
      body: const FeaturePlaceholder(
        title: 'Find items around campus',
        description: 'Search and filter lost and found reports. Live reports will appear here after Firebase integration.',
        icon: Icons.travel_explore_rounded,
      ),
    );
  }
}
