import 'package:example/screens/home.dart';
import 'package:example/screens/typography.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/typography',
      builder: (context, state) => const TypographyScreen(),
    ),
  ],
);
