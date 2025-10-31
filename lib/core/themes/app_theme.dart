import 'package:builder_bloc_template/core/constants/app_color.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final colorScheme = ColorScheme.fromSeed(seedColor: AppColor.primary);
  static final lightColorScheme = const ColorScheme.light().copyWith(
    primary: AppColor.primary,
    secondary: AppColor.secondary,
    primaryContainer: AppColor.primary100,
    tertiary: AppColor.tertiary
  );
  static final darkColorScheme = const ColorScheme.dark().copyWith(
    primary: AppColor.primary,
    secondary: AppColor.secondary,
    primaryContainer: AppColor.primary900,
    tertiary: const Color(0xFF74FEAC)
  );
}