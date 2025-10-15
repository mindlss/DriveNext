import 'package:flutter/material.dart';
import 'colors.dart';
import 'typography.dart';
import 'radius.dart';
import 'spacing.dart';

ThemeData getAppTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: 'Montserrat',

    // Основные цвета приложения
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: Colors.white,
      secondary: AppColors.secondary,
      onSecondary: Colors.white,
      error: AppColors.error,
      onError: Colors.white,
      surface: Colors.white,
      onSurface: AppColors.textPrimary,
    ),

    scaffoldBackgroundColor: AppColors.background,
    primaryColor: AppColors.primary,

    // Текстовые стили
    textTheme: TextTheme(
      displayLarge: AppTypography.h1,
      displayMedium: AppTypography.h2,
      titleLarge: AppTypography.title,
      bodyLarge: AppTypography.body,
      bodyMedium: AppTypography.bodySecondary,
      labelLarge: AppTypography.button,
    ),

    // Стили кнопок
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        textStyle: AppTypography.button,
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.large,
          horizontal: AppSpacing.large,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.small),
        ),
      ),
    ),

    // Текстовые поля
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      labelStyle: AppTypography.input,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.small),
        borderSide: BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.small),
        borderSide: BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.small),
        borderSide: BorderSide(color: AppColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.small),
        borderSide: BorderSide(color: AppColors.error),
      ),
      hintStyle: AppTypography.bodySecondary.copyWith(
        color: AppColors.textSecondary,
      ),
    ),

    // Карточки
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.medium),
      ),
      margin: const EdgeInsets.all(AppSpacing.medium),
    ),

    // Диалоги
    dialogTheme: DialogThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.medium),
      ),
      backgroundColor: Colors.white,
      titleTextStyle: AppTypography.title,
      contentTextStyle: AppTypography.body,
    ),
  );
}
