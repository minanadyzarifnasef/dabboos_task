import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_dimens.dart';
import '../../../../core/theming/app_text_styles.dart';
import '../../data/models/follow_up.dart';
import 'status_badge.dart';
import '../screens/follow_up_detail_loader_screen.dart';

class FollowUpCard extends StatelessWidget {
  final FollowUp followUp;

  const FollowUpCard({super.key, required this.followUp});

  String _parseHtmlString(String htmlString) {
    final unescape = HtmlUnescape();
    var text = htmlString.replaceAll(RegExp(r'<[^>]*>'), '');
    return unescape.convert(text);
  }

  IconData _getTypeIcon(FollowUpType type) {
    switch (type) {
      case FollowUpType.call:
        return Icons.phone_outlined;
      case FollowUpType.meeting:
        return Icons.groups_outlined;
      case FollowUpType.visit:
        return Icons.location_on_outlined;
    }
  }

  Color _getTypeColor(FollowUpType type) {
    switch (type) {
      case FollowUpType.call:
        return AppColors.typeCall;
      case FollowUpType.meeting:
        return AppColors.typeMeeting;
      case FollowUpType.visit:
        return AppColors.typeVisit;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to details
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => FollowUpDetailLoaderScreen(followUp: followUp),
          ),
        );
      },
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimens.radius16),
          side: const BorderSide(color: AppColors.divider),
        ),
        margin: const EdgeInsets.symmetric(horizontal: AppDimens.padding16, vertical: AppDimens.padding8),
        color: AppColors.cardBackground,
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.padding16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(AppDimens.padding8),
                        decoration: BoxDecoration(
                          color: _getTypeColor(followUp.type).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(AppDimens.radius8),
                        ),
                        child: Icon(
                          _getTypeIcon(followUp.type),
                          color: _getTypeColor(followUp.type),
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: AppDimens.padding12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            followUp.customerName ?? 'unknown_customer'.tr(),
                            style: AppTextStyles.font12GreyMedium,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            followUp.title,
                            style: AppTextStyles.font16BlackBold,
                          ),
                        ],
                      ),
                    ],
                  ),
                  StatusBadge(status: followUp.status),
                ],
              ),
              const SizedBox(height: AppDimens.padding12),
              Text(
                _parseHtmlString(followUp.description),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.font14GreyRegular,
              ),
              if (followUp.scheduledDate != null) ...[
                const SizedBox(height: AppDimens.padding12),
                const Divider(color: AppColors.divider),
                const SizedBox(height: AppDimens.padding8),
                Row(
                  children: [
                    const Icon(Icons.calendar_today_outlined, size: 14, color: AppColors.textGrey),
                    const SizedBox(width: 6),
                    Text(
                      'due_date'.tr(args: [followUp.scheduledDate.toString().split(' ')[0]]), 
                      style: AppTextStyles.font12GreyRegular,
                    ),
                  ],
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
