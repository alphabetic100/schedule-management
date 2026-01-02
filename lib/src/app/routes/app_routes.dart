import 'package:go_router/go_router.dart';
import 'package:schedule_management/src/app/features/auth/screens/auth_screen.dart';
import 'package:schedule_management/src/app/features/home/screens/home_screen.dart';
import 'package:schedule_management/src/app/features/home/widgets/scaffold_with_nav.dart';
import 'package:schedule_management/src/app/features/schedules/screens/schedule_screen.dart';
import 'package:schedule_management/src/app/features/settings/screens/settings_screen.dart';
import 'package:schedule_management/src/app/features/splash/screens/splash_screen.dart';
import 'package:schedule_management/src/app/routes/route_name.dart';

class AppRoutes {
  static final router = GoRouter(
    initialLocation: RouteName.splash,
    routes: [
      GoRoute(
        path: RouteName.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) => ScaffoldWithNav(child: child),
        routes: [
          GoRoute(
            path: RouteName.home,
            pageBuilder:
                (context, state) => const NoTransitionPage(child: HomeScreen()),
          ),
          GoRoute(
            path: RouteName.schedules,
            pageBuilder:
                (context, state) =>
                    const NoTransitionPage(child: ScheduleScreen()),
          ),
          GoRoute(
            path: RouteName.settings,
            pageBuilder:
                (context, state) =>
                    const NoTransitionPage(child: SettingsScreen()),
          ),
        ],
      ),
      GoRoute(
        path: RouteName.auth,
        builder: (context, state) => const AuthScreen(),
      ),
    ],
  );
}
