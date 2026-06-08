import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

/// Shared avatar widget used in ChatScreen tile and MemberChatScreen app bar.

class ChatAvatar extends StatelessWidget {
  final String? imageUrl;
  final bool isGroup;
  final double radius;

  const ChatAvatar({
    super.key,
    this.imageUrl,
    this.isGroup = false,
    this.radius = 20,
  });

  bool get _hasImage => imageUrl != null && imageUrl!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: AppColors.grayColor,
      backgroundImage: _hasImage ? NetworkImage(imageUrl!) : null,
      child: _hasImage
          ? null
          : Icon(
              isGroup ? Icons.group : Icons.person,
              color: AppColors.whiteColor,
              size: radius * 0.9,
            ),
    );
  }
}
