import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_colors.dart';

class ChatMemberSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String value) onChanged;
  final VoidCallback onClose;

  const ChatMemberSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
      color: Colors.transparent ,
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 45,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: AppColors.grayColor.withOpacity(0.62),
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                controller: controller,
                style: const TextStyle(color: Colors.white),
                onChanged: onChanged,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  hintText: "Search",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onClose,
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.grayColor.withOpacity(0.62),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, color: Colors.white, size: 18),
            ),
          ),
        ],
      ),
    );
  }
}