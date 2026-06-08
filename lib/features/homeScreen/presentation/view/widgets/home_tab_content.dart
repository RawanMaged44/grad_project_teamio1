import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/features/homeScreen/presentation/controller/home_cubit.dart';
import 'package:graduation_project/features/homeScreen/presentation/view/widgets/home_header.dart';
import 'package:graduation_project/features/homeScreen/presentation/view/widgets/team_info_section.dart';
import 'package:graduation_project/features/homeScreen/presentation/view/widgets/team_members_section.dart';
import '../../../../../core/utils/app_colors.dart';

class HomeTabContent extends StatelessWidget {
  final String userName;
  final VoidCallback? onProfileTap;

  const HomeTabContent({super.key, required this.userName, this.onProfileTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Column(
        children: [
          HomeHeader(userName: userName, onProfileTap: onProfileTap),
          Expanded(
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is HomeLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is HomeErrorState) {
                  return Center(
                    child: Text(
                      state.errorMessage,
                      style: const TextStyle(color: AppColors.redColor),
                    ),
                  );
                }
                if (state is HomeSuccessState) {
                  final team = state.team.data;
                  final members = team?.members ?? [];
                  return ListView(
                    children: [
                      const SizedBox(height: 5),
                      if (team != null) TeamInfoSection(team: team),
                      const SizedBox(height: 20),
                      if (members.isNotEmpty) TeamMembersSection(members: members),
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
