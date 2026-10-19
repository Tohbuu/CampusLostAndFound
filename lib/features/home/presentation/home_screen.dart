import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_theme.dart';
import '../../../core/widgets/found_brand.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const FoundBrand(compact: true),
        actions: [
          IconButton(
            tooltip: 'Profile & Settings',
            onPressed: () => context.go('/profile'),
            icon: const Icon(Icons.account_circle_outlined),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 980),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(22, 18, 22, 36),
              children: [
                Text(
                  'A little kindness,\na big difference.',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                    height: 1.12,
                    letterSpacing: -0.7,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Lost something on campus? Found something that belongs to someone else? Let’s help it find its way home.',
                  style: Theme.of(context).textTheme.bodyLarge
                      ?.copyWith(color: colors.onSurfaceVariant, height: 1.5),
                ),
                const SizedBox(height: 26),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.navy,
                    borderRadius: BorderRadius.circular(26),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppColors.navy, AppColors.navyDark],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.mint.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.favorite_rounded,
                          color: AppColors.mint,
                          size: 25,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Find it. Report it. Return it.',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 9),
                      Text(
                        'Every report brings a missing item one step closer to its owner.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withValues(alpha: 0.82),
                          height: 1.45,
                        ),
                      ),
                      const SizedBox(height: 22),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          FilledButton.icon(
                            onPressed: () => context.go('/discover'),
                            style: FilledButton.styleFrom(
                              backgroundColor: AppColors.mint,
                              foregroundColor: AppColors.navyDark,
                            ),
                            icon: const Icon(Icons.search_rounded),
                            label: const Text('Explore reports'),
                          ),
                          OutlinedButton.icon(
                            onPressed: () => context.go('/report'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              side: BorderSide(
                                color: Colors.white.withValues(alpha: 0.55),
                              ),
                            ),
                            icon: const Icon(Icons.add_rounded),
                            label: const Text('Report an item'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                Text(
                  'Your campus, together',
                  style: Theme.of(context).textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 14),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _ValueCard(
                        icon: Icons.search_rounded,
                        title: 'Discover',
                        description: 'Look through reported items.',
                        tint: colors.primaryContainer,
                        onTap: () => context.go('/discover'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _ValueCard(
                        icon: Icons.volunteer_activism_rounded,
                        title: 'Give back',
                        description: 'Help an item find its owner.',
                        tint: colors.secondaryContainer,
                        onTap: () => context.go('/report'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: AppColors.sand.withValues(
                      alpha: colors.brightness == Brightness.dark ? 0.12 : 1,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.shield_outlined, size: 24),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Your privacy matters',
                              style: TextStyle(fontWeight: FontWeight.w800),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Claim details will be kept separate from public item reports.',
                              style: TextStyle(height: 1.4),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ValueCard extends StatelessWidget {
  const _ValueCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.tint,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String description;
  final Color tint;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: tint,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(icon),
              ),
              const SizedBox(height: 15),
              Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
              const SizedBox(height: 6),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
