import 'package:flutter/material.dart';
import '../../../../../../core/utils/app_colors.dart';
import 'chat_menu_item.dart';
import 'chat_menu_model.dart';

class ChatMenuButton extends StatelessWidget {
  final Function(String value) onSelected;
  final List<ChatMenuModel> items;

  const ChatMenuButton({
    super.key,
    required this.onSelected,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      offset: const Offset(0, 50),
      color:  AppColors.grayColor.withOpacity(0.97),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      icon: const Icon(Icons.more_vert, color: Colors.white),
      onSelected: onSelected,
      itemBuilder: (context) {
        return items.map((item) {
          return PopupMenuItem<String>(
            value: item.value,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: ChatMenuItem(
                title: item.title,
                icon: item.icon,
              ),
            ),
          );
        }).toList();
      },
    );
  }
}