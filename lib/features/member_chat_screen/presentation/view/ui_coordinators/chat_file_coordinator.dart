import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import '../../controller/member_chat_cubit/member_chat_cubit.dart';
import 'chat_scroll_coordinator.dart';

class ChatFileCoordinator {
  final MemberChatCubit cubit;
  final String userId;
  final ChatScrollCoordinator scrollCoordinator;

  ChatFileCoordinator({
    required this.cubit,
    required this.userId,
    required this.scrollCoordinator,
  });

  void handleFilePicked(Object? file) {
    if (file == null) return;

    String? path;
    String? name;

    if (file is XFile) {
      path = file.path;
      name = file.name;
    } else if (file is PlatformFile) {
      path = file.path;
      name = file.name;
    }

    if (path != null) {
      cubit.sendMessage(name ?? 'file', userId, isFile: true);
      scrollCoordinator.scrollToBottom();
    }
  }
}
