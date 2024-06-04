import 'package:flutter/material.dart';
import '../core/app_export.dart';
extension on TextStyle {
 TextStyle get sFProText {
  return copyWith(
   fontFamily: 'SF Pro Text',
  );
 }
 TextStyle get roboto {
  return copyWith(
   fontFamily: 'Roboto',
  );
 }
}
/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.
class CustomTextStyles {
 // Label text style
 static get labelMediumPrimary => theme.textTheme.labelMedium!.copyWith(
    color: theme.colorScheme.primary,
   );
// Title text style
 static get titleMediumOnPrimary => theme.textTheme.titleMedium!.copyWith(
    color: theme.colorScheme.onPrimary,
   );
 static get titleMediumOnPrimarySemiBold =>
   theme.textTheme.titleMedium!.copyWith(
    color: theme.colorScheme.onPrimary,
    fontWeight: FontWeight.w600,
   );
 static get titleMediumPrimary => theme.textTheme.titleMedium!.copyWith(
    color: theme.colorScheme.primary,
   );
 static get titleMediumRoboto => theme.textTheme.titleMedium!.roboto;
 static get titleMediumRobotoOnPrimary =>
   theme.textTheme.titleMedium!.roboto.copyWith(
    color: theme.colorScheme.onPrimary,
   );
 static get titleMediumRobotoSecondaryContainer =>
   theme.textTheme.titleMedium!.roboto.copyWith(
    color: theme.colorScheme.secondaryContainer.withOpacity(0.14),
   );
 static get titleMediumRobotoSecondaryContainer_1 =>
   theme.textTheme.titleMedium!.roboto.copyWith(
    color: theme.colorScheme.secondaryContainer,
   );
 static get titleMediumRoboto_1 => theme.textTheme.titleMedium!.roboto;
 static get titleMediumSecondaryContainer =>
   theme.textTheme.titleMedium!.copyWith(
    color: theme.colorScheme.secondaryContainer,
    fontWeight: FontWeight.w600,
   );
 static get titleMediumSecondaryContainer18 =>
   theme.textTheme.titleMedium!.copyWith(
    color: theme.colorScheme.secondaryContainer,
    fontSize: 18.fSize,
   );
 static get titleMediumSecondaryContainerBold =>
   theme.textTheme.titleMedium!.copyWith(
    color: theme.colorScheme.secondaryContainer,
    fontWeight: FontWeight.w700,
   );
 static get titleMediumSecondaryContainer_1 =>
   theme.textTheme.titleMedium!.copyWith(
    color: theme.colorScheme.secondaryContainer,
   );
 static get titleSmallSemiBold => theme.textTheme.titleSmall!.copyWith(
    fontWeight: FontWeight.w600,
   );
}