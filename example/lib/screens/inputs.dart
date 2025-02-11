import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:example/appbar.dart';
import 'package:example/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InputsScreen extends StatefulWidget {
  const InputsScreen({super.key});

  @override
  State<InputsScreen> createState() => _InputsScreenState();
}

class _InputsScreenState extends State<InputsScreen> {
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
                    _titleBox('Chip', brightness),
                    Wrap(
                      spacing: 10,
                      runAlignment: WrapAlignment.center,
                      runSpacing: 10,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        CoconutChip(
                          color: CoconutColors.primary,
                          child: Text(
                            'TEXT',
                            style: CoconutTypography.caption_10_Bold.copyWith(
                              color: CoconutColors.black,
                            ),
                          ),
                        ),
                        CoconutChip(
                          color: CoconutColors.onGray150(brightness),
                          child: Text(
                            'TEXT',
                            style: CoconutTypography.caption_10_Bold.copyWith(
                              color: CoconutColors.onAccent(brightness),
                            ),
                          ),
                        ),
                        CoconutChip(
                          color: CoconutColors.onGray150(brightness),
                          child: Text(
                            'TEXT',
                            style: CoconutTypography.caption_10_Bold.copyWith(
                              color: CoconutColors.onBlack(brightness),
                            ),
                          ),
                        ),
                        CoconutChip(
                          color: CoconutColors.onBlack(brightness),
                          child: Text(
                            'TEXT',
                            style: CoconutTypography.caption_10_Bold.copyWith(
                              color: CoconutColors.onWhite(brightness),
                            ),
                          ),
                        ),
                        CoconutChip(
                          color: Colors.transparent,
                          borderColor: CoconutColors.onBlack(brightness),
                          child: Text(
                            'TEXT',
                            style: CoconutTypography.caption_10_Bold.copyWith(
                              color: CoconutColors.onBlack(brightness),
                            ),
                          ),
                        ),
                        CoconutChip(
                          color: CoconutColors.cyan,
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 8),
                          isRectangle: true,
                          child: Text(
                            'TESTNET',
                            style: CoconutTypography.caption_10.copyWith(
                              color: CoconutColors.white,
                            ),
                          ),
                        ),
                        CoconutChip(
                          color: CoconutColors.onGray150(brightness),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '2024.11.08',
                                style:
                                    CoconutTypography.body2_14_Number.copyWith(
                                  color: CoconutColors.onBlack(brightness),
                                ),
                              ),
                              Container(
                                width: 1,
                                height: 12,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                color: CoconutColors.onGray600(brightness),
                              ),
                              Text(
                                '18:50',
                                style:
                                    CoconutTypography.body2_14_Number.copyWith(
                                  color: CoconutColors.onBlack(brightness),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    _titleBox('Tag Chip', brightness),
                    const Wrap(
                      spacing: 10,
                      runAlignment: WrapAlignment.center,
                      runSpacing: 10,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        CoconutTagChip(
                          tag: 'TEXT',
                          color: CoconutColors.red,
                          isRectangle: true,
                        ),
                        CoconutTagChip(
                          tag: 'TEXT',
                          color: CoconutColors.red,
                          isRectangle: true,
                          status: CoconutChipStatus.unselected,
                        ),
                        CoconutTagChip(
                          tag: 'TEXT',
                          color: CoconutColors.red,
                          isRectangle: true,
                          status: CoconutChipStatus.selected,
                        ),
                        CoconutTagChip(
                          tag: 'Coconut',
                          color: CoconutColors.sky,
                        ),
                        CoconutTagChip(
                          tag: 'Coconut',
                          color: CoconutColors.sky,
                          status: CoconutChipStatus.unselected,
                        ),
                        CoconutTagChip(
                          color: CoconutColors.sky,
                          tag: 'Coconut',
                          status: CoconutChipStatus.selected,
                        ),
                      ],
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
}
