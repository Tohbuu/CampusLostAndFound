import 'package:flutter/material.dart';

import '../../app/theme/app_theme.dart';

class FoundBrand extends StatelessWidget {
  const FoundBrand({super.key, this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onSurface;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: compact ? 36 : 42,
          height: compact ? 36 : 42,
          decoration: BoxDecoration(
            color: AppColors.navy,
            borderRadius: BorderRadius.circular(13),
          ),
          child: const Icon(
            Icons.volunteer_activism_rounded,
            color: AppColors.mint,
            size: 23,
          ),
        ),
        const SizedBox(width: 11),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'FOUND.',
              style: TextStyle(
                color: textColor,
                fontSize: compact ? 17 : 20,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.1,
                height: 1.1,
              ),
            ),
            if (!compact) ...[
              const SizedBox(height: 4),
              const Text(
                'CAMPUS LOST & FOUND',
                style: TextStyle(
                  color: AppColors.muted,
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.15,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
