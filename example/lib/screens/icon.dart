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
            final backgroundColors =
                isDarkMode ? CoconutColors.backgroundColorPaletteDark : CoconutColors.backgroundColorPaletteLight;
            List<double> iconSizeList = [20, 24, 30];

            return Center(
              child: Column(
                children: [
                  for (int sizeIndex = 0; sizeIndex < iconSizeList.length; sizeIndex++) ...[
                    Text(
                      'IconSize: ${iconSizeList[sizeIndex]} x ${iconSizeList[sizeIndex]} (${iconSizeList[sizeIndex] / 2} x ${iconSizeList[sizeIndex] / 2})',
                      style: CoconutTypography.heading4_18_Bold,
                    ),
                    Text(
                      'Padding: ${iconSizeList[sizeIndex] / 4} (${iconSizeList[sizeIndex]} / 4)',
                      style: CoconutTypography.body1_16,
                    ),
                    Text(
                      'Radius: ${iconSizeList[sizeIndex] / 3} (${iconSizeList[sizeIndex]} / 3)',
                      style: CoconutTypography.body1_16,
                    ),
                    const Text(
                      'SVG',
                      style: CoconutTypography.body2_14,
                    ),
                    buildIconRow(
                      backgroundColors,
                      iconSizeList[sizeIndex],
                      (color, i) => SvgPicture.network(
                        'https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/android.svg',
                        colorFilter: ColorFilter.mode(
                          CoconutColors.colorPalette[i],
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    CoconutLayout.spacing_200h,
                    const Text(
                      'Image',
                      style: CoconutTypography.body2_14,
                    ),
                    buildIconRow(
                      backgroundColors,
                      iconSizeList[sizeIndex],
                      (color, i) => Image.network(
                        'https://picsum.photos/200',
                        color: CoconutColors.colorPalette[i],
                      ),
                    ),
                    CoconutLayout.spacing_200h,
                    const Text(
                      'Icon',
                      style: CoconutTypography.body2_14,
                    ),
                    buildIconRow(
                      backgroundColors,
                      iconSizeList[sizeIndex],
                      (color, i) => Icon(
                        Icons.arrow_forward,
                        size: iconSizeList[sizeIndex] / 2,
                        color: CoconutColors.colorPalette[i],
                      ),
                    ),
                    CoconutLayout.spacing_500h,
                    const Divider(
                      height: 2,
                      color: CoconutColors.gray500,
                    ),
                    CoconutLayout.spacing_500h,
                  ],
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
    double size,
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
                size: size,
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
