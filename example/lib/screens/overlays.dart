import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:example/appbar.dart';
import 'package:example/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OverlaysScreen extends StatefulWidget {
  const OverlaysScreen({super.key});

  @override
  State<OverlaysScreen> createState() => _OverlaysScreenState();
}

class _OverlaysScreenState extends State<OverlaysScreen> {
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
              padding: const EdgeInsets.all(CoconutLayout.defaultPadding),
              child: Center(
                child: Column(
                  children: [
                    CoconutUnderlinedButton(
                        brightness: brightness,
                        text: 'CoconutBottomSheet minimum',
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => CoconutBottomSheet(
                              brightness: brightness,
                              appBar: CoconutAppBar.build(
                                title: 'Minimum',
                                context: context,
                                brightness: brightness,
                                hasRightIcon: false,
                                isBottom: true,
                              ),
                              body: Column(
                                children: [
                                  Container(
                                    height: 20,
                                    color: CoconutColors.red,
                                  ),
                                  Container(
                                    height: 20,
                                    color: CoconutColors.yellow,
                                  ),
                                  Container(
                                    height: 20,
                                    color: CoconutColors.green,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                    CoconutUnderlinedButton(
                      brightness: brightness,
                      text: 'CoconutBottomSheet maximum',
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) => CoconutBottomSheet(
                            brightness: brightness,
                            appBar: CoconutAppBar.buildWithNext(
                              title: 'Maximum',
                              context: context,
                              brightness: brightness,
                              nextButtonTitle: '완료',
                              usePrimaryActiveColor: true,
                              onNextPressed: () {
                                Navigator.pop(context);
                              },
                              isBottom: true,
                            ),
                            body: Column(
                              children: [
                                Container(
                                  height: 500,
                                  color: CoconutColors.red,
                                ),
                                Container(
                                  height: 500,
                                  color: CoconutColors.yellow,
                                ),
                                Container(
                                  height: 500,
                                  color: CoconutColors.green,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    CoconutUnderlinedButton(
                      brightness: brightness,
                      text: 'CoconutBottomSheet fixed',
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) => CoconutBottomSheet(
                            brightness: brightness,
                            appBar: CoconutAppBar.buildWithNext(
                              title: 'Fixed',
                              context: context,
                              brightness: brightness,
                              nextButtonTitle: '완료',
                              onNextPressed: () {
                                Navigator.pop(context);
                              },
                              isBottom: true,
                            ),
                            bodyHeight: 300,
                            body: Column(
                              children: [
                                Container(
                                  height: 300,
                                  color: CoconutColors.red,
                                ),
                                Container(
                                  height: 300,
                                  color: CoconutColors.yellow,
                                ),
                                Container(
                                  height: 300,
                                  color: CoconutColors.green,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
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
}
