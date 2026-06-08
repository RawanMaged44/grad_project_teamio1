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

    return SizedBox(
      height: 290.h,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: BigInfoCard(
              team: team,
              onButtonPressed: () {},
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
                  imageUrl: null,
                  onTap: null,
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
