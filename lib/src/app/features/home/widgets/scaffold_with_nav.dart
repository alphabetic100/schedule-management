import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:schedule_management/src/app/features/home/widgets/custom_bottom_navbar.dart';
import 'package:schedule_management/src/app/routes/route_name.dart';

class ScaffoldWithNav extends StatelessWidget {
  final Widget child;

  const ScaffoldWithNav({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: CustomBottomNavbar(
        currentIndex: _calculateSelectedIndex(context),
        onTap: (index) => _onItemTapped(index, context),
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith(RouteName.home)) {
      return 0;
    }
    if (location.startsWith(RouteName.schedules)) {
      return 1;
    }
    if (location.startsWith(RouteName.settings)) {
      return 2;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go(RouteName.home);
      case 1:
        context.go(RouteName.schedules);
      case 2:
        context.go(RouteName.settings);
    }
  }
}
