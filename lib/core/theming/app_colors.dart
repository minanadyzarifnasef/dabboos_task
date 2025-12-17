import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF6750A4);
  static const Color background = Color(0xFFF8F9FA);
  static const Color cardBackground = Colors.white;
  static const Color textBlack = Colors.black87;
  static const Color textGrey = Color(0xFF757575); // Colors.grey.shade600 usually
  static const Color textLightGrey = Color(0xFFBDBDBD); // Colors.grey.shade400
  static const Color divider = Color(0xFFF5F5F5); // Colors.grey.shade100
  static const Color error = Color(0xFFE57373); // Colors.red.shade300

  // Status Colors
  static const Color statusCompleted = Color(0xFF43A047); // Colors.green.shade600
  static const Color statusScheduled = Color(0xFFFB8C00); // Colors.orange.shade600
  static const Color statusNoStatus = Color(0xFFBDBDBD); // Colors.grey.shade400

  // Type Colors
  static const Color typeCall = Colors.blue;
  static const Color typeMeeting = Colors.purple;
  static const Color typeVisit = Colors.red;

  // Shadow
  static Color shadow = Colors.black.withValues(alpha: 0.05);
}
