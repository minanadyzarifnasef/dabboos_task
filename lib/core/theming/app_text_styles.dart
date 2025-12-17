import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  static TextStyle get font12GreyMedium => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textGrey,
  );

  static TextStyle get font12GreyRegular => GoogleFonts.inter(
    fontSize: 12,
    color: AppColors.textLightGrey,
  );
  
  static TextStyle get font12BlueRegular => GoogleFonts.inter(
    fontSize: 12,
    color: Colors.blue.shade500,
  );

  static TextStyle get font14GreyRegular => GoogleFonts.inter(
    fontSize: 14,
    color: AppColors.textGrey,
    height: 1.5,
  );

  static TextStyle get font16BlackBold => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.textBlack,
  );

  static TextStyle get font18BlackSemiBold => GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textGrey, // Based on use case in empty state
  );

   static TextStyle get font18BlackW600 => GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textBlack, // For modal title
  );

  static TextStyle get font20BlackBold => GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.textBlack,
  );

  static TextStyle get appBarTitle => GoogleFonts.inter(
    color: AppColors.textBlack,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );
}
