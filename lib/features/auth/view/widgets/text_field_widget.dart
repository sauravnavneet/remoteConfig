import 'package:flutter/material.dart';
import 'package:interview_task/core/theme/colors.dart';
import 'package:interview_task/core/theme/decorations.dart';
import 'package:interview_task/utils/form_validator.dart';

// custom test form field
class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    super.key,
    required this.hintText,
    required this.leadingIcon,
    this.isEmail = true,
    required this.controller,
    required this.isPassword,
  });

  final String hintText;
  final Icon leadingIcon;
  final bool isEmail;
  final bool isPassword;
  final TextEditingController controller;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.isEmail
          ? emailValidator
          : widget.isPassword
              ? passwordValidator
              : nameValidator,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
          ),
          child: widget.leadingIcon,
        ),
        prefixIconColor: AppColor.black,
        suffixIcon: widget.isPassword
            ? IconButton(
                splashColor: Colors.transparent,
                splashRadius: 1,
                onPressed: () {
                  setState(() {
                    showPassword = !showPassword;
                  });
                },
                icon: Icon(
                  showPassword ? Icons.visibility_off : Icons.visibility,
                ),
              )
            : null,
        hintFadeDuration: const Duration(milliseconds: 500),
        hintStyle: const TextStyle(
          color: AppColor.black,
        ),
        filled: true,
        fillColor: AppColor.white,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 20,
        ),
        hoverColor: const Color.fromARGB(255, 2, 65, 98),
        focusedBorder: Decorations.focusedBorder(borderColor: AppColor.valid),
        enabledBorder: Decorations.enabledBorder(borderColor: AppColor.white),
        errorBorder: Decorations.errorBorder(borderColor: AppColor.invalid),
        focusedErrorBorder:
            Decorations.focusedErrorBorder(borderColor: AppColor.invalid),
      ),
      obscureText:
          widget.isEmail || !widget.isPassword || showPassword ? false : true,
      style: const TextStyle(
        color: AppColor.black,
        fontSize: 16,
      ),
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
    );
  }
}
