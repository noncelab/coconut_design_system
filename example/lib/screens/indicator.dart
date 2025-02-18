import 'package:coconut_design_system/coconut_design_system.dart';
import 'package:example/appbar.dart';
import 'package:example/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IndicatorScreen extends StatefulWidget {
  const IndicatorScreen({super.key});

  @override
  State<IndicatorScreen> createState() => _IndicatorScreenState();
}

class _IndicatorScreenState extends State<IndicatorScreen> {
  // Linear Progress Indicator
  double progress = 0;
  int linearProgressDuration = 500;

  // Circular Progress Indicator
  bool reverse = false;
  bool loop = true;
  int circularProgressDuration = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: Container(
        padding: const EdgeInsets.all(CoconutLayout.defaultPadding),
        height: MediaQuery.sizeOf(context).height,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              final isDarkMode = themeProvider.themeMode == ThemeMode.dark;
              final brightness =
                  isDarkMode ? Brightness.dark : Brightness.light;

              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: CoconutLayout.defaultPadding,
                  vertical: Sizes.size30,
                ),
                child: Column(
                  children: [
                    Text(
                      'Linear Progress Indicator',
                      style: CoconutTypography.body1_16_Bold,
                    ),
                    CoconutLayout.spacing_500h,
                    CoconutProgressIndicator(
                      progress: progress,
                      duration: linearProgressDuration,
                    ),
                    CoconutLayout.spacing_1000h,
                    _buildProgressControlBox(brightness),
                    Stack(
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width,
                          height: 350,
                        ),
                        Center(
                          child: CoconutCircularIndicator(
                            loop: loop,
                            reverse: reverse,
                            duration: circularProgressDuration,
                          ),
                        ),
                        Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          'Reverse',
                                          style:
                                              CoconutTypography.body2_14_Bold,
                                        ),
                                        CoconutButton(
                                          brightness: brightness,
                                          width: 100,
                                          onPressed: () {
                                            setState(() {
                                              reverse = !reverse;
                                            });
                                          },
                                          text: reverse ? 'ON' : 'OFF',
                                        ),
                                      ],
                                    ),
                                    CoconutLayout.spacing_1000w,
                                    Column(
                                      children: [
                                        Text(
                                          'Loop',
                                          style:
                                              CoconutTypography.body2_14_Bold,
                                        ),
                                        CoconutButton(
                                          brightness: brightness,
                                          width: 100,
                                          onPressed: () {
                                            setState(() {
                                              loop = !loop;
                                            });
                                          },
                                          text: loop ? 'ON' : 'OFF',
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                CoconutLayout.spacing_1000h,
                                Column(
                                  children: [
                                    Text(
                                      'Durations',
                                      style: CoconutTypography.body2_14_Bold,
                                    ),
                                    CoconutLayout.spacing_1000h,
                                    _buildCircularProgressDurationControlBox(
                                        brightness),
                                  ],
                                ),
                              ],
                            ))
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCircularProgressDurationControlBox(Brightness brightness) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CoconutButton(
                width: 100,
                brightness: brightness,
                onPressed: () {
                  circularProgressDuration = 1;

                  setState(() {
                    circularProgressDuration = 1;
                  });
                },
                text: '1(default)'),
            CoconutButton(
                width: 50,
                brightness: brightness,
                onPressed: () {
                  circularProgressDuration = 2;

                  setState(() {
                    circularProgressDuration = 2;
                  });
                },
                text: '2'),
            CoconutButton(
                width: 50,
                brightness: brightness,
                onPressed: () {
                  circularProgressDuration = 3;

                  setState(() {
                    circularProgressDuration = 3;
                  });
                },
                text: '3'),
            CoconutButton(
                width: 50,
                brightness: brightness,
                onPressed: () {
                  circularProgressDuration = 4;

                  setState(() {
                    circularProgressDuration = 4;
                  });
                },
                text: '4'),
            CoconutButton(
                width: 50,
                brightness: brightness,
                onPressed: () {
                  circularProgressDuration = 5;

                  setState(() {
                    circularProgressDuration = 5;
                  });
                },
                text: '5'),
          ],
        ),
      ],
    );
  }

  Widget _buildProgressControlBox(Brightness brightness) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CoconutButton(
                brightness: brightness,
                onPressed: () {
                  linearProgressDuration = 500;

                  setState(() {
                    progress = 0;
                  });
                },
                text: '0%'),
            CoconutButton(
                brightness: brightness,
                onPressed: () {
                  linearProgressDuration = 500;

                  setState(() {
                    progress = 0.25;
                  });
                },
                text: '25%'),
            CoconutButton(
                brightness: brightness,
                onPressed: () {
                  linearProgressDuration = 500;

                  setState(() {
                    progress = 0.5;
                  });
                },
                text: '50%'),
            CoconutButton(
                brightness: brightness,
                onPressed: () {
                  linearProgressDuration = 500;

                  setState(() {
                    progress = 0.75;
                  });
                },
                text: '75%'),
            CoconutButton(
                brightness: brightness,
                onPressed: () {
                  linearProgressDuration = 500;

                  setState(() {
                    progress = 1;
                  });
                },
                text: '100%'),
          ],
        ),
        CoconutLayout.spacing_500h,
        CoconutButton(
            brightness: brightness,
            width: MediaQuery.sizeOf(context).width,
            onPressed: () async {
              linearProgressDuration = 1;

              setState(() {
                progress = 0;
              });

              await Future.delayed(const Duration(milliseconds: 100));
              if (!mounted) return;
              linearProgressDuration = 3000;

              setState(() {
                progress = 1;
              });
            },
            text: '0 to 100 (duration: 3000)'),
      ],
    );
  }
}
