import 'package:flutter/material.dart';

import '../../../core/widgets/feature_placeholder.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Activity')),
      body: const FeaturePlaceholder(
        title: 'Your reports and claims',
        description: 'Your own reports, submitted claims, and their current statuses will be shown here.',
        icon: Icons.history_rounded,
      ),
    );
  }
}
