import 'package:flutter/material.dart';

import 'package:interview_task/core/models/post_model.dart';
import 'package:interview_task/core/theme/colors.dart';

class PostCard extends StatelessWidget {
  final PostModel post;
  final bool maskMail;

  const PostCard({
    super.key,
    required this.post,
    required this.maskMail,
  });

  String getMaskEmail(String email, bool maskMail) {
    if (!maskMail) return email;
    int atIndex = email.indexOf('@');
    String masked =
        email.substring(0, 3) + '*' * (atIndex - 3) + email.substring(atIndex);
    return masked;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColor.white,
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: AppColor.text,
              child: Text(
                post.name[0].toUpperCase(),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  infoText(
                    label: 'Name',
                    value: post.name,
                  ),
                  const SizedBox(height: 8),
                  infoText(
                    label: 'Email',
                    value: getMaskEmail(
                      post.email,
                      maskMail,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    post.comments,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget infoText({required String label, required String value}) {
    return RichText(
      text: TextSpan(
        text: '$label : ',
        style: const TextStyle(
          fontStyle: FontStyle.italic,
          color: Colors.grey,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
        children: [
          TextSpan(
            text: value,
            style: const TextStyle(
              fontStyle: FontStyle.normal,
              color: AppColor.black,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
