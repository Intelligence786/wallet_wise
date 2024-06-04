import 'package:flutter/material.dart';
import 'package:wallet_wise/core/app_export.dart';

class NumberLoadingAnimation extends StatefulWidget {
  final TextStyle? textStyle;

  NumberLoadingAnimation({super.key, this.textStyle});

  @override
  _NumberLoadingAnimationState createState() => _NumberLoadingAnimationState();
}

class _NumberLoadingAnimationState extends State<NumberLoadingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Text(
          (_controller.value * 100).toInt().toString(),
          style: widget.textStyle ??
              CustomTextStyles.titleMediumSecondaryContainer,
        );
      },
    );
  }
}

class AnimatedNumberDisplay extends StatelessWidget {
  final double endValue;
  final TextStyle? textStyle;

  const AnimatedNumberDisplay(
      {Key? key, required this.endValue, this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: endValue),
      duration: Duration(milliseconds: 800),
      builder: (context, value, child) {
        return Text(
          '\$${value.toInt()}',
          style: textStyle ?? CustomTextStyles.titleMediumSecondaryContainer,
        );
      },
    );
  }
}
