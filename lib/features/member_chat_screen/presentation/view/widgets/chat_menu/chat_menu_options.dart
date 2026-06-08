import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/app_texts.dart';
import 'chat_menu_model.dart';

class ChatMenuOptions {
  static List<ChatMenuModel> getItems({bool isPinned = false}) => [
    ChatMenuModel(
      title: AppTexts.clearChat,
      icon: Icons.delete,
      value: 'clear',
    ),
    ChatMenuModel(
      title: AppTexts.muteChat,
      icon: Icons.notifications_off,
      value: 'mute',
    ),
    ChatMenuModel(
      title: isPinned ? AppTexts.unpinChat : AppTexts.pinChat,
      icon: isPinned ? Icons.push_pin : Icons.push_pin_outlined,
      value: 'pin',
    ),
    ChatMenuModel(
      title: AppTexts.searchInChat,
      icon: Icons.search_rounded,
      value: 'search',
    ),
  ];
}
