import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:graduation_project/core/const%20Widgets/app_background.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
import 'package:graduation_project/core/utils/app_styles.dart';
import 'package:graduation_project/core/utils/app_texts.dart';
import 'package:graduation_project/features/profile_screen/data/model/profile_model.dart';
import 'package:graduation_project/features/profile_screen/presentation/controller/profile_cubit/profile_cubit.dart';
import '../../controller/update_profile_cubit/update_profile_cubit.dart';
import '../widgets/update_profile_avatar.dart';
import '../widgets/update_profile_field_card.dart';
import '../widgets/update_profile_field_row.dart';
import '../widgets/update_profile_save_button.dart';

class UpdateProfileScreen extends StatefulWidget {
  static const String routeName = '/update-profile';

  final Data profile;

  const UpdateProfileScreen({super.key, required this.profile});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  late final TextEditingController _roleController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;

  File? _pickedImage;

  @override
  void initState() {
    super.initState();
    _roleController = TextEditingController(text: widget.profile.desiredRole ?? '');
    _emailController = TextEditingController(text: widget.profile.email ?? '');
    _phoneController = TextEditingController(text: widget.profile.phoneNumber ?? '');
  }

  @override
  void dispose() {
    _roleController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (picked != null) {
      setState(() => _pickedImage = File(picked.path));
    }
  }

  void _onSave() {
    context.read<UpdateProfileCubit>().updateStudentProfile(
          desiredRole: _roleController.text.trim(),
          email: _emailController.text.trim(),
          phoneNumber: _phoneController.text.trim(),
          avatar: _pickedImage,
          currentAvatarUrl: widget.profile.avatarUrl,
        );
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: AppColors.whiteColor),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(AppTexts.editProfileTitle, style: AppStyles.white18bold),
        ),
        body: BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
          listener: (context, state) {
            if (state is UpdateProfileSuccess) {
              // Refresh profile data so next edit has the latest avatarUrl
              context.read<ProfileCubit>().getMyProfile();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pop(context);
            } else if (state is UpdateProfileError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: AppColors.redColor,
                ),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is UpdateProfileLoading;
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Column(
                children: [
                  UpdateProfileAvatar(
                    currentAvatarUrl: widget.profile.avatarUrl,
                    pickedImage: _pickedImage,
                    onTap: _pickImage,
                  ),
                  const SizedBox(height: 32),
                  UpdateProfileFieldCard(
                    fields: [
                      UpdateProfileFieldRow(
                        label: AppTexts.yourRole,
                        controller: _roleController,
                        hint: AppTexts.roleHint,
                      ),
                      UpdateProfileFieldRow(
                        label: AppTexts.yourEmail,
                        controller: _emailController,
                        hint: AppTexts.emailHint,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      UpdateProfileFieldRow(
                        label: AppTexts.yourPhone,
                        controller: _phoneController,
                        hint: AppTexts.phoneHint,
                        keyboardType: TextInputType.phone,
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  UpdateProfileSaveButton(
                    onPressed: _onSave,
                    isLoading: isLoading,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
