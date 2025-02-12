import 'package:example/appbar.dart';
import 'package:example/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:provider/provider.dart';

class RadiusScreen extends StatelessWidget {
  const RadiusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: SingleChildScrollView(
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            Map<String, double> radiusMap = {
              'CoconutStyles.radius_500': CoconutStyles.radius_500,
              'CoconutStyles.radius_400': CoconutStyles.radius_400,
              'CoconutStyles.radius_300': CoconutStyles.radius_300,
              'CoconutStyles.radius_200': CoconutStyles.radius_200,
              'CoconutStyles.radius_100': CoconutStyles.radius_100,
            };

            return Center(
              child: Column(
                children: [
                  for (var entry in radiusMap.entries) ...[
                    Text(
                      entry.key,
                      style: CoconutTypography.body1_16_Bold,
                    ),
                    CoconutLayout.spacing_200h,
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: CoconutColors.gray500,
                        ),
                        borderRadius: BorderRadius.circular(
                          entry.value.toDouble(),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            bottom: 0,
                            child: Container(
                              width: entry.value * 2,
                              height: entry.value * 2,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: CoconutColors.pink,
                                ),
                                borderRadius: BorderRadius.circular(
                                  entry.value.toDouble(),
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              entry.value.toString(),
                              style: CoconutTypography.body2_14_Bold.setColor(
                                CoconutColors.pink,
                              ),
                            ),
                          ),
                        ],
                      ),
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
