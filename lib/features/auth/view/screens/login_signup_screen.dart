import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interview_task/constants/app_strings.dart';
import 'package:interview_task/core/theme/colors.dart';
import 'package:interview_task/features/auth/provider/auth_provider.dart';
import 'package:interview_task/features/auth/view/widgets/custom_button.dart';
import 'package:interview_task/features/auth/view/widgets/text_field_widget.dart';
import 'package:interview_task/utils/dialog_box.dart';
import 'package:interview_task/utils/loader.dart';
import 'package:interview_task/utils/snackbar.dart';

class LoginSignupScreen extends ConsumerStatefulWidget {
  const LoginSignupScreen({
    super.key,
  });

  @override
  ConsumerState<LoginSignupScreen> createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends ConsumerState<LoginSignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLogin = true;

// clearing the controller state
  void clearControllerState() {
    emailController.clear();
    passwordController.clear();
    nameController.clear();
  }

// handle signin and sign up
  void handleLoginSignUp() async {
    if (_formKey.currentState!.validate()) {
      if (isLogin) {
        await ref.read(authProviderNotifier.notifier).signIn(
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
            );
      } else {
        await ref.read(authProviderNotifier.notifier).signUp(
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
              name: nameController.text.trim(),
            );
      }

      ref.watch(authProviderNotifier).whenData(
        (res) {
          if (res!.code == 1) {
            showCustomDialog(context, res.message);
          } else {
            clearControllerState();
            setState(() {
              isLogin = true;
            });
            showSnackBar(message: res.message, context: context);
          }
        },
      );
    }
  }

// toggle between signin and signup ui
  void toggleLoginSignUp() {
    clearControllerState();
    setState(() {
      isLogin = !isLogin;
    });
  }

// dispose controllers
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLoading = ref.watch(authProviderNotifier).isLoading;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 219, 224, 250),
      resizeToAvoidBottomInset: false,
      appBar: appBar(size.aspectRatio),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Center(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    if (!isLogin)
                      TextFieldWidget(
                        hintText: AppStrings.name,
                        leadingIcon: const Icon(Icons.abc),
                        controller: nameController,
                        isEmail: false,
                        isPassword: false,
                      ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFieldWidget(
                      hintText: AppStrings.email,
                      leadingIcon: const Icon(Icons.email),
                      controller: emailController,
                      isPassword: false,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFieldWidget(
                      hintText: AppStrings.password,
                      leadingIcon: const Icon(Icons.more_horiz),
                      controller: passwordController,
                      isEmail: false,
                      isPassword: true,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.25,
            ),
            Column(
              children: [
                isLoading
                    ? const Center(
                        child: Loader(),
                      )
                    : CustomButton(
                        buttonText:
                            isLogin ? AppStrings.login : AppStrings.signup,
                        handleLogin: handleLoginSignUp,
                        size: size,
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isLogin
                          ? AppStrings.newHere
                          : AppStrings.alreadyHaveAccount,
                      style: const TextStyle(
                        color: AppColor.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextButton(
                      onPressed: toggleLoginSignUp,
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                      ),
                      child: Text(
                        isLogin ? AppStrings.signup : AppStrings.login,
                        style: const TextStyle(
                          color: AppColor.text,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: size.height * 0.05,
            )
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget appBar(double aspectRatio) {
    return AppBar(
      backgroundColor: AppColor.transparent,
      title: Text(
        AppStrings.comments,
        style: TextStyle(
          color: AppColor.text,
          fontSize: aspectRatio * 60,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
