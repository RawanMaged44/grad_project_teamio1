import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ChatScrollCoordinator {
  final ScrollController scrollController;
  final VoidCallback onLoadMore;

  ChatScrollCoordinator({
    required this.scrollController,
    required this.onLoadMore,
  }) {
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!scrollController.hasClients) return;
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200) {
      onLoadMore();
    }
  }

  void scrollToBottom() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    });
  }

  void scrollToMatch(int globalIndex) {
    if (globalIndex < 0 || !scrollController.hasClients) return;

    // ListView is reverse:true → index 0 is at position 0 (bottom)
    // higher index = further up = higher scroll position
    const itemHeight = 72.0;
    final target = (globalIndex * itemHeight)
        .clamp(0.0, scrollController.position.maxScrollExtent);

    scrollController.animateTo(
      target,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void dispose() => scrollController.removeListener(_onScroll);
}