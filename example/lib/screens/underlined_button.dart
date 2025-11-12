import 'package:example/appbar.dart';
import 'package:example/main.dart';
import 'package:example/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:provider/provider.dart';

class CoconutUnderlinedButtonScreen extends StatelessWidget {
  const CoconutUnderlinedButtonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: SingleChildScrollView(
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            final isDarkMode = themeProvider.themeMode == ThemeMode.dark;
            final brightness = isDarkMode ? Brightness.dark : Brightness.light;

            return SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'State Disabled, default',
                    style: CoconutTypography.heading4_18,
                  ),
                  CoconutUnderlinedButton(
                    brightness: brightness,
                    isActive: false,
                    text: 'UnderlinedButton',
                    onTap: () => showSnackBar(context, 'Underlined Button Clicked!', brightness),
                  ),
                  CoconutLayout.spacing_300h,
                  const Text(
                    'State Enabled, default',
                    style: CoconutTypography.heading4_18,
                  ),
                  CoconutUnderlinedButton(
                    brightness: brightness,
                    text: 'UnderlinedButton',
                    onTap: () => showSnackBar(context, 'Underlined Button Clicked!', brightness),
                  ),
                  CoconutLayout.spacing_300h,
                  const Text(
                    'Custom(lineWidth: 2, color: red)',
                    style: CoconutTypography.heading4_18,
                  ),
                  CoconutUnderlinedButton(
                    brightness: brightness,
                    defaultColor: CoconutColors.red,
                    text: 'UnderlinedButton',
                    lineWidth: 2,
                    onTap: () => showSnackBar(context, 'Underlined Button Clicked!', brightness),
                  ),
                  CoconutLayout.spacing_300h,
                  const Text(
                    'Custom(textStyle: heading1_32_Bold)',
                    style: CoconutTypography.heading4_18,
                  ),
                  CoconutUnderlinedButton(
                    brightness: brightness,
                    textStyle: CoconutTypography.heading1_32_Bold,
                    text: 'UnderlinedButton',
                    onTap: () => showSnackBar(context, 'Underlined Button Clicked!', brightness),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
