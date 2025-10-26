import 'package:go_router/go_router.dart';
import 'features/payments/screens/payments_list_screen.dart';
import 'features/payments/screens/payment_form_screen.dart';
import 'features/payments/screens/favorites_screen.dart';
import 'features/payments/screens/settings_screen.dart';
import 'features/payments/screens/about_developer_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const PaymentsListScreen(),
    ),
    GoRoute(
      path: '/add',
      builder: (context, state) => const PaymentFormScreen(),
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
