import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../attach_bottom_sheet/show_attachment_sheet.dart';
import '../../../../../../core/utils/app_colors.dart';

class ChatInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final VoidCallback onAttach;
  final void Function(Object? file)? onFilePicked;

  const ChatInput({
    super.key,
    required this.controller,
    required this.onSend,
    required this.onAttach,
    this.onFilePicked,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 12.h),
      decoration: BoxDecoration(
        color: AppColors.grayColor.withOpacity(0.62),
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 60.h,
                decoration: BoxDecoration(
                  color: AppColors.grayColor.withOpacity(0.62),
                  borderRadius: BorderRadius.circular(25.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Container(
                        height: 50.h,
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFF28282C),
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 5.w),
                            Expanded(
                              child: TextField(
                                controller: controller,
                                keyboardType: TextInputType.multiline,
                                textInputAction: TextInputAction.newline,
                                textDirection: TextDirection.ltr,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.sp,
                                ),
                                decoration: InputDecoration(
                                  hintText: "Typing..",
                                  hintStyle: TextStyle(
                                    color: AppColors.whiteColor,
                                    fontSize: 18.sp,
                                  ),
                                  border: InputBorder.none,
                                  isDense: true,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.mic_none_rounded,
                              color: const Color(0xFF8E8E93),
                              size: 28.sp,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 5.w),
            GestureDetector(
              onTap: () => showAttachmentSheet(
                context,
                onFilePicked: (file) {
                  if (onFilePicked != null) onFilePicked!(file);
                },
              ),
              child: Icon(
                Icons.attach_file_rounded,
                color: const Color(0xFF8E8E93),
                size: 28.sp,
              ),
            ),
            SizedBox(width: 10.w),
            GestureDetector(
              onTap: onSend,
              child: Container(
                height: 35.r,
                width: 35.r,
                decoration: BoxDecoration(
                  color: const Color(0xFF28282C),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Icon(
                  Icons.send_rounded,
                  color: Colors.white,
                  size: 20.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
