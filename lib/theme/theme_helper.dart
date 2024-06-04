import 'dart:ui';
import 'package:flutter/material.dart';
import '../core/app_export.dart';
LightCodeColors get appTheme => ThemeHelper().themeColor();
ThemeData get theme => ThemeHelper().themeData();
/// Helper class for managing themes and colors.

class ThemeHelper {
  // The current app theme
  var _appTheme = PrefUtils().getThemeData();
// A map of custom color themes supported by the app
  Map<String, LightCodeColors> _supportedCustomColor = {
    'lightCode': LightCodeColors()
  };
// A map of color schemes supported by the app
  Map<String, ColorScheme> _supportedColorScheme = {
    'lightCode': ColorSchemes.lightCodeColorScheme
  };
  /// Returns the lightCode colors for the current theme.
  LightCodeColors _getThemeColors() {
    return _supportedCustomColor[_appTheme] ?? LightCodeColors();
  }
  /// Returns the current theme data.
  ThemeData _getThemeData() {
    var colorScheme =
        _supportedColorScheme[_appTheme] ?? ColorSchemes.lightCodeColorScheme;
    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
      textTheme: TextThemes.textTheme(colorScheme),
      scaffoldBackgroundColor: colorScheme.onPrimary,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.secondaryContainer.withOpacity(0.06),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
  /// Returns the lightCode colors for the current theme.
  LightCodeColors themeColor() => _getThemeColors();
  /// Returns the current theme data.
  ThemeData themeData() => _getThemeData();
}
/// Class containing the supported text theme styles.
class TextThemes {
  static TextTheme textTheme(ColorScheme colorScheme) => TextTheme(
        bodyMedium: TextStyle(
          color: colorScheme.secondaryContainer.withOpacity(0.4),
          fontSize: 14.fSize,
          fontFamily: 'SF Pro Text',
          fontWeight: FontWeight.w400,
        ),
        displayMedium: TextStyle(
          color: colorScheme.secondaryContainer,
          fontSize: 40.fSize,
          fontFamily: 'SF Pro Text',
          fontWeight: FontWeight.w700,
        ),
        headlineLarge: TextStyle(
          color: colorScheme.secondaryContainer,
          fontSize: 32.fSize,
          fontFamily: 'SF Pro Text',
          fontWeight: FontWeight.w700,
        ),
        headlineSmall: TextStyle(
          color: colorScheme.secondaryContainer,
          fontSize: 24.fSize,
          fontFamily: 'SF Pro Text',
          fontWeight: FontWeight.w700,
        ),
        labelMedium: TextStyle(
          color: colorScheme.secondaryContainer.withOpacity(0.4),
          fontSize: 10.fSize,
          fontFamily: 'SF Pro Text',
          fontWeight: FontWeight.w600,
        ),
        titleLarge: TextStyle(
          color: colorScheme.secondaryContainer,
          fontSize: 20.fSize,
          fontFamily: 'SF Pro Text',
          fontWeight: FontWeight.w700,
        ),
        titleMedium: TextStyle(
          color: colorScheme.secondaryContainer.withOpacity(0.4),
          fontSize: 16.fSize,
          fontFamily: 'SF Pro Text',
          fontWeight: FontWeight.w500,
        ),
        titleSmall: TextStyle(
          color: colorScheme.secondaryContainer.withOpacity(0.4),
          fontSize: 14.fSize,
          fontFamily: 'SF Pro Text',
          fontWeight: FontWeight.w500,
        ),
      );
}
/// Class containing the supported color schemes.
class ColorSchemes {
  static final lightCodeColorScheme = ColorScheme.light(
    primary: Color(0XFFEC3D30),
    secondaryContainer: Color(0XFF3F4145),
    onPrimary: Color(0XFFF5F5F5),
    onPrimaryContainer: Color(0X7F3D3D3D),
  );
}
/// Class containing custom colors for a lightCode theme.
class LightCodeColors {
  // Black
  Color get black900 => Color(0XFF000000);
// BlueGray
  Color get blueGray400 => Color(0XFF888888);
// White
  Color get whiteA700 => Color(0XFFFFFFFF);
}