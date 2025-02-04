// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// **CoconutApp Type Enum**
///
/// Defines the different types of applications that can be created using `CoconutApp`.
enum CoconutAppType {
  /// A default application using the **CoconutTheme**.
  coconut,

  /// A wrapper around **MaterialApp**.
  material,

  /// A wrapper around **CupertinoApp**.
  cupertino,

  /// A customizable application with a user-defined builder.
  custom,
}

/// **CoconutApp - A Versatile Application Wrapper**
///
/// This class provides an application wrapper supporting **Material**, **Cupertino**, and **custom** themes.
/// It helps in managing routes, themes, localization, and scroll behaviors.
class CoconutApp extends StatefulWidget {
  /// **Creates a Coconut-themed application.**
  const CoconutApp({
    super.key,
    this.navigatorKey,
    this.onGenerateRoute,
    this.onGenerateInitialRoutes,
    this.onUnknownRoute,
    this.navigatorObservers = const <NavigatorObserver>[],
    this.initialRoute,
    this.home,
    this.routes = const <String, WidgetBuilder>{},
    this.title = '',
    this.onGenerateTitle,
    this.color,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.showPerformanceOverlay = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.actions,
    this.theme,
    this.darkTheme,
    this.themeMode,
    this.restorationScopeId,
    this.scrollBehavior = const CoconutScrollBehavior(),
    this.routeInformationProvider,
    this.routeInformationParser,
    this.routerDelegate,
    this.backButtonDispatcher,
    this.appBuilder,
  }) : type = CoconutAppType.coconut;

  /// **Creates a Material-themed application.**
  const CoconutApp.material({
    super.key,
    this.navigatorKey,
    this.onGenerateRoute,
    this.onGenerateInitialRoutes,
    this.onUnknownRoute,
    this.navigatorObservers = const <NavigatorObserver>[],
    this.initialRoute,
    this.home,
    this.routes = const <String, WidgetBuilder>{},
    this.title = '',
    this.onGenerateTitle,
    this.color,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.showPerformanceOverlay = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.actions,
    this.theme,
    this.darkTheme,
    this.themeMode,
    this.restorationScopeId,
    this.scrollBehavior = const MaterialScrollBehavior(),
    this.routeInformationProvider,
    this.routeInformationParser,
    this.routerDelegate,
    this.backButtonDispatcher,
    this.appBuilder,
  }) : type = CoconutAppType.material;

  /// **Creates a Cupertino-themed application.**
  const CoconutApp.cupertino({
    super.key,
    this.navigatorKey,
    this.onGenerateRoute,
    this.onGenerateInitialRoutes,
    this.onUnknownRoute,
    this.navigatorObservers = const <NavigatorObserver>[],
    this.initialRoute,
    this.home,
    this.routes = const <String, WidgetBuilder>{},
    this.title = '',
    this.onGenerateTitle,
    this.color,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.showPerformanceOverlay = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.actions,
    this.theme,
    this.darkTheme,
    this.themeMode,
    this.restorationScopeId,
    this.scrollBehavior = const CupertinoScrollBehavior(),
    this.routeInformationProvider,
    this.routeInformationParser,
    this.routerDelegate,
    this.backButtonDispatcher,
    this.appBuilder,
  }) : type = CoconutAppType.cupertino;

  /// **Creates a custom application using a user-defined builder.**
  const CoconutApp.custom({
    super.key,
    required this.appBuilder,
    this.theme,
    this.darkTheme,
    this.themeMode,
    this.navigatorKey,
    this.home,
    this.routes,
    this.initialRoute,
    this.onGenerateRoute,
    this.onGenerateInitialRoutes,
    this.onUnknownRoute,
    this.navigatorObservers,
    this.routeInformationProvider,
    this.routeInformationParser,
    this.routerDelegate,
    this.backButtonDispatcher,
    this.restorationScopeId,
    this.localizationsDelegates,
    required this.supportedLocales,
    this.locale,
    this.localeResolutionCallback,
    this.localeListResolutionCallback,
    required this.title,
    this.onGenerateTitle,
    this.color,
    this.shortcuts,
    this.actions,
    required this.showPerformanceOverlay,
    required this.showSemanticsDebugger,
    required this.debugShowCheckedModeBanner,
    required this.scrollBehavior,
  }) : type = CoconutAppType.custom;

