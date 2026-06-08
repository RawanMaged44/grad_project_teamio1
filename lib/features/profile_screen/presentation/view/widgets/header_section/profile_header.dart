import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/utils/app_styles.dart';
import 'package:graduation_project/features/homeScreen/presentation/controller/home_cubit.dart';
import 'package:graduation_project/features/profile_screen/data/model/profile_model.dart';
import 'profile_avatar.dart';

class ProfileHeader extends StatelessWidget {
  final Data profile;

  const ProfileHeader({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final teamName = context.read<HomeCubit>().state is HomeSuccessState
        ? (context.read<HomeCubit>().state as HomeSuccessState)
                .team
                .data
                ?.teamName ??
            ''
        : '';

    return Column(
      children: [
        SizedBox(height: 24.h),
        ProfileAvatar(avatarUrl: profile.avatarUrl),
        SizedBox(height: 14.h),
        Text(profile.fullName ?? '', style: AppStyles.white21bold),
        SizedBox(height: 6.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if ((profile.desiredRole ?? '').isNotEmpty) ...[
              Text(profile.desiredRole ?? '', style: AppStyles.white15medium),
              Text('  ·  ', style: AppStyles.white15medium),
            ],
            if (teamName.isNotEmpty)
              Text(teamName, style: AppStyles.white15medium),
          ],
        ),
        SizedBox(height: 24.h),
      ],
    );
  }
}
