import 'package:flutter/material.dart';
import '../model/on_boarding_model.dart';

class OnBoardingPageItem extends StatelessWidget {
  final OnBoardingModel model;

  const OnBoardingPageItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          model.imagePath,
          fit: BoxFit.fill,
          height: double.infinity,
          width: double.infinity,
        ),
        Container(color: Colors.black.withOpacity(0.2)),
      ],
    );
  }
}