  final CoconutAppType type;
  final ThemeData? theme;
  final ThemeData? darkTheme;
  final ThemeMode? themeMode;
  final GlobalKey<NavigatorState>? navigatorKey;
  final Widget? home;
  final Map<String, WidgetBuilder>? routes;
  final String? initialRoute;
  final RouteFactory? onGenerateRoute;
  final InitialRouteListFactory? onGenerateInitialRoutes;
  final RouteFactory? onUnknownRoute;
  final List<NavigatorObserver>? navigatorObservers;
  final RouteInformationProvider? routeInformationProvider;
  final RouteInformationParser<Object>? routeInformationParser;
  final RouterDelegate<Object>? routerDelegate;
  final BackButtonDispatcher? backButtonDispatcher;
  final String? restorationScopeId;
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final Iterable<Locale> supportedLocales;
  final Locale? locale;
  final LocaleResolutionCallback? localeResolutionCallback;
  final LocaleListResolutionCallback? localeListResolutionCallback;
  final String title;
  final GenerateAppTitle? onGenerateTitle;
  final Color? color;
  final Map<ShortcutActivator, Intent>? shortcuts;
  final Map<Type, Action<Intent>>? actions;
  final bool showPerformanceOverlay;
  final bool showSemanticsDebugger;
  final bool debugShowCheckedModeBanner;
  final ScrollBehavior scrollBehavior;
  final Widget Function(BuildContext context, ThemeData theme)? appBuilder;

  @override
  State<CoconutApp> createState() => _CoconutAppState();
}

class _CoconutAppState extends State<CoconutApp> {
  final heroController = HeroController();

  @override
  void dispose() {
    heroController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: widget.scrollBehavior,
      child: HeroControllerScope(
        controller: heroController,
        child: _buildApp(context),
      ),
    );
  }

  ThemeData _theme(BuildContext context) {
    return widget.theme ?? ThemeData.light();
  }

  ThemeData _darkTheme(BuildContext context) {
    return widget.darkTheme ?? ThemeData.dark();
  }

  Widget _buildApp(BuildContext context) {
    switch (widget.type) {
      case CoconutAppType.coconut:
        return MaterialApp(
          navigatorKey: widget.navigatorKey,
          navigatorObservers: widget.navigatorObservers!,
          home: widget.home,
          routes: widget.routes!,
          initialRoute: widget.initialRoute,
          onGenerateRoute: widget.onGenerateRoute,
          onGenerateInitialRoutes: widget.onGenerateInitialRoutes,
          onUnknownRoute: widget.onUnknownRoute,
          title: widget.title,
          theme: _theme(context),
          darkTheme: _darkTheme(context),
          themeMode: widget.themeMode,
          debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
        );

      case CoconutAppType.material:
        return MaterialApp(
          navigatorKey: widget.navigatorKey,
          theme: _theme(context),
          darkTheme: _darkTheme(context),
          themeMode: widget.themeMode,
          home: widget.home,
          routes: widget.routes!,
        );

      case CoconutAppType.cupertino:
        return CupertinoApp(
          navigatorKey: widget.navigatorKey,
          theme: CupertinoThemeData(
            brightness: widget.themeMode == ThemeMode.dark
                ? Brightness.dark
                : Brightness.light,
          ),
          home: widget.home,
          routes: widget.routes!,
        );

      case CoconutAppType.custom:
        return Builder(
          builder: (context) {
            return widget.appBuilder!(context, Theme.of(context));
          },
        );
    }
  }
}

/// **CoconutScrollBehavior - Custom Scroll Behavior for CoconutApp**
///
/// This class extends `MaterialScrollBehavior` to define a **custom scroll experience**.
/// It ensures that different platforms (**iOS, Android, Web, and Desktop**) get the appropriate scroll behavior,
/// including **scrollbars** and **touch gestures**.
class CoconutScrollBehavior extends MaterialScrollBehavior {
  /// **Creates a Coconut Scroll Behavior instance.**
  ///
  /// - Defaults to **MaterialScrollBehavior**.
  /// - Adds platform-specific **scroll indicators** where necessary.
  const CoconutScrollBehavior();

  @override
  Widget buildScrollbar(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    switch (axisDirectionToAxis(details.direction)) {
      case Axis.horizontal:
        return child; // No scrollbar for horizontal scrolling.

      case Axis.vertical:
        switch (getPlatform(context)) {
          case TargetPlatform.macOS:
          case TargetPlatform.iOS:
            // Uses Cupertino-style scrollbar for Apple devices.
            return CupertinoScrollbar(
              controller: details.controller,
              child: child,
            );

          case TargetPlatform.linux:
          case TargetPlatform.windows:
            // Uses a standard Material scrollbar for Desktop platforms.
            return Scrollbar(
              controller: details.controller,
              child: child,
            );

          case TargetPlatform.android:
          case TargetPlatform.fuchsia:
            // No scrollbar for Android/Fuchsia platforms (default behavior).
            return child;
        }
    }
  }
}
