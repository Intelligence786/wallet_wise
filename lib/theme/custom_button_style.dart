import 'package:flutter/material.dart';
import '../core/app_export.dart';
/// A class that offers pre-defined button styles for customizing button appearance.
class CustomButtonStyles {
  // Filled button style
  static ButtonStyle get fillPrimary => ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.h),
        ),
      );
  static ButtonStyle get fillPrimaryTL8 => ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.h),
        ),
      );
  static ButtonStyle get fillSecondaryContainerTL16 => ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.secondaryContainer.withOpacity(0.06),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.h),
        ),
      );

  static ButtonStyle get fillNewsButton => ElevatedButton.styleFrom(
    backgroundColor: appTheme.whiteA700.withOpacity(0.6),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.h),
    ),
  );
// text button style
  static ButtonStyle get none => ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        elevation: MaterialStateProperty.all<double>(0),
      );
}