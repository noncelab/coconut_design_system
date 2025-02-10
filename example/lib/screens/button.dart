import 'package:example/appbar.dart';
import 'package:example/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:provider/provider.dart';

class ButtonScreen extends StatelessWidget {
  const ButtonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: SingleChildScrollView(
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            final isDarkMode = themeProvider.themeMode == ThemeMode.dark;
            final brightness = isDarkMode ? Brightness.dark : Brightness.light;

            return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: CoconutLayout.defaultPadding),
              child: Center(
                child: Column(
                  children: [
                    _titleBox('Less width default Button', brightness),
                    _buttonBox(
                      'filled / disabled',
                      brightness,
                      CoconutButton(
                        brightness: brightness,
                        text: 'button',
                        onPressed: () => debugPrint('button Pressed!'),
                      ),
                    ),
                    _buttonBox(
                      'outlined / disabled',
                      brightness,
                      CoconutButton(
                        brightness: brightness,
                        text: 'button',
                        buttonType: CoconutButtonType.outlined,
                        onPressed: () => debugPrint('button Pressed!'),
                      ),
                    ),
                    _buttonBox(
                      'none / disabled',
                      brightness,
                      CoconutButton(
                        brightness: brightness,
                        text: 'button',
                        buttonType: CoconutButtonType.none,
                        onPressed: () => debugPrint('button Pressed!'),
                      ),
                    ),
                    _buttonBox(
                      'custom color & vibrate / disabled',
                      brightness,
                      CoconutButton(
                        brightness: brightness,
                        text: 'button',
                        backgroundColor: CoconutColors.primary,
                        foregroundColor: CoconutColors.black,
                        pressedTextColor: CoconutColors.black,
                        buttonType: CoconutButtonType.filled,
                        onPressed: () => debugPrint('button Pressed!'),
                      ),
                    ),
                    _titleBox('150 width default Button', brightness),
                    CoconutButton(
                      brightness: brightness,
                      text: 'button',
                      width: 150,
                      onPressed: () => debugPrint('button Pressed!'),
                    ),
                    _titleBox('Wide default Button', brightness),
                    CoconutButton(
                      brightness: brightness,
                      text: 'button',
                      isExpand: true,
                      onPressed: () => debugPrint('button Pressed!'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _titleBox(String title, Brightness brightness) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CoconutLayout.spacing_1000h,
        Text(
          title,
          style: CoconutTypography.body1_16_Bold.setColor(
            CoconutColors.onPrimary(brightness),
          ),
        ),
        CoconutLayout.spacing_300h,
      ],
    );
  }

  Widget _buttonBox(
    String subtitle,
    Brightness brightness,
    CoconutButton child,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(subtitle),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            child,
            CoconutLayout.spacing_200w,
            child.copyWith(
              isActive: false,
            )
          ],
        )
      ],
    );
  }
}
