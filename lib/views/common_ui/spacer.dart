import 'package:flutter/material.dart';

class HorizontalSpacer extends StatelessWidget {
  const HorizontalSpacer({required this.space, super.key});

  final double space;

  factory HorizontalSpacer.xs() => const HorizontalSpacer(
        space: 4,
      );

  factory HorizontalSpacer.s() => const HorizontalSpacer(
        space: 8,
      );

  factory HorizontalSpacer.l() => const HorizontalSpacer(
        space: 16,
      );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: space,
    );
  }
}
