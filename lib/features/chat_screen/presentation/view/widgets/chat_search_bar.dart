import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_colors.dart';

class ChatSearchBar extends StatefulWidget {
  final ValueChanged<String>? onChanged;

  const ChatSearchBar({super.key, this.onChanged});

  @override
  State<ChatSearchBar> createState() => _ChatSearchBarState();
}

class _ChatSearchBarState extends State<ChatSearchBar> {
  final TextEditingController _controller = TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() => _hasText = _controller.text.isNotEmpty);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _clear() {
    _controller.clear();
    widget.onChanged?.call('');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 50.h,
              decoration: BoxDecoration(
                color: AppColors.grayColor.withOpacity(0.62),
                borderRadius: BorderRadius.circular(35.r),
              ),
              child: TextField(
                controller: _controller,
                onChanged: widget.onChanged,
                style: TextStyle(color: AppColors.whiteColor, fontSize: 16.sp),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.white, size: 22.sp),
                  hintText: 'Search Chats',
                  hintStyle: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 16.sp,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 10.h),
                ),
              ),
            ),
          ),
          if (_hasText) ...[
            SizedBox(width: 10.w),
            GestureDetector(
              onTap: _clear,
              child: Container(
                width: 36.r,
                height: 36.r,
                decoration: BoxDecoration(
                  color: AppColors.grayColor.withOpacity(0.62),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.close, color: Colors.white, size: 18.sp),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
