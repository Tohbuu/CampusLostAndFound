import 'package:flutter/material.dart';

import '../../../core/widgets/feature_placeholder.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile & Settings')),
      body: const FeaturePlaceholder(
        title: 'Your account',
        description: 'Google sign-in, session management, account details, and role-aware moderator access will be added in the authentication checkpoint.',
        icon: Icons.manage_accounts_outlined,
      ),
    );
  }
}
