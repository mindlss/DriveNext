import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/typography.dart';

enum FilledButtonStyle { primary, secondary, social }

class AppFilledButton extends StatefulWidget {
  final Widget? icon;
  final String label;
  final FilledButtonStyle style;
  final VoidCallback onPressed;
  final Alignment alignment;
  final bool disabled;

  const AppFilledButton({
    super.key,
    this.icon,
    required this.label,
    required this.onPressed,
    this.style = FilledButtonStyle.primary,
    this.alignment = Alignment.center,
    this.disabled = false,
  });

  @override
  State<AppFilledButton> createState() => _AppFilledButtonState();
}

class _AppFilledButtonState extends State<AppFilledButton> {
  bool _pressed = false;

  MainAxisAlignment _getMainAxisAlignment() {
    if (widget.alignment == Alignment.centerLeft) {
      return MainAxisAlignment.start;
    }
    if (widget.alignment == Alignment.centerRight) {
      return MainAxisAlignment.end;
    }
    return MainAxisAlignment.center;
  }

  Color _getBackgroundColor() {
    switch (widget.style) {
      case FilledButtonStyle.primary:
        if (widget.disabled) return AppColors.buttonPrimaryDisabled;
        return _pressed
            ? AppColors.buttonPrimaryClicked
            : AppColors.buttonPrimaryNormal;
      case FilledButtonStyle.secondary:
        if (widget.disabled) return AppColors.secondaryButtonPrimaryDisabled;
        return _pressed
            ? AppColors.secondaryButtonPrimaryClicked
            : AppColors.secondaryButtonPrimaryNormal;
      case FilledButtonStyle.social:
        if (widget.disabled) return AppColors.socialButtonPrimaryDisabled;
        return _pressed
            ? AppColors.socialButtonPrimaryClicked
            : AppColors.socialButtonPrimaryNormal;
    }
  }

  Color _getForegroundColor() {
    switch (widget.style) {
      case FilledButtonStyle.primary:
        if (widget.disabled) return AppColors.buttonFGDisabled;
        return _pressed ? AppColors.buttonFGClicked : AppColors.buttonFGNormal;
      case FilledButtonStyle.secondary:
        if (widget.disabled) return AppColors.secondaryButtonFGDisabled;
        return _pressed
            ? AppColors.secondaryButtonFGClicked
            : AppColors.secondaryButtonFGNormal;
      case FilledButtonStyle.social:
        if (widget.disabled) return AppColors.socialButtonFGDisabled;
        return _pressed
            ? AppColors.socialButtonFGClicked
            : AppColors.socialButtonFGNormal;
    }
  }

  Color _getBorderColor() {
    switch (widget.style) {
      case FilledButtonStyle.primary:
        if (widget.disabled) return AppColors.buttonBorderDisabled;
        return _pressed
            ? AppColors.buttonBorderClicked
            : AppColors.buttonBorderNormal;
      case FilledButtonStyle.secondary:
        if (widget.disabled) return AppColors.secondaryButtonBorderDisabled;
        return _pressed
            ? AppColors.secondaryButtonBorderClicked
            : AppColors.secondaryButtonBorderNormal;
      case FilledButtonStyle.social:
        if (widget.disabled) return AppColors.socialButtonBorderDisabled;
        return _pressed
            ? AppColors.socialButtonBorderClicked
            : AppColors.socialButtonBorderNormal;
    }
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.disabled) return;
    setState(() => _pressed = true);
  }

  void _handleTapUp(TapUpDetails details) async {
    if (widget.disabled) return;

    await Future.delayed(const Duration(milliseconds: 50));
    setState(() => _pressed = false);
    if (mounted) {
      final renderBox = context.findRenderObject() as RenderBox;
      final localPosition = renderBox.globalToLocal(details.globalPosition);
      if (renderBox.size.contains(localPosition)) {
        widget.onPressed();
      }
    }
  }

  void _handleTapCancel() {
    if (widget.disabled) return;
    setState(() => _pressed = false);
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = _getBackgroundColor();
    final fgColor = _getForegroundColor();
    final borderColor = _getBorderColor();

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12.8),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderColor, width: 1.2),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: _getMainAxisAlignment(),
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (widget.icon != null) ...[
              widget.icon!,
              const SizedBox(width: 12),
            ],
            Text(
              widget.label,
              style: AppTypography.filledButton.copyWith(color: fgColor),
            ),
          ],
        ),
      ),
    );
  }
}
