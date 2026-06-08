import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:graduation_project/core/utils/app_colors.dart';
import 'package:graduation_project/core/utils/app_texts.dart';
import 'attachment_handler.dart';
import 'attach_option_item.dart';

/// [onFilePicked] returns either an [XFile] (image/camera) or [PlatformFile] (document)
void showAttachmentSheet(
  BuildContext context, {
  required void Function(Object? file) onFilePicked,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: const Color(0xFF1A1A1A),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
    ),
    builder: (sheetContext) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 24),
                const Text(
                  AppTexts.shareContent,
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(sheetContext),
                  child: const Icon(Icons.close, color: AppColors.whiteColor, size: 24),
                ),
              ],
            ),
            const SizedBox(height: 20),
            AttachOptionItem(
              icon: Icons.camera_alt,
              title: AppTexts.cameraOption,
              subtitle: AppTexts.cameraSubtitle,
              onTap: () async {
                final XFile? file = await AttachmentHandler.openCamera(sheetContext);
                if (file != null) onFilePicked(file);
              },
            ),
            AttachOptionItem(
              icon: Icons.perm_media,
              title: AppTexts.mediaOption,
              subtitle: AppTexts.mediaSubtitle,
              onTap: () async {
                final XFile? file = await AttachmentHandler.openGallery(sheetContext);
                if (file != null) onFilePicked(file);
              },
            ),
            AttachOptionItem(
              icon: Icons.insert_drive_file,
              title: AppTexts.filesOption,
              subtitle: AppTexts.filesSubtitle,
              onTap: () async {
                final PlatformFile? file = await AttachmentHandler.openFiles(sheetContext);
                if (file != null) onFilePicked(file);
              },
            ),
          ],
        ),
      );
    },
  );
}
