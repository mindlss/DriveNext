import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/typography.dart';
import '../theme/radius.dart';

class AppTextField extends StatefulWidget {
  final String label;
  final String? hint;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;

  const AppTextField({
    super.key,
    required this.label,
    required this.controller,
    this.hint,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.onChanged,
  });

  @override
  AppTextFieldState createState() => AppTextFieldState();
}

class AppTextFieldState extends State<AppTextField> {
  late bool _obscure;
  String? _errorText;
  bool _hasError = false;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  bool _validate(String? value) {
    if (widget.validator != null) {
      final error = widget.validator!(value);
      setState(() {
        _errorText = error;
        _hasError = error != null && error.isNotEmpty;
      });
      return !_hasError;
    }
    setState(() {
      _errorText = null;
      _hasError = false;
    });
    return true;
  }

  bool isValid() {
    _validate(widget.controller.text);
    return _errorText == null || _errorText!.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    Widget? suffixIcon;
    if (_hasError) {
      if (widget.obscureText) {
        suffixIcon = IconButton(
          icon: Icon(
            _obscure
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: AppColors.iconSecondary,
            size: 16,
          ),
          onPressed: () => setState(() => _obscure = !_obscure),
        );
      } else {
        suffixIcon = const Icon(
          Icons.error_outline,
          color: AppColors.error,
          size: 18,
        );
      }
    } else if (widget.obscureText) {
      suffixIcon = IconButton(
        icon: Icon(
          _obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
          color: AppColors.iconSecondary,
          size: 16,
        ),
        onPressed: () => setState(() => _obscure = !_obscure),
      );
    }

    final borderSide = BorderSide(
      color: _hasError ? AppColors.error : AppColors.border,
      width: 1.2,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: AppTypography.input.copyWith(
            color: AppColors.textLabel,
            height: 20 / 14,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          focusNode: _focusNode,
          controller: widget.controller,
          obscureText: _obscure,
          cursorHeight: 14,
          cursorWidth: 1,
          cursorColor: AppColors.textSecondary,
          keyboardType: widget.keyboardType,
          onChanged: (value) {
            _validate(value);
            if (widget.onChanged != null) widget.onChanged!(value);
          },
          validator: (value) {
            _validate(value);
            return null;
          },
          style: AppTypography.input.copyWith(color: AppColors.textPrimary),
          decoration: InputDecoration(
            hintText: !_focusNode.hasFocus ? widget.hint : null,
            hintStyle: AppTypography.input.copyWith(
              color: AppColors.textSecondary,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 10,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.small),
              borderSide: borderSide,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.small),
              borderSide: borderSide,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.small),
              borderSide: BorderSide(
                color: _hasError ? AppColors.error : AppColors.border,
                width: 1.2,
              ),
            ),
            suffixIcon: suffixIcon,
          ),
        ),
        if (_errorText != null && _errorText!.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            _errorText!,
            style: AppTypography.inputError.copyWith(color: AppColors.error),
          ),
        ],
      ],
    );
  }
}
