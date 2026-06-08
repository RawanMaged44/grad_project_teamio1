import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/app_texts.dart';

class LoginTitleSection extends StatelessWidget {
  const LoginTitleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 0.21.sh),
        Center(
          child: Text(AppTexts.welcomeBack, style: AppStyles.white28bold),
        ),
        SizedBox(height: 0.01.sh),
        Center(
          child: Text(AppTexts.continueStatement, style: AppStyles.white16medium),
        ),
        SizedBox(height: 0.03.sh),
      ],
    );
  }
}
