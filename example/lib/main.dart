import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:example/provider/appbar_provider.dart';
import 'package:example/screens/appbar.dart';
import 'package:example/screens/button.dart';
import 'package:example/screens/color.dart';
import 'package:example/screens/home.dart';
import 'package:example/screens/icon.dart';
import 'package:example/screens/indicator.dart';
import 'package:example/screens/inputs.dart';
import 'package:example/screens/layout.dart';
import 'package:example/screens/overlays.dart';
import 'package:example/screens/radius.dart';
import 'package:example/screens/segmented_control.dart';
import 'package:example/screens/typography.dart';
import 'package:example/screens/underlined_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:example/provider/theme_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppbarProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
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
    GoRoute(
      name: 'icon',
      path: '/icon',
      builder: (context, state) => const IconScreen(),
    ),
    GoRoute(
      name: 'radius',
      path: '/radius',
      builder: (context, state) => const RadiusScreen(),
    ),
    GoRoute(
      name: 'button',
      path: '/button',
      builder: (context, state) => const ButtonScreen(),
    ),
    GoRoute(
      name: 'underlined button',
      path: '/underlined_button',
      builder: (context, state) => const CoconutUnderlinedButtonScreen(),
    ),
    GoRoute(
      name: 'inputs',
      path: '/inputs',
      builder: (context, state) => const InputsScreen(),
    ),
    GoRoute(
      name: 'appbar',
      path: '/appbar',
      builder: (context, state) => const AppbarScreen(),
    ),
    GoRoute(
      name: 'segmented control',
      path: '/segmented_control',
      builder: (context, state) => const SegmentedConrolScreen(),
    ),
    GoRoute(
      name: 'indicator',
      path: '/indicator',
      builder: (context, state) => const IndicatorScreen(),
    ),
    GoRoute(
      name: 'overlays',
      path: '/overlays',
      builder: (context, state) => const OverlaysScreen(),
    ),
  ],
);

void showSnackBar(BuildContext context, String message, Brightness brightness) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      backgroundColor: CoconutColors.onPrimary(brightness),
    ),
  );
}
