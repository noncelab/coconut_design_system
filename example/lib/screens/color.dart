import 'package:example/appbar.dart';
import 'package:example/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:provider/provider.dart';

class ColorScreen extends StatelessWidget {
  const ColorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: SingleChildScrollView(
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            final isDarkMode = themeProvider.themeMode == ThemeMode.dark;
            final brightness = isDarkMode ? Brightness.dark : Brightness.light;

            final colorMap = {
              'Primary': CoconutColors.primary,
              'OnPrimary': CoconutColors.onPrimary(brightness),
              'Surface': CoconutColors.surface(brightness),
              'Black': CoconutColors.black,
              'White': CoconutColors.white,
              'Gray100': CoconutColors.gray100,
              'Gray150': CoconutColors.gray150,
              'Gray200': CoconutColors.gray200,
              'Gray300': CoconutColors.gray300,
              'Gray350': CoconutColors.gray350,
              'Gray400': CoconutColors.gray400,
              'Gray500': CoconutColors.gray500,
              'Gray600': CoconutColors.gray600,
              'Gray700': CoconutColors.gray700,
              'Gray800': CoconutColors.gray800,
              'Gray900': CoconutColors.gray900,
              'HotPink': CoconutColors.hotPink,
              'HotPink150': CoconutColors.hotPink150,
              'Cyan': CoconutColors.cyan,
              'Purple': CoconutColors.purple,
              'Tangerine': CoconutColors.tangerine,
              'Yellow': CoconutColors.yellow,
              'Green': CoconutColors.green,
              'Sky': CoconutColors.sky,
              'Pink': CoconutColors.pink,
              'Red': CoconutColors.red,
              'Orange': CoconutColors.orange,
              'Mint': CoconutColors.mint,
            };

            const colorPalette = CoconutColors.colorPalette;
            for (int i = 0; i < colorPalette.length; i++) {
              colorMap['ColorPalette $i'] = colorPalette[i];
            }

            final backgroundPalette = isDarkMode
                ? CoconutColors.backgroundColorPaletteDark
                : CoconutColors.backgroundColorPaletteLight;
            for (int i = 0; i < backgroundPalette.length; i++) {
              colorMap['BackgroundPalette $i'] = backgroundPalette[i];
            }

            return Column(
              children: colorMap.entries.map((entry) {
                return _colorBox(entry.value, entry.key, brightness);
              }).toList(),
            );
          },
        ),
      ),
    );
  }

  Widget _colorBox(Color color, String name, Brightness brightness) {
    Color? displayColor;
    if (brightness == Brightness.light && color == CoconutColors.black) {
      displayColor = CoconutColors.white;
    } else if (brightness == Brightness.dark && color == CoconutColors.white) {
      displayColor = CoconutColors.black;
    } else {
      displayColor = null;
    }

    return Container(
      color: color,
      child: Center(
        child: Text(
          name,
          style: CoconutTypography.body2_14_Bold.merge(
            TextStyle(
              color: displayColor,
            ),
          ),
        ),
      ),
    );
  }
}
