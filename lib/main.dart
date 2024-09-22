import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:interview_task/core/providers/current_user_provider.dart';
import 'package:interview_task/features/auth/provider/auth_provider.dart';
import 'package:interview_task/features/auth/view/screens/login_signup_screen.dart';
import 'package:interview_task/features/home/view/screens/home_screen.dart';
import 'package:interview_task/firebase_options.dart';
import 'package:interview_task/utils/loader.dart';
import 'package:interview_task/utils/no_internet.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  //setting initial value to remoteConfig
  final remoteConfig = FirebaseRemoteConfig.instance;
  remoteConfig.setDefaults({'maskEmail': false});

  // setting system statusbar color
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
    statusBarColor: Colors.black,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
  ));
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  bool hasInternet = true;

  @override
  void initState() {
    super.initState();

// substription to  internet connectivity stream
    Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      setState(() {
        hasInternet = (result.contains(ConnectivityResult.mobile) ||
            result.contains(ConnectivityResult.mobile));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateChangeProvider);
    final user = ref.watch(currentUserProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Interview Task',
      theme: ThemeData(
        fontFamily: 'Poppins',
        useMaterial3: true,
      ),

      // checking auth stream and displaying homescreen if data and user not null else login screen
      home: hasInternet
          ? authState.when(
              data: (data) {
                if (data != null && user != null) {
                  return const SafeArea(child: HomeScreen());
                } else {
                  return const SafeArea(child: LoginSignupScreen());
                }
              },
              loading: () {
                return const Scaffold(
                  body: Center(
                    child: Loader(),
                  ),
                );
              },
              error: (error, stack) {
                return const Scaffold(
                  body: Center(
                    child: Text('An error occurred, please try again.'),
                  ),
                );
              },
            )
          : const NoInternet(),
    );
  }
}
