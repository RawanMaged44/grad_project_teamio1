import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/features/homeScreen/presentation/view/widgets/big_card.dart';
import 'package:graduation_project/features/homeScreen/presentation/view/widgets/small_card.dart';
import '../../../data/model/team_model.dart';
import '../../../../member_chat_screen/data/model/chat_args_model.dart';
import '../../../../member_chat_screen/presentation/view/screens/member_chat_screen.dart';

class TeamInfoSection extends StatelessWidget {
  final TeamData team;

  const TeamInfoSection({super.key, required this.team});

  void _navigateToGroupChat(BuildContext context, {
    required String? chatId,
    required String name,
    required String? avatarUrl,
    required int chatType,
    int? membersCount,
  }) {
    if (chatId == null || chatId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Chat not available yet')),
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MemberChatScreen(
          args: ChatArgsModel(
            chatId: chatId,
            userId: '',
            name: name,
            avatar: avatarUrl,
            chatType: chatType,
            membersCount: membersCount,
          ),
        ),
      ),
    );
  }

  void _navigateToPrivateChat(BuildContext context, MemberModel member) {
    if (member.chatId == null || member.chatId!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No private chat available with this member')),
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MemberChatScreen(
          args: ChatArgsModel(
            chatId: member.chatId,
            userId: member.id ?? '',
            name: member.fullName ?? '',
            avatar: member.avatarUrl,
            chatType: 0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final members = team.members ?? [];
    final leaderIndex = members.indexWhere((m) => m.isLeader == true);
    final leader = leaderIndex != -1 ? members[leaderIndex] : null;
    final hasLeaderChat = leader != null && (leader.chatId?.isNotEmpty ?? false);

    // Doctor private chat: use doctorChat.chatId (direct 1-on-1 with doctor)
    // If null, use doctorId so MemberChatScreen can create the chat on first message
    final doctorPrivateChatId = team.doctorChat?.chatId;
    final doctorId = team.doctorChat?.doctorId ?? '';
    final doctorName = team.doctorName ?? 'Supervisor';
    final doctorAvatar = team.doctorAvatarUrl;

    // Team chat (students only): use teamChatId
    final teamChatId = team.teamChatId;

    return SizedBox(
      height: 290.h,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: BigInfoCard(
              team: team,
              onButtonPressed: () => _navigateToGroupChat(
                context,
                chatId: teamChatId,
                name: 'Team ${team.teamName ?? ''}',
                avatarUrl: null,
                chatType: 1,
                membersCount: (team.memberCount ?? 0) > 0 ? team.memberCount : 10,
              ),
            ),
          ),
          SizedBox(width: 15.w),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SmallInfoCard(
                  title: 'Supervisor',
                  imageUrl: doctorAvatar,
                  onTap: doctorId.isNotEmpty
                      ? () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MemberChatScreen(
                                args: ChatArgsModel(
                                  chatId: doctorPrivateChatId, // null = will be created on first message
                                  userId: doctorId,
                                  name: doctorName,
                                  avatar: doctorAvatar,
                                  chatType: 0, // private chat
                                ),
                              ),
                            ),
                          )
                      : () => ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Supervisor info not available yet'),
                            ),
                          ),
                ),
                SizedBox(height: 16.h),
                SmallInfoCard(
                  title: 'Team Leader',
                  imageUrl: leader?.avatarUrl,
                  onTap: hasLeaderChat
                      ? () => _navigateToPrivateChat(context, leader!)
                      : () => ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Leader info not available yet'),
                            ),
                          ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
