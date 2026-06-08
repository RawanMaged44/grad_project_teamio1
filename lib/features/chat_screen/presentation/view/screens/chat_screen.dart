import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/const%20Widgets/app_background.dart';
import '../../../../../core/utils/app_routes.dart';
import '../../../../../core/utils/app_styles.dart';
import '../widgets/chat_list_view.dart';
import '../widgets/chat_search_bar.dart';

class ChatScreen extends StatefulWidget {
  static String routeName = AppRoute.chatRoute;

  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Text("Chats", style: AppStyles.white21bold),
              ),
              ChatSearchBar(
                onChanged: (value) => setState(() => _searchQuery = value),
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: ChatListView(searchQuery: _searchQuery),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
