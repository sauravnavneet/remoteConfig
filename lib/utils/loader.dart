import 'package:flutter/material.dart';
import 'package:interview_task/core/theme/colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

// custom loading indicator
class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.staggeredDotsWave(
      color: AppColor.invalid,
      size: 30,
    );
  }
}
