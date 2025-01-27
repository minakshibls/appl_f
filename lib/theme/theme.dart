import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/colors.dart';

ThemeData lightMode = ThemeData(
    fontFamily: GoogleFonts.workSans().fontFamily,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: AppColors.primaryColor,
      primary: AppColors.primaryColor,
      primaryFixedDim: AppColors.primaryText,
      surface: AppColors.primaryColorDark,
      onPrimary: AppColors.textOnPrimary,
      secondary: AppColors.titleColor,
      onSecondary: AppColors.textColor,
      primaryContainer: AppColors.boxBgColor,
      secondaryContainer: AppColors.boxBgColorLight,
      onPrimaryContainer: AppColors.iconColor,
      onTertiary: AppColors.unselectedColor,
    ),
    primaryColor: AppColors.primaryColor,
    primaryColorDark: AppColors.primaryColorDark,
    scaffoldBackgroundColor: AppColors.textOnPrimary,
    useMaterial3: true);

ThemeData darkMode = ThemeData(
    fontFamily: GoogleFonts.workSans().fontFamily,
    primaryColor: AppColorsDark.primaryColor,
    primaryColorDark: AppColorsDark.primaryColorDark,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: AppColorsDark.primaryColor,
      primary: AppColorsDark.primaryColor,
      surface: AppColorsDark.primaryColorDark,
      onPrimary: AppColorsDark.textOnPrimary,
      secondary: AppColorsDark.titleColor,
      onSecondary: AppColorsDark.textColor,
      primaryContainer: AppColorsDark.boxBgColor,
      secondaryContainer: AppColorsDark.boxBgColorLight,
      onPrimaryContainer: AppColorsDark.iconColor,
      onTertiary: AppColorsDark.unselectedColor,
    ),
    scaffoldBackgroundColor: AppColorsDark.scaffold,
    useMaterial3: true);
