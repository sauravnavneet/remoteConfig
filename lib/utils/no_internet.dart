import 'package:flutter/material.dart';
import 'package:interview_task/utils/loader.dart';

// Screen to display when no internet is detected
class NoInternet extends StatelessWidget {
  const NoInternet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.signal_wifi_connected_no_internet_4,
              size: 55,
              color: Colors.black54,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'No internet',
              style: TextStyle(
                fontSize: 15,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Loader(),
          ],
        ),
      ),
    );
  }
}
