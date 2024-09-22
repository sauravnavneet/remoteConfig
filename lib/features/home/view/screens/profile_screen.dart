import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interview_task/core/providers/current_user_provider.dart';
import 'package:interview_task/core/theme/colors.dart';
import 'package:interview_task/core/theme/decorations.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    return SafeArea(
      child: Container(
        decoration: Decorations.buildBoxDecoration(
          gradient1: AppColor.scaffoldBackground2,
          gradient2: AppColor.scaffoldBackground3,
        ),
        child: Scaffold(
          backgroundColor: AppColor.transparent,
          extendBodyBehindAppBar: true,
          extendBody: true,
          appBar: appBar(context),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  infoText(label: 'Name', value: currentUser?.name ?? ''),
                  const SizedBox(
                    height: 15,
                  ),
                  infoText(label: 'Email', value: currentUser?.email ?? ''),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

// custom appbar
  PreferredSizeWidget appBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.transparent,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(
          Icons.arrow_back,
          size: 30,
          color: AppColor.white,
        ),
      ),
      centerTitle: true,
      title: const Text(
        'Profile',
        style: TextStyle(
          color: AppColor.text2,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

// custom info widget
  Widget infoText({required String label, required String value}) {
    return RichText(
      text: TextSpan(
        text: '$label : ',
        style: const TextStyle(
          fontStyle: FontStyle.italic,
          color: Colors.grey,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
        children: [
          TextSpan(
            text: value,
            style: const TextStyle(
              fontStyle: FontStyle.normal,
              color: AppColor.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
