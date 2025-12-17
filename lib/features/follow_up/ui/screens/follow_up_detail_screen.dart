import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/app_dimens.dart';
import '../../../../core/theming/app_text_styles.dart';
import '../../data/models/follow_up.dart';
import '../widgets/status_badge.dart';

class FollowUpDetailScreen extends StatelessWidget {
  final FollowUp followUp;

  const FollowUpDetailScreen({super.key, required this.followUp});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('follow_up_details'.tr(), style: AppTextStyles.appBarTitle),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.padding20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderCard(),
              const SizedBox(height: AppDimens.padding20),
              _buildContentCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimens.padding20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppDimens.radius20),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: Colors.deepPurple.shade50,
                child: Text(
                  followUp.customerName?.substring(0, 1).toUpperCase() ?? '?',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple.shade400,
                  ),
                ),
              ),
              const SizedBox(width: AppDimens.padding16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      followUp.customerName ?? 'unknown_customer'.tr(),
                      style: AppTextStyles.font18BlackW600,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'id_label'.tr(args: [followUp.id.substring(0, 8)]),
                      style: AppTextStyles.font12GreyRegular,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.padding24),
          Row(
            children: [
              _buildInfoChip(
                icon: Icons.calendar_today_rounded,
                label: followUp.scheduledDate != null
                    ? followUp.scheduledDate.toString().split(' ')[0]
                    : 'no_date'.tr(),
                color: Colors.blue.shade50,
                textColor: Colors.blue.shade700,
              ),
              const SizedBox(width: AppDimens.padding12),
              _buildInfoChip(
                icon: _getTypeIcon(followUp.type),
                label: 'type_${followUp.type.name}'.tr(),
                color: Colors.orange.shade50,
                textColor: Colors.orange.shade700,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContentCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimens.padding24),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppDimens.radius20),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                followUp.title,
                style: AppTextStyles.font20BlackBold,
              ),
              StatusBadge(status: followUp.status),
            ],
          ),
          const SizedBox(height: AppDimens.padding16),
          const Divider(color: AppColors.divider),
          const SizedBox(height: AppDimens.padding16),
          HtmlWidget(
            followUp.description,
            textStyle: AppTextStyles.font14GreyRegular.copyWith(height: 1.6),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String label,
    required Color color,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.padding12, vertical: AppDimens.padding8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppDimens.radiusCircular),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: textColor),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
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
}
