import 'package:flutter/material.dart';

class OnBoardingGradientOverlay extends StatelessWidget {
  final Color gradientColor;

  const OnBoardingGradientOverlay({super.key, required this.gradientColor});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.transparent,
              gradientColor.withOpacity(0.4),
              gradientColor.withOpacity(0.9),
              gradientColor,
            ],
            stops: const [0.0, 0.5, 0.7, 0.85, 1.0],
          ),
        ),
      ),
    );
  }
}
