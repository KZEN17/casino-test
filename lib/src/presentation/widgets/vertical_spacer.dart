import 'package:flutter/material.dart';

class VeritcalSpacer extends StatelessWidget {
  final double height;
  const VeritcalSpacer({
    super.key,
    this.height = 5.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}
