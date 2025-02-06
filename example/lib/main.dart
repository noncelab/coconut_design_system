import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:example/screens/color.dart';
import 'package:example/screens/home.dart';
import 'package:example/screens/layout.dart';
import 'package:example/screens/typography.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:example/provider/theme_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Coconut Design System',
      theme: CoconutThemeData.lightTheme,
      darkTheme: CoconutThemeData.darkTheme,
      themeMode: themeProvider.themeMode,
      routerConfig: _router,
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: 'home',
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      name: 'typography',
      path: '/typography',
      builder: (context, state) => const TypographyScreen(),
    ),
    GoRoute(
      name: 'color',
      path: '/color',
      builder: (context, state) => const ColorScreen(),
    ),
    GoRoute(
      name: 'layout',
      path: '/layout',
      builder: (context, state) => const LayoutScreen(),
    ),
  ],
);
