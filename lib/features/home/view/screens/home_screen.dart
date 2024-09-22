import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interview_task/constants/app_strings.dart';
import 'package:interview_task/core/theme/colors.dart';
import 'package:interview_task/core/theme/decorations.dart';
import 'package:interview_task/features/auth/provider/auth_provider.dart';
import 'package:interview_task/features/home/provider/post_provider.dart';
import 'package:interview_task/features/home/view/screens/profile_screen.dart';
import 'package:interview_task/features/home/view/widgets/post_card.dart';
import 'package:interview_task/utils/loader.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool maskEmail = false;

  @override
  void initState() {
    super.initState();

    // initializing the value of mask email from remoteconfig to maskEmail value
    final remoteConfig = FirebaseRemoteConfig.instance;
    remoteConfig.fetchAndActivate().then((_) {
      setState(() {
        maskEmail = remoteConfig.getBool('maskEmail');
      });
    });

    // listening for any changes in remoteconfig value
    remoteConfig.onConfigUpdated.listen((RemoteConfigUpdate data) async {
      await remoteConfig.activate();
      setState(() {
        maskEmail = remoteConfig.getBool('maskEmail');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final postStream = ref.watch(postProvider);
    return Container(
      decoration: Decorations.buildBoxDecoration(
        gradient1: AppColor.scaffoldBackground2,
        gradient2: AppColor.scaffoldBackground3,
      ),
      child: Scaffold(
        backgroundColor: AppColor.transparent,
        appBar: appBar(size.aspectRatio),

        // displaying data with stream of post
        body: postStream.when(
          data: (data) {
            return ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                height: 5,
              ),
              itemCount: data.length,
              itemBuilder: (context, index) => PostCard(
                maskMail: maskEmail,
                post: data[index],
              ),
            );
          },
          error: (_, __) {
            return const Center(
              child: Text('No Data'),
            );
          },
          loading: () {
            return const Center(child: Loader());
          },
        ),
      ),
    );
  }

  // custom appbar
  PreferredSizeWidget appBar(double aspectRatio) {
    return AppBar(
      backgroundColor: AppColor.transparent,
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => const ProfileScreen(),
            ),
          );
        },
        icon: const Icon(
          Icons.person_3_rounded,
          size: 25,
          color: AppColor.white,
        ),
      ),
      title: const Text(
        AppStrings.comments,
        style: TextStyle(
          color: AppColor.text2,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () async {
            await ref.read(authProviderNotifier.notifier).signOut();
          },
          icon: const Icon(
            Icons.power_settings_new_rounded,
            size: 25,
            color: AppColor.white,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
