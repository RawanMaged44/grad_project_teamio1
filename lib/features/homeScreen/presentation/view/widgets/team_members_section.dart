import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/functions/storage_helper.dart';
import 'package:graduation_project/core/utils/app_styles.dart';
import 'package:graduation_project/core/utils/app_texts.dart';
import '../../../../member_chat_screen/data/model/chat_args_model.dart';
import '../../../../member_chat_screen/presentation/view/screens/member_chat_screen.dart';
import '../../../data/model/team_model.dart';
import '../../../presentation/controller/home_cubit.dart';
import 'member_card.dart';

class TeamMembersSection extends StatefulWidget {
  final List<MemberModel> members;

  const TeamMembersSection({super.key, required this.members});

  @override
  State<TeamMembersSection> createState() => _TeamMembersSectionState();
}

class _TeamMembersSectionState extends State<TeamMembersSection> {
  @override
  Widget build(BuildContext context) {
    final cardWidth = (MediaQuery.of(context).size.width - 16.w * 2 - 12.w) / 2;

    return Column(
      children: [
        SizedBox(height: 25.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppTexts.teamMembers, style: AppStyles.white21bold),
            Text('${widget.members.length} ${AppTexts.totalLabel}',
                style: AppStyles.white16bold),
          ],
        ),
        SizedBox(height: 15.h),
        Wrap(
          spacing: 12.w,
          runSpacing: 12.h,
          children: widget.members.map((member) {
            return SizedBox(
              width: cardWidth,
              child: MemberCard(
                member: member,
                onMessagePressed: () => _openChat(context, member),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Future<void> _openChat(BuildContext context, MemberModel member) async {
    final storedChatId = await StorageHelper.getMemberChatId(member.id ?? '');
    final effectiveChatId = member.chatId ?? storedChatId;

    if (!context.mounted) return;

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MemberChatScreen(
          args: ChatArgsModel(
            chatId: effectiveChatId,
            userId: member.id ?? '',
            name: member.fullName ?? '',
            avatar: member.avatarUrl,
            chatType: 0,
            onChatCreated: (newChatId) {
              setState(() => member.chatId = newChatId);
              StorageHelper.saveMemberChatId(
                memberId: member.id ?? '',
                chatId: newChatId,
              );
            },
          ),
        ),
      ),
    );

    if (context.mounted) {
      context.read<HomeCubit>().getMyTeam(silent: true);
    }
  }
}
