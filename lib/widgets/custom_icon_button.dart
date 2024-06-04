import 'package:flutter/material.dart';
import '../core/app_export.dart';
extension IconButtonStyleHelper on CustomIconButton {
  static BoxDecoration get fillPrimary => BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(16.h),
      );
  static BoxDecoration get fillPrimaryTL8 => BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.14),
        borderRadius: BorderRadius.circular(8.h),
      );
}
class CustomIconButton extends StatelessWidget {
  CustomIconButton(
      {Key? key,
      this.alignment,
      this.height,
      this.width,
      this.padding,
      this.decoration,
      this.child,
      this.onTap})
      : super(
          key: key,
        );
  final Alignment? alignment;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final BoxDecoration? decoration;
  final Widget? child;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center, child: iconButtonWidget)
        : iconButtonWidget;
  }
  Widget get iconButtonWidget => SizedBox(
        height: height ?? 0,
        width: width ?? 0,
        child: IconButton(
          padding: EdgeInsets.zero,
          icon: Container(
            height: height ?? 0,
            width: width ?? 0,
            padding: padding ?? EdgeInsets.zero,
            decoration: decoration ??
                BoxDecoration(
                  color: theme.colorScheme.secondaryContainer.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(8.h),
                ),
            child: child,
          ),
          onPressed: onTap,
        ),
      );
}