import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/const Widgets/chat_avatar.dart';
import '../../../../data/model/message_model.dart';
import '../../../../../../../core/utils/app_colors.dart';

class MessageBubble extends StatefulWidget {
  final MessageItem msg;
  final bool isMe;
  final bool showDate;
  final String searchQuery;
  final bool isGroup;

  const MessageBubble({
    super.key,
    required this.msg,
    required this.isMe,
    required this.showDate,
    required this.searchQuery,
    this.isGroup = false,
  });

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  bool showTime = false;

  @override
  Widget build(BuildContext context) {
    if (widget.isGroup) return _buildGroupBubble(context);
    return _buildPrivateBubble(context);
  }

  Widget _buildPrivateBubble(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => showTime = !showTime),
      child: Align(
        alignment: widget.isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Column(
          crossAxisAlignment:
              widget.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            _buildBubbleContainer(context),
            if (showTime) _buildTimestamp(),
          ],
        ),
      ),
    );
  }

  Widget _buildGroupBubble(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => showTime = !showTime),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.h),
        child: Row(
          mainAxisAlignment:
              widget.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (!widget.isMe) ...[
              Padding(
                padding: EdgeInsets.only(left: 8.w, bottom: 4.h),
                child: ChatAvatar(
                  imageUrl: widget.msg.avatarUrl?.toString(),
                  isGroup: false,
                  radius: 16.r,
                ),
              ),
              SizedBox(width: 6.w),
            ],
            Column(
              crossAxisAlignment: widget.isMe
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                if (!widget.isMe)
                  Padding(
                    padding: EdgeInsets.only(left: 4.w, bottom: 2.h),
                    child: Text(
                      widget.msg.senderName ?? '',
                      style: TextStyle(
                        color: AppColors.lightGrayColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                _buildBubbleContainer(context),
                if (showTime) _buildTimestamp(),
              ],
            ),
            if (widget.isMe) ...[
              SizedBox(width: 6.w),
              Padding(
                padding: EdgeInsets.only(right: 8.w, bottom: 4.h),
                child: ChatAvatar(
                  imageUrl: widget.msg.avatarUrl?.toString(),
                  isGroup: false,
                  radius: 16.r,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildBubbleContainer(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      padding: EdgeInsets.all(14.r),
      constraints: BoxConstraints(maxWidth: 0.65.sw),
      decoration: BoxDecoration(
        color: widget.isMe
            ? AppColors.grayColor.withOpacity(0.62)
            : AppColors.mainColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
          bottomLeft: Radius.circular(widget.isMe ? 20.r : 0),
          bottomRight: Radius.circular(widget.isMe ? 0 : 20.r),
        ),
      ),
      child: _buildText(),
    );
  }

  Widget _buildTimestamp() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Text(
        widget.msg.createAt ?? '',
        style: TextStyle(color: Colors.grey, fontSize: 10.sp),
      ),
    );
  }

  Widget _buildText() {
    final text = widget.msg.content ?? '';
    final query = widget.searchQuery.trim();

    if (text.isEmpty) return const SizedBox();

    if (query.isEmpty) {
      return Text(text,
          style: TextStyle(color: Colors.white, fontSize: 14.sp));
    }

    final lowerText = text.toLowerCase();
    final lowerQuery = query.toLowerCase();

    if (!lowerText.contains(lowerQuery)) {
      return Text(text,
          style: TextStyle(color: Colors.white, fontSize: 14.sp));
    }

    final spans = <TextSpan>[];
    int start = 0;

    while (true) {
      final index = lowerText.indexOf(lowerQuery, start);
      if (index == -1) {
        spans.add(TextSpan(
          text: text.substring(start),
          style: TextStyle(color: Colors.white, fontSize: 14.sp),
        ));
        break;
      }
      if (index > start) {
        spans.add(TextSpan(
          text: text.substring(start, index),
          style: TextStyle(color: Colors.white, fontSize: 14.sp),
        ));
      }
      spans.add(TextSpan(
        text: text.substring(index, index + query.length),
        style: TextStyle(
          color: Colors.black,
          backgroundColor: Colors.yellow,
          fontWeight: FontWeight.bold,
          fontSize: 14.sp,
        ),
      ));
      start = index + query.length;
    }

    return RichText(text: TextSpan(children: spans));
  }
}
