import 'package:example/appbar.dart';
import 'package:flutter/material.dart';
import 'package:coconut_design_system/coconut_design_system.dart';

class TypographyScreen extends StatelessWidget {
  const TypographyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: ListView.builder(
          itemCount: CoconutTypography.typographyStyles.length,
          itemBuilder: (context, index) {
            final typographyKey =
                CoconutTypography.typographyStyles.keys.elementAt(index);
            final typographyStyle =
                CoconutTypography.typographyStyles[typographyKey]!;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    typographyKey,
                    style: CoconutTypography.body2_14.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (typographyKey.contains('Number')) ...{
                    Text(
                      '1234567890',
                      style: typographyStyle,
                    ),
                  } else ...{
                    Text(
                      'The quick brown fox jumps over the lazy dog',
                      style: typographyStyle,
                    ),
                  },
                  const Divider(height: 24),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
