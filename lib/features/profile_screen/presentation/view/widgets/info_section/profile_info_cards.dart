import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/features/profile_screen/data/model/profile_model.dart';
import 'profile_basic_info_card.dart';
import 'profile_skills_card.dart';

class ProfileInfoCards extends StatelessWidget {
  final Data profile;

  const ProfileInfoCards({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: ProfileBasicInfoCard(profile: profile)),
            SizedBox(width: 12.w),
            Expanded(child: ProfileSkillsCard(skills: profile.skills ?? [])),
          ],
        ),
      ),
    );
  }
}
