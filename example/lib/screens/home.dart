import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:example/appbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:example/provider/theme_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context);
    final List<GoRoute> routes = router.configuration.routes
        .whereType<GoRoute>()
        .toList()
        .where((route) => route.path != '/')
        .toList();

    return Scaffold(
      appBar: const MyAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            final isDarkMode = themeProvider.themeMode == ThemeMode.dark;
            final theme = isDarkMode
                ? CoconutThemeData.darkTheme
                : CoconutThemeData.lightTheme;

            return ListView.separated(
              itemCount: routes.length,
              separatorBuilder: (context, index) => Divider(
                color: theme.dividerColor,
              ),
              itemBuilder: (context, index) {
                final route = routes[index];

                return ListTile(
                  title: Text(
                    route.path.replaceAll('/', ''),
                    style: CoconutTypography.body1Bold,
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  ),
                  onTap: () {
                    context.push(route.path);
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
