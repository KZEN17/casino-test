import 'package:flutter/material.dart';

class RotatingImage extends StatefulWidget {
  final String imagePath;
  final double size;
  final int duration;

  const RotatingImage({
    required this.imagePath,
    required this.size,
    required this.duration,
  });

  @override
  _RotatingImageState createState() => _RotatingImageState();
}

class _RotatingImageState extends State<RotatingImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.duration),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(_animationController),
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: AssetImage(
                widget.imagePath,
              ),
              fit: BoxFit.fill),
        ),
      ),
    );
  }
}
