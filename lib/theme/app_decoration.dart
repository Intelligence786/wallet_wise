import 'package:flutter/material.dart';
import '../core/app_export.dart';
class AppDecoration {
  // Fill decorations
  static BoxDecoration get fillOnPrimary => BoxDecoration(
        color: theme.colorScheme.onPrimary,
      );
  static BoxDecoration get fillOnPrimary1 => BoxDecoration(
        color: theme.colorScheme.onPrimary.withOpacity(0.08),
      );
  static BoxDecoration get fillPrimary => BoxDecoration(
        color: theme.colorScheme.primary,
      borderRadius: BorderRadiusStyle.roundedBorder12
      );
  static BoxDecoration get fillSecondaryContainer => BoxDecoration(
        color: theme.colorScheme.secondaryContainer.withOpacity(0.06),
    borderRadius: BorderRadiusStyle.roundedBorder12
      );
  static BoxDecoration get fillWhiteA => BoxDecoration(
        color: appTheme.whiteA700,
      );
}
class BorderRadiusStyle {
  // Custom borders
  static BorderRadius get customBorderTL10 => BorderRadius.vertical(
        top: Radius.circular(10.h),
      );
// Rounded borders
  static BorderRadius get roundedBorder12 => BorderRadius.circular(
        12.h,
      );
  static BorderRadius get roundedBorder16 => BorderRadius.circular(
        16.h,
      );
  static BorderRadius get roundedBorder8 => BorderRadius.circular(
        8.h,
      );
}