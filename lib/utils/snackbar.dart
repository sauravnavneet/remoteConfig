import 'package:flutter/material.dart';
import 'package:interview_task/core/theme/colors.dart';

// custom snackbar to show successfull message
void showSnackBar({required String message, required BuildContext context}) {
  ScaffoldMessenger.of(context)
    ..clearSnackBars()
    ..showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: AppColor.white,
            fontSize: 10,
            fontWeight: FontWeight.w400,
          ),
        ),
        elevation: 5,
        duration: const Duration(seconds: 1),
        backgroundColor: AppColor.snackbar,
      ),
    );
}
