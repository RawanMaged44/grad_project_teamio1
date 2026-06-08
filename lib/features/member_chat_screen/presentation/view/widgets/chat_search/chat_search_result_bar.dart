import 'package:flutter/material.dart';
import '../../../../../../core/utils/app_colors.dart';

class ChatSearchResultBar extends StatefulWidget {
  final int resultCount;
  final int currentIndex;
  final bool hasQuery;
  final VoidCallback onNext;
  final VoidCallback onPrev;

  const ChatSearchResultBar({
    super.key,
    required this.resultCount,
    required this.hasQuery,
    required this.onNext,
    required this.onPrev,
    this.currentIndex = -1,
  });

  @override
  State<ChatSearchResultBar> createState() => _ChatSearchResultBarState();
}

class _ChatSearchResultBarState extends State<ChatSearchResultBar> {
  // 0 = none, 1 = prev pressed, 2 = next pressed
  int _lastPressed = 0;

  @override
  Widget build(BuildContext context) {
    if (!widget.hasQuery) return const SizedBox.shrink();

    final current = widget.resultCount > 0 ? widget.currentIndex + 1 : 0;
    final label = widget.resultCount > 0
        ? '$current of ${widget.resultCount} Matches'
        : 'No Matches';

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 10, 24, 10),
      color: const Color(0xFF1A1A1A),
      child: Row(
        children: [
          // Arrows container
          Container(
            decoration: BoxDecoration(
              color: AppColors.grayColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() => _lastPressed = 1);
                    widget.onPrev();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Icon(
                      Icons.keyboard_arrow_up,
                      color: _lastPressed == 1
                          ? AppColors.whiteColor
                          : AppColors.lightGrayColor,
                      size: 22,
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: 20,
                  color: AppColors.lightGrayColor.withOpacity(0.3),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() => _lastPressed = 2);
                    widget.onNext();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: _lastPressed == 2
                          ? AppColors.whiteColor
                          : AppColors.lightGrayColor,
                      size: 22,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          // Match count text centered in remaining space
          Expanded(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.whiteColor,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
