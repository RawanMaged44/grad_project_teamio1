import 'dart:async';
import 'package:flutter/material.dart';
import '../../controller/member_chat_cubit/member_chat_cubit.dart';

class ChatSearchCoordinator {
  final MemberChatCubit cubit;
  final TextEditingController searchController;
  final VoidCallback onStateChanged;

  Timer? _debounce;
  bool isSearchMode = false;
  String searchQuery = '';

  ChatSearchCoordinator({
    required this.cubit,
    required this.searchController,
    required this.onStateChanged,
  });

  String get query => searchQuery;

  void toggleSearchMode(bool value) {
    isSearchMode = value;
    if (!value) resetSearch();
    onStateChanged();
  }

  void onSearchChanged(String value) {
    searchQuery = value;
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      cubit.searchMessages(value.trim());
      onStateChanged();
    });
  }

  void resetSearch() {
    searchQuery = '';
    searchController.clear();
    cubit.searchMessages('');
    onStateChanged();
  }

  void dispose() => _debounce?.cancel();
}