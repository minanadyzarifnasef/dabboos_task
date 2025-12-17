import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../data/models/follow_up.dart';

class FilterModal extends StatelessWidget {
  final FollowUpStatus? currentFilter;
  final Function(FollowUpStatus?) onFilterSelected;

  const FilterModal({
    super.key,
    required this.currentFilter,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container( // Handle unsafe area properly in parent or here
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'filter_title'.tr(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildFilterOption(context, 'filter_all'.tr(), null),
          _buildFilterOption(context, 'status_completed'.tr(), FollowUpStatus.completed),
          _buildFilterOption(context, 'status_scheduled'.tr(), FollowUpStatus.scheduled),
          _buildFilterOption(context, 'status_no_status'.tr(), FollowUpStatus.noStatus),
          const SizedBox(height: 24), // Add some bottom padding safely
        ],
      ),
    );
  }

  Widget _buildFilterOption(BuildContext context, String label, FollowUpStatus? status) {
    final isSelected = currentFilter == status;
    return InkWell(
      onTap: () {
        onFilterSelected(status);
        Navigator.pop(context);
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.deepPurple.shade50 : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.deepPurple : Colors.grey.shade200,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.check_circle : Icons.circle_outlined,
              color: isSelected ? Colors.deepPurple : Colors.grey.shade400,
              size: 20,
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected ? Colors.deepPurple : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
