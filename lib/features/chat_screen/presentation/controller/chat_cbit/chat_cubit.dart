import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/model/chat_model.dart';
import '../../../data/repo/chat_repo.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepo chatRepo;
  ChatCubit({required this.chatRepo}) : super(ChatInitialState());

  Future<void> getMyChats() async {
    emit(ChatLoadingState());
    final result = await chatRepo.getMyChats();
    result.fold(
      (l) => emit(ChatErrorState(errorMessage: l)),
      (r) {
        // Sort: pinned chats first
        r.data?.sort((a, b) {
          final aPinned = a.isPinned == true ? 0 : 1;
          final bPinned = b.isPinned == true ? 0 : 1;
          return aPinned.compareTo(bPinned);
        });
        emit(ChatSuccessState(chatModel: r));
      },
    );
  }

  Future<void> togglePin(String chatId) async {
    final result = await chatRepo.togglePin(chatId);
    result.fold(
      (l) => null, // silent fail
      (r) => getMyChats(), // refresh list after toggle
    );
  }

  Future<bool> clearChat(String chatId) async {
    final result = await chatRepo.clearChat(chatId);
    return result.fold(
      (l) => false,
      (r) {
        getMyChats(); // refresh list after clear
        return true;
      },
    );
  }
}
