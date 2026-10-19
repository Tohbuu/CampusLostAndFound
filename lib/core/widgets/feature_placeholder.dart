import 'package:flutter/material.dart';

class FeaturePlaceholder extends StatelessWidget {
  const FeaturePlaceholder({
    required this.title,
    required this.description,
    required this.icon,
    super.key,
  });

  final String title;
  final String description;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 76,
                height: 76,
                decoration: BoxDecoration(
                  color: colors.primaryContainer,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Icon(icon, size: 36, color: colors.primary),
              ),
              const SizedBox(height: 24),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 12),
              Text(
                description,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge
                    ?.copyWith(color: colors.onSurfaceVariant, height: 1.5),
              ),
              const SizedBox(height: 22),
              const Chip(
                avatar: Icon(Icons.construction_rounded, size: 17),
                label: Text('Coming in a later checkpoint'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
