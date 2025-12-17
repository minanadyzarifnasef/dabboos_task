import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
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
        return Colors.blue;
      case FollowUpType.meeting:
        return Colors.purple;
      case FollowUpType.visit:
        return Colors.red;
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
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.grey.shade200),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: _getTypeColor(followUp.type).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          _getTypeIcon(followUp.type),
                          color: _getTypeColor(followUp.type),
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            followUp.customerName ?? 'Unknown Customer',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            followUp.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  StatusBadge(status: followUp.status),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                _parseHtmlString(followUp.description),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                  height: 1.5,
                ),
              ),
              if (followUp.scheduledDate != null) ...[
                const SizedBox(height: 12),
                Divider(color: Colors.grey.shade100),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.calendar_today_outlined, size: 14, color: Colors.grey.shade500),
                    const SizedBox(width: 6),
                    Text(
                      'Due: ${followUp.scheduledDate.toString().split(' ')[0]}', 
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
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
