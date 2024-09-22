import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interview_task/core/theme/colors.dart';

// custom button
class CustomButton extends ConsumerWidget {
  const CustomButton({
    super.key,
    required this.handleLogin,
    required this.buttonText,
    required this.size,
  });

  final void Function() handleLogin;
  final String buttonText;
  final Size size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: size.width * 0.7,
      height: 60,
      child: ElevatedButton(
        onPressed: handleLogin,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.button,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          buttonText,
          style: const TextStyle(
            color: AppColor.white,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
