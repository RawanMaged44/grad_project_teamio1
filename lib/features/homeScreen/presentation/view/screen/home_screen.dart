import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/chat_screen/presentation/controller/chat_cbit/chat_cubit.dart';
import 'package:graduation_project/features/homeScreen/presentation/controller/home_cubit.dart';
import 'package:graduation_project/features/homeScreen/presentation/view/widgets/home_tab_content.dart';
import '../../../../../core/const Widgets/app_background.dart';
import '../../../../../core/utils/app_routes.dart';
import '../../../../chat_screen/presentation/view/screens/chat_screen.dart';
import '../../../../profile_screen/presentation/view/screens/profile_screen.dart';
import '../../../../tasks_screen/presentation/view/screens/tasks_screen.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = AppRoute.homeRoute;
  final String userName;

  const HomeScreen({super.key, required this.userName});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  bool _teamLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_teamLoaded) {
      _teamLoaded = true;
      context.read<HomeCubit>().getMyTeam();
    }
  }

  @override
  Widget build(BuildContext context) {
    final String currentUserName =
        ModalRoute.of(context)?.settings.arguments as String? ?? widget.userName;

    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: IndexedStack(
            index: currentIndex,
            children: [
              HomeTabContent(
                userName: currentUserName,
                onProfileTap: () => setState(() => currentIndex = 3),
              ),
              if (currentIndex >= 1) const ChatScreen() else const SizedBox(),
              if (currentIndex >= 2) const TasksScreen() else const SizedBox(),
              if (currentIndex >= 3) const ProfileScreen() else const SizedBox(),
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomNavBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() => currentIndex = index);
            // Refresh chats when switching to chats tab
            if (index == 1) {
              context.read<ChatCubit>().getMyChats();
            }
          },
        ),
      ),
    );
  }
}
