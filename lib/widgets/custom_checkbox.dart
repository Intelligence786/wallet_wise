import 'package:flutter/material.dart';
import 'package:wallet_wise/core/app_export.dart';

class CustomCheckbox extends StatefulWidget {
  const CustomCheckbox({
    key,
    required this.title,
    this.width = 24.0,
    this.height = 56.0,
    this.color,
    this.iconSize = 24.0,
    this.onChanged,
    this.checkColor,
    this.isChecked = false,
    this.imagePath = '',
  });

  final String title;
  final String imagePath;
  final double width;
  final double height;
  final Color? color;
  final bool isChecked;
  final double? iconSize;
  final Color? checkColor;
  final void Function(bool?)? onChanged;

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  late final _theme = Theme.of(context);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: widget.isChecked
          ? AppDecoration.fillPrimary
          : AppDecoration.fillSecondaryContainer,
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        customBorder: Border(
          bottom: BorderSide(color: _theme.dividerColor),
        ),
        onTap: () {
          //  setState(() => widget.isChecked = !widget.isChecked);
          widget.onChanged?.call(widget.isChecked);
        },
        child: Padding(
          padding: EdgeInsets.all(8.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.all(8.h),
                decoration: AppDecoration.fillSecondaryContainer,
                child: CustomImageView(
                  imagePath: widget.imagePath,
                  color: widget.isChecked
                      ? _theme.colorScheme.onPrimary
                      : appTheme.black900.withOpacity(0.4),
                ),
              ),
              SizedBox(
                width: 8.h,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.title,
                    style: widget.isChecked
                        ? CustomTextStyles.titleMediumRobotoOnPrimary
                        : CustomTextStyles.titleMediumRoboto,
                  ),
                ),
              ),
              CustomImageView(
                imagePath: widget.isChecked
                    ? ImageConstant.imgCheck
                    : ImageConstant.imgCheckDisabled,
                color: widget.isChecked
                    ? _theme.colorScheme.onPrimary
                    : appTheme.black900.withOpacity(0.1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
