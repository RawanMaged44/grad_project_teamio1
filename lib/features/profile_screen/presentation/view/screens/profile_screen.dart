import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/const%20Widgets/app_background.dart';
import '../../controller/profile_cubit/profile_cubit.dart';
import '../widgets/header_section/profile_header.dart';
import '../widgets/info_section/profile_info_cards.dart';
import '../widgets/profile_settings_section/profile_settings_section.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    // Only fetch if not already loaded
    if (context.read<ProfileCubit>().state is! ProfileSuccess) {
      context.read<ProfileCubit>().getMyProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading || state is ProfileInitial) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is ProfileError) {
                return Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }

              if (state is ProfileSuccess) {
                final profile = state.profile;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      ProfileHeader(profile: profile),
                      ProfileInfoCards(profile: profile),
                      ProfileSettingsSection(profile: profile),
                      const SizedBox(height: 32),
                    ],
                  ),
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
