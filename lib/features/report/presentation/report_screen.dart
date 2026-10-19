import 'package:flutter/material.dart';

import '../../../core/widgets/feature_placeholder.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Report an item')),
      body: const FeaturePlaceholder(
        title: 'Help an item find its way home',
        description: 'The lost and found report form will be added with validation, photo handling, and secure report storage.',
        icon: Icons.add_a_photo_outlined,
      ),
    );
  }
}
