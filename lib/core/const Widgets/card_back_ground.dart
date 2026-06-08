import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_images.dart';
import '../utils/app_colors.dart';

class AppBackground extends StatelessWidget {
  final Widget child;

  const AppBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container
          (
          decoration: const BoxDecoration(
            image: DecorationImage(image:AssetImage( AppImages.cardBackGround),
                fit: BoxFit.cover
            ),
          ),
          child: child,
        )
      ],
    );
  }
}