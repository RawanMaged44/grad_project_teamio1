import 'package:flutter/material.dart';

import '../utils/app_images.dart';

class CustomLogo extends StatelessWidget {
  const CustomLogo({super.key, this.height, this.width});
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppImages.logo,
      height: height,
      width: width,
    );
  }
}
