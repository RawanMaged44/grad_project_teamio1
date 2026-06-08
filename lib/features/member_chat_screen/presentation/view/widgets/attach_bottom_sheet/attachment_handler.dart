import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AttachmentHandler {
  static final ImagePicker _picker = ImagePicker();
  //static final FilePicker _filePicker = FilePicker();

  static Future<XFile?> openCamera(BuildContext context) async {
    Navigator.pop(context);
    return await _picker.pickImage(source: ImageSource.camera);
  }

  static Future<XFile?> openGallery(BuildContext context) async {
    Navigator.pop(context);
    return await _picker.pickImage(source: ImageSource.gallery);
  }

  static Future<PlatformFile?> openFiles(BuildContext context) async {
    Navigator.pop(context);
    final FilePickerResult? result = await FilePicker.pickFiles(
      type: FileType.any,
    );
    if (result != null && result.files.isNotEmpty) {
      return result.files.first;
    }
    return null;
  }
}
