import 'package:example/appbar.dart';
import 'package:example/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class IconScreen extends StatelessWidget {
  const IconScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: SingleChildScrollView(
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            final isDarkMode = themeProvider.themeMode == ThemeMode.dark;
            final backgroundColors = isDarkMode
                ? CoconutColors.backgroundColorPaletteDark
                : CoconutColors.backgroundColorPaletteLight;

            return Center(
              child: Column(
                children: [
                  buildIconRow(
                    backgroundColors,
                    (color, i) => SvgPicture.network(
                      'https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/android.svg',
                      colorFilter: ColorFilter.mode(
                        CoconutColors.colorPalette[i],
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  CoconutLayout.spacing_1000h,
                  buildIconRow(
                    backgroundColors,
                    (color, i) => Image.network(
                      'https://picsum.photos/200',
                      color: CoconutColors.colorPalette[i],
                    ),
                  ),
                  CoconutLayout.spacing_1000h,
                  buildIconRow(
                    backgroundColors,
                    (color, i) => Icon(
                      Icons.arrow_forward,
                      color: CoconutColors.colorPalette[i],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildIconRow(
    List<Color> backgroundColors,
    Widget Function(Color color, int index) iconBuilder,
  ) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          backgroundColors.length,
          (i) => Row(
            children: [
              CoconutIcon(
                size: 40,
                backgroundColor: backgroundColors[i],
                child: iconBuilder(backgroundColors[i], i),
              ),
              CoconutLayout.spacing_200w,
            ],
          ),
        ),
      ),
    );
  }
}
