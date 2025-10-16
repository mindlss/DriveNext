import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/typography.dart';

class AppTextButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final TextStyle? style;
  final Alignment alignment;
  final Color? pressedColor;

  const AppTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.style,
    this.alignment = Alignment.center,
    this.pressedColor,
  });

  @override
  State<AppTextButton> createState() => _AppTextButtonState();
}

class _AppTextButtonState extends State<AppTextButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final defaultStyle =
        widget.style ??
        AppTypography.textButton.copyWith(color: AppColors.primary);

    return Align(
      alignment: widget.alignment,
      widthFactor: 1,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) {
          setState(() => _pressed = false);
          widget.onPressed();
        },
        onTapCancel: () => setState(() => _pressed = false),
        child: AnimatedDefaultTextStyle(
          style: defaultStyle.copyWith(
            color: _pressed
                ? (widget.pressedColor ??
                      defaultStyle.color?.withAlpha((0.7 * 255).round()))
                : defaultStyle.color,
          ),
          duration: const Duration(milliseconds: 100),
          child: Text(widget.text),
        ),
      ),
    );
  }
}
