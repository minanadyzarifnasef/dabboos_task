import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../data/models/follow_up.dart';

class StatusBadge extends StatelessWidget {
  final FollowUpStatus status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    String text;

    switch (status) {
      case FollowUpStatus.completed:
        color = Colors.green.shade600;
        text = 'status_completed'.tr();
        break;
      case FollowUpStatus.scheduled:
        color = Colors.orange.shade600;
        text = 'status_scheduled'.tr();
        break;
      case FollowUpStatus.noStatus:
        color = Colors.grey.shade400;
        text = 'status_no_status'.tr();
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
