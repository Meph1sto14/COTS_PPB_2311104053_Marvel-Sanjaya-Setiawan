import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTypography {
  static const TextStyle title = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600, // SemiBold
    color: AppColors.text,
  );

  static const TextStyle section = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600, // SemiBold
    color: AppColors.text,
  );

  static const TextStyle body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal, // Regular
    color: AppColors.text,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal, // Regular
    color: AppColors.muted,
  );
  
  // Button style biasanya diterapkan langsung pada widget Button, 
  // tapi bisa didefinisikan dasarnya di sini.
  static const TextStyle button = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600, // SemiBold
    color: AppColors.surface,
  );
}