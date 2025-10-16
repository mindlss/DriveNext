import 'package:flutter/material.dart';
import 'colors.dart';

class AppTypography {
  static const h1 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const h2 = TextStyle(
    fontSize: 24,
    height: 32 / 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const h3 = TextStyle(
    fontSize: 14,
    height: 24 / 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  static const input = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 24 / 14,
    letterSpacing: 0.0,
    color: AppColors.textSecondary,
  );

  static const filledButton = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 24 / 14,
    letterSpacing: 0.0,
    color: AppColors.textPrimary,
  );

  static const textButton = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 20 / 14,
    letterSpacing: 0.0,
    color: AppColors.textPrimary,
  );

  static const inputError = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 20 / 14,
    letterSpacing: 0.0,
    color: AppColors.error,
  );

  static const title = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const body = TextStyle(fontSize: 16, color: AppColors.textPrimary);

  static const bodySecondary = TextStyle(
    fontSize: 16,
    color: AppColors.textSecondary,
  );
}
