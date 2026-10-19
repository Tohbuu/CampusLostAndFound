import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/widgets/found_brand.dart';
import '../theme/app_theme.dart';

class AppShell extends StatelessWidget {
  const AppShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  static const _destinations = [
    _Destination(
      label: 'Home',
      icon: Icons.home_outlined,
      selectedIcon: Icons.home_rounded,
      tooltip: 'Home',
    ),
    _Destination(
      label: 'Discover',
      icon: Icons.travel_explore_outlined,
      selectedIcon: Icons.travel_explore_rounded,
      tooltip: 'Discover',
    ),
    _Destination(
      label: 'Report',
      icon: Icons.add_box_outlined,
      selectedIcon: Icons.add_box_rounded,
      tooltip: 'Report',
    ),
    _Destination(
      label: 'My Activity',
      icon: Icons.history_outlined,
      selectedIcon: Icons.history_rounded,
      tooltip: 'My Activity',
    ),
    _Destination(
      label: 'Profile',
      icon: Icons.person_outline_rounded,
      selectedIcon: Icons.person_rounded,
      tooltip: 'Profile & Settings',
    ),
  ];

  void _goToBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = navigationShell.currentIndex;

    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 760;

        if (wide) {
          return Scaffold(
            body: SafeArea(
              child: Row(
                children: [
                  SizedBox(
                    width: 224,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(22, 28, 16, 28),
                          child: FoundBrand(compact: true),
                        ),
                        Expanded(
                          child: NavigationRail(
                            selectedIndex: selectedIndex,
                            onDestinationSelected: _goToBranch,
                            labelType: NavigationRailLabelType.all,
                            minWidth: 76,
                            groupAlignment: -0.7,
                            destinations: _destinations
                                .map(
                                  (destination) => NavigationRailDestination(
                                    icon: Icon(destination.icon),
                                    selectedIcon: Icon(
                                      destination.selectedIcon,
                                    ),
                                    label: Text(destination.label),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            'A little kindness goes a long way.',
                            style: TextStyle(
                              color: AppColors.muted,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const VerticalDivider(width: 1),
                  Expanded(child: navigationShell),
                ],
              ),
            ),
          );
        }

        return Scaffold(
          body: navigationShell,
          bottomNavigationBar: NavigationBar(
            selectedIndex: selectedIndex,
            onDestinationSelected: _goToBranch,
            destinations: _destinations
                .map(
                  (destination) => NavigationDestination(
                    icon: Icon(destination.icon),
                    selectedIcon: Icon(destination.selectedIcon),
                    label: destination.label,
                    tooltip: destination.tooltip,
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}

class _Destination {
  const _Destination({
    required this.label,
    required this.icon,
    required this.selectedIcon,
    required this.tooltip,
  });

  final String label;
  final IconData icon;
  final IconData selectedIcon;
  final String tooltip;
}
