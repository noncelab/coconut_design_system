import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:example/appbar.dart';
import 'package:example/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ColorTable extends StatelessWidget {
  const ColorTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
                flex: 2,
                child:
                    Text(" ", style: TextStyle(fontWeight: FontWeight.bold))),
            Expanded(
              flex: 3,
              child: Text(
                textAlign: TextAlign.center,
                "Light mode",
                style: CoconutTypography.body1_16_Bold,
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                textAlign: TextAlign.center,
                "Dark mode",
                style: CoconutTypography.body1_16_Bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        // Segmented Container
        _buildSectionTitle("1", "Segmented Container"),
        _buildRow("Selected", "0xFF1C1C1C", null),
        _buildRow("Unselected", "transparent", null),

        const SizedBox(height: 16),

        // Label
        _buildSectionTitle("2", "Label"),
        _buildRow("Selected", "0xFFFFFFFF", null),
        _buildRow("Unselected", "0xFFB7B7B7", "0xFF949494"),

        const SizedBox(height: 16),

        // Segmented Control Container
        _buildSectionTitle("3", "Segmented Control Container"),
        _buildRow("", "0xFFF5F5F5", "0xFF303030"),
      ],
    );
  }

  Widget _buildRow(String label, String lightColor, String? darkColor) {
    return Row(
      children: [
        Expanded(
            flex: darkColor != null ? 2 : 1,
            child: Text(
              label,
              style: CoconutTypography.body2_14_Bold,
            )),
        Expanded(flex: 3, child: Text(textAlign: TextAlign.center, lightColor)),
        if (darkColor != null)
          Expanded(
              flex: 3, child: Text(textAlign: TextAlign.center, darkColor)),
      ],
    );
  }

  Widget _buildSectionTitle(String number, String title) {
    return Row(
      children: [
        Text(
          number,
          style: CoconutTypography.body1_16_Bold,
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: CoconutTypography.body1_16_Bold,
        ),
      ],
    );
  }
}

class SegmentedConrolScreen extends StatefulWidget {
  const SegmentedConrolScreen({super.key});

  @override
  State<SegmentedConrolScreen> createState() => _SegmentedConrolScreenState();
}

class _SegmentedConrolScreenState extends State<SegmentedConrolScreen> {
  List<bool> isSelected = [true, false];
  List<String> labels = ["Design Guide", "Color Specification"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: Container(
        padding: const EdgeInsets.all(CoconutLayout.defaultPadding),
        child: SingleChildScrollView(
          child: Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              final isDarkMode = themeProvider.themeMode == ThemeMode.dark;
              final brightness =
                  isDarkMode ? Brightness.dark : Brightness.light;

              return Column(
                children: [
                  CoconutSegmentedControl(
                    labels: labels,
                    isSelected: isSelected,
                    onPressed: (index) {
                      setState(() {
                        isSelected =
                            List.generate(isSelected.length, (i) => i == index);
                      });
                    },
                  ),
                  CoconutLayout.spacing_1000h,
                  if (isSelected[0]) ...{
                    Container(
                      color:
                          CoconutColors.onPrimary(brightness).withOpacity(0.9),
                      padding: const EdgeInsets.symmetric(
                        horizontal: CoconutLayout.defaultPadding,
                        vertical: 150,
                      ),
                      child: IgnorePointer(
                        child: Stack(
                          children: [
                            CoconutSegmentedControl(
                              labels: labels,
                              isSelected: const [true, false],
                              onPressed: (index) {},
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      CoconutStyles.radius_200),
                                  color: CoconutColors.white.withOpacity(0.6)),
                              height: 46,
                            ),
                            Positioned(
                              left: 2,
                              top: 2,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(
                                      color: CoconutColors.pink, width: 1),
                                  borderRadius: BorderRadius.circular(
                                      CoconutStyles.radius_150),
                                ),
                                width: 20,
                                height: 20,
                                child: Center(
                                  child: Text(
                                    '10',
                                    style: CoconutTypography.caption_10
                                        .setColor(CoconutColors.pink),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(
                                      color: CoconutColors.pink, width: 1),
                                  borderRadius: BorderRadius.circular(
                                      CoconutStyles.radius_200),
                                ),
                                width: 24,
                                height: 24,
                                child: Center(
                                  child: Text(
                                    '12',
                                    style: CoconutTypography.caption_10
                                        .setColor(CoconutColors.pink),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left:
                                  (MediaQuery.sizeOf(context).width - 64) / 6 -
                                      10,
                              top: 2,
                              child: _guideLine(height: 12),
                            ),
                            Positioned(
                              left:
                                  (MediaQuery.sizeOf(context).width - 64) / 6 +
                                      5,
                              top: 0,
                              child: const Text(
                                'labelPadding(default: 12px)',
                                style: CoconutTypography.body3_12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  },
                  if (isSelected[1]) ...{
                    const ColorTable(),
                  }
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _guideLine({
    double height = 0,
  }) {
    return SizedBox(
      height: height,
      child: Column(
        children: [
          Container(
            height: 1.5,
            width: Sizes.size10,
            color: CoconutColors.red,
          ),
          Expanded(
            child: Container(
              width: 1.5,
              color: CoconutColors.red,
            ),
          ),
          Container(
            height: 1.5,
            width: Sizes.size10,
            color: CoconutColors.red,
          )
        ],
      ),
    );
  }
}
