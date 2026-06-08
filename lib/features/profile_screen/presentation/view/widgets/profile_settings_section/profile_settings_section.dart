import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
import 'package:graduation_project/core/utils/app_styles.dart';
import 'package:graduation_project/core/utils/app_texts.dart';
import 'package:graduation_project/features/profile_screen/data/model/profile_model.dart';
import 'package:graduation_project/features/update_profile_screen/presentation/controller/update_profile_cubit/update_profile_cubit.dart';
import 'package:graduation_project/features/update_profile_screen/presentation/view/screen/update_profile_screen.dart';
import 'logout_dialog.dart';
import 'notification_tile.dart';
import 'settings_tile.dart';

class ProfileSettingsSection extends StatefulWidget {
  final Data profile;

  const ProfileSettingsSection({super.key, required this.profile});

  @override
  State<ProfileSettingsSection> createState() => _ProfileSettingsSectionState();
}

class _ProfileSettingsSectionState extends State<ProfileSettingsSection> {
  bool _pauseNotifications = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 28.h),
          Text(AppTexts.settings, style: AppStyles.white18bold),
          SizedBox(height: 12.h),
          Container(
            decoration: BoxDecoration(
              color: AppColors.grayColor.withOpacity(0.62),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              children: [
                SettingsTile(
                  icon: Icons.edit_outlined,
                  label: AppTexts.editProfile,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: context.read<UpdateProfileCubit>(),
                          child: UpdateProfileScreen(profile: widget.profile),
                        ),
                      ),
                    );
                  },
                ),
                _divider(),
                NotificationTile(
                  value: _pauseNotifications,
                  onChanged: (val) =>
                      setState(() => _pauseNotifications = val),
                ),
                _divider(),
                SettingsTile(
                  icon: Icons.logout_rounded,
                  label: AppTexts.logout,
                  onTap: () => showLogoutDialog(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() => const Divider(
        height: 1,
        thickness: 0.5,
        color: Colors.white12,
        indent: 16,
        endIndent: 16,
      );
}
