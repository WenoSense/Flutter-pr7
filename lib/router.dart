import 'package:go_router/go_router.dart';
import '../features/payments/state/payments_container.dart';
import '../features/payments/screens/favorites_screen.dart';
import '../features/payments/screens/settings_screen.dart';
import '../features/payments/screens/about_developer_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const PaymentsContainer(),
    ),
    GoRoute(
      path: '/favorites',
      builder: (context, state) => const FavoritesScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/about',
      builder: (context, state) => const AboutDeveloperScreen(),
    ),
  ],
);

