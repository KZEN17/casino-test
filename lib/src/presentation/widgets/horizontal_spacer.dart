import 'package:flutter/material.dart';

class HorizontalSpacer extends StatelessWidget {
  final double width;
  const HorizontalSpacer({
    super.key,
    this.width = 5.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
    );
  }
}
