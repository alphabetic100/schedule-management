import 'package:go_router/go_router.dart';
import 'package:schedule_management/src/app/features/auth/screens/auth_screen.dart';
import 'package:schedule_management/src/app/features/home/screens/home_screen.dart';
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
      GoRoute(
        path: RouteName.home,
        builder: (context, state) => const HomeScreen(),
      ),

      GoRoute(
        path: RouteName.auth,
        builder: (context, state) => const AuthScreen(),
      ),
    ],
  );
}
