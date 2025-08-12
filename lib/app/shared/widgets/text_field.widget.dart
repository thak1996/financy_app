import 'package:financy_app/app/shared/consts/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app.colors.dart';

class TextFieldWidget extends StatefulWidget {
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextEditingController controller;
  final bool enableSuggestions;
  final String? helperText;
  final TextInputFormatter? inputFormatter;
  final bool isPassword;
  final TextInputType? keyboardType;
  final String label;
  final TextInputAction? textInputAction;

  const TextFieldWidget({
    super.key,
    required this.controller,
    required this.label,
    this.isPassword = false,
    this.validator,
    this.keyboardType,
    this.enableSuggestions = false,
    this.textInputAction,
    this.inputFormatter,
    this.onChanged,
    this.helperText,
  });

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.controller,
          obscureText: widget.isPassword && _obscureText,
          keyboardType: widget.keyboardType,
          keyboardAppearance:
              Theme.of(context).brightness == Brightness.dark
                  ? Brightness.dark
                  : Brightness.light,
          enableSuggestions: widget.enableSuggestions,
          autocorrect: widget.enableSuggestions,
          textInputAction: widget.textInputAction,
          inputFormatters:
              widget.inputFormatter != null ? [widget.inputFormatter!] : null,
          style: AppTextStyles.text14(
            context,
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
          onChanged: (value) {
            if (value.length == 1) {
              setState(() => _helperText = null);
            } else if (value.isEmpty) {
              setState(() => _helperText = widget.helperText);
            }
          },
          decoration: InputDecoration(
            labelText: widget.label.toUpperCase(),
            labelStyle: AppTextStyles.text14(
              context,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
            helperText: _helperText,
            helperMaxLines: 3,
            helperStyle: AppTextStyles.text12(
              context,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
            suffixIcon:
                widget.isPassword
                    ? IconButton(
                      icon: Icon(
                        size: 22,
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: AppColors.textPrimary,
                      ),
                      onPressed: _toggleObscureText,
                    )
                    : null,
          ),
          validator:
              widget.validator ??
              (value) => value?.isEmpty ?? true ? 'Campo obrigatório' : null,
        ),
      ],
    );
  }

  String? _helperText;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _helperText = widget.helperText;
  }

  void _toggleObscureText() => setState(() => _obscureText = !_obscureText);
}
