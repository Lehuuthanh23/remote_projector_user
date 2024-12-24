import 'package:flutter/material.dart';

import '../../../../constants/app_color.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final bool isPasswordFields;
  final String? labelText;
  final String obscuringCharacter;
  final TextInputAction? textInputAction;
  final TextStyle? labelStyle;
  final TextStyle? style;
  final Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;

  const MyTextField({
    super.key,
    required this.controller,
    this.isPasswordFields = false,
    this.obscuringCharacter = '*',
    this.labelText,
    this.textInputAction,
    this.labelStyle,
    this.style,
    this.validator,
    this.onFieldSubmitted,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool _obscureText = false;

  @override
  void initState() {
    if (widget.isPasswordFields) {
      _toggleObscureText(toggle: true);
    }

    super.initState();
  }

  void _toggleObscureText({bool? toggle}) {
    setState(() {
      _obscureText = toggle ?? !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      onFieldSubmitted: widget.onFieldSubmitted,
      obscureText: _obscureText,
      obscuringCharacter: widget.obscuringCharacter,
      decoration: InputDecoration(
        labelText: widget.labelText,
        suffixIcon: widget.isPasswordFields
            ? IconButton(
                onPressed: _toggleObscureText,
                color: AppColor.white,
                icon: Icon(
                  _obscureText
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 20,
                  color: AppColor.navUnSelect,
                ),
              )
            : null,
      ),
      textInputAction: widget.textInputAction ?? TextInputAction.done,
    );
  }
}
