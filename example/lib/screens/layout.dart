import 'package:example/appbar.dart';
import 'package:example/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:provider/provider.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: SingleChildScrollView(
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            final isDarkMode = themeProvider.themeMode == ThemeMode.dark;
            final brightness = isDarkMode ? Brightness.dark : Brightness.light;
            final spacingMap = {
              'spacing_50h': {'type': CoconutLayout.spacing_50h, 'value': 2.0},
              'spacing_100h': {
                'type': CoconutLayout.spacing_100h,
                'value': 4.0
              },
              'spacing_200h': {
                'type': CoconutLayout.spacing_200h,
                'value': 8.0
              },
              'spacing_300h': {
                'type': CoconutLayout.spacing_300h,
                'value': 12.0
              },
              'spacing_400h': {
                'type': CoconutLayout.spacing_400h,
                'value': 16.0
              },
              'spacing_500h': {
                'type': CoconutLayout.spacing_500h,
                'value': 20.0
              },
              'spacing_600h': {
                'type': CoconutLayout.spacing_600h,
                'value': 24.0
              },
              'spacing_700h': {
                'type': CoconutLayout.spacing_700h,
                'value': 28.0
              },
              'spacing_800h': {
                'type': CoconutLayout.spacing_800h,
                'value': 32.0
              },
              'spacing_900h': {
                'type': CoconutLayout.spacing_900h,
                'value': 36.0
              },
              'spacing_1000h': {
                'type': CoconutLayout.spacing_1000h,
                'value': 40.0
              },
              'spacing_1100h': {
                'type': CoconutLayout.spacing_1100h,
                'value': 44.0
              },
              'spacing_1200h': {
                'type': CoconutLayout.spacing_1200h,
                'value': 48.0
              },
              'spacing_1300h': {
                'type': CoconutLayout.spacing_1300h,
                'value': 52.0
              },
              'spacing_1400h': {
                'type': CoconutLayout.spacing_1400h,
                'value': 56.0
              },
              'spacing_1500h': {
                'type': CoconutLayout.spacing_1500h,
                'value': 60.0
              },
              'spacing_50w': {'type': CoconutLayout.spacing_50w, 'value': 2.0},
              'spacing_100w': {
                'type': CoconutLayout.spacing_100w,
                'value': 4.0
              },
              'spacing_200w': {
                'type': CoconutLayout.spacing_200w,
                'value': 8.0
              },
              'spacing_300w': {
                'type': CoconutLayout.spacing_300w,
                'value': 12.0
              },
              'spacing_400w': {
                'type': CoconutLayout.spacing_400w,
                'value': 16.0
              },
              'spacing_500w': {
                'type': CoconutLayout.spacing_500w,
                'value': 20.0
              },
              'spacing_600w': {
                'type': CoconutLayout.spacing_600w,
                'value': 24.0
              },
              'spacing_700w': {
                'type': CoconutLayout.spacing_700w,
                'value': 28.0
              },
              'spacing_800w': {
                'type': CoconutLayout.spacing_800w,
                'value': 32.0
              },
              'spacing_900w': {
                'type': CoconutLayout.spacing_900w,
                'value': 36.0
              },
              'spacing_1000w': {
                'type': CoconutLayout.spacing_1000w,
                'value': 40.0
              },
              'spacing_1100w': {
                'type': CoconutLayout.spacing_1100w,
                'value': 44.0
              },
              'spacing_1200w': {
                'type': CoconutLayout.spacing_1200w,
                'value': 48.0
              },
              'spacing_1300w': {
                'type': CoconutLayout.spacing_1300w,
                'value': 52.0
              },
              'spacing_1400w': {
                'type': CoconutLayout.spacing_1400w,
                'value': 56.0
              },
              'spacing_1500w': {
                'type': CoconutLayout.spacing_1500w,
                'value': 60.0
              },
            };

            return Column(
              children: [
                Row(
                  children: [
                    _guideLine(width: CoconutLayout.defaultPadding),
                    const Expanded(
                      child: Text(
                          textAlign: TextAlign.center,
                          'defaultPadding: ${CoconutLayout.defaultPadding}'),
                    ),
                    _guideLine(width: CoconutLayout.defaultPadding),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: CoconutLayout.defaultPadding,
                  ),
                  child: Container(
                    width: MediaQuery.sizeOf(context).width,
                    color: CoconutColors.onPrimary(brightness),
                    padding: const EdgeInsets.symmetric(
                        vertical: CoconutLayout.defaultPadding),
                    child: Column(
                      children: spacingMap.entries.map((entry) {
                        return _spacingBox(entry.value, entry.key, brightness);
                      }).toList(),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _guideLine({
    double width = 0,
    double height = 0,
  }) {
    if (width != 0) {
      return SizedBox(
        width: width,
        child: Row(
          children: [
            Container(
              width: 0.5,
              height: Sizes.size16,
              color: CoconutColors.red,
            ),
            Expanded(
              child: Container(
                height: 0.5,
                color: CoconutColors.red,
              ),
            ),
            Container(
              width: 0.5,
              height: Sizes.size16,
              color: CoconutColors.red,
            )
          ],
        ),
      );
    }
    return SizedBox(
      height: height,
      child: Column(
        children: [
          Container(
            height: 0.5,
            width: Sizes.size16,
            color: CoconutColors.red,
          ),
          Expanded(
            child: Container(
              width: 0.5,
              color: CoconutColors.red,
            ),
          ),
          Container(
            height: 0.5,
            width: Sizes.size16,
            color: CoconutColors.red,
          )
        ],
      ),
    );
  }

  Widget _spacingBox(
    Map<String, dynamic> valueMap,
    String name,
    Brightness brightness,
  ) {
    final isVertical = name.endsWith('h');
    if (isVertical) {
      return Column(
        children: [
          Container(
            color: CoconutColors.onPrimary(brightness),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      color: CoconutColors.surface(brightness),
                      width: 20,
                      child: valueMap['type'] as Widget,
                    ),
                    CoconutLayout.spacing_100w,
                    _guideLine(
                      height: valueMap['value'],
                    ),
                    CoconutLayout.spacing_200w,
                    Text(
                      name,
                      style: CoconutTypography.body1_16_Bold.merge(
                        TextStyle(
                          color: CoconutColors.surface(brightness),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          CoconutLayout.spacing_400h,
        ],
      );
    }
    return Container(
      color: CoconutColors.onPrimary(brightness),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Container(
                color: CoconutColors.surface(brightness),
                height: 20,
                child: valueMap['type'] as Widget,
              ),
              CoconutLayout.spacing_100h,
              Container(
                color: CoconutColors.onPrimary(brightness),
                child: _guideLine(
                  width: valueMap['value'],
                ),
              ),
              CoconutLayout.spacing_200h,
            ],
          ),
          Row(
            children: [
              CoconutLayout.spacing_1000w,
              Text(
                name,
                style: CoconutTypography.body2_14_Bold.merge(
                  TextStyle(
                    color: CoconutColors.surface(brightness),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
