import 'dart:math';

import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';

class UserComment extends StatelessWidget {
  const UserComment({
    super.key,
    required this.commentData,
  });
  final Map<String, dynamic>? commentData;
  Color getRandomColor() {
    Random random = Random();
    return Color.fromARGB(
      100, // Alpha (fully opaque)
      random.nextInt(256), // Red
      random.nextInt(256), // Green
      random.nextInt(256), // Blue
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.1,
          child: CircleAvatar(
            backgroundColor: getRandomColor(),
            radius: 20,
            child: Text(commentData?["user_name"][0]),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              commentData?["user_name"] ?? "User Name",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: AppColors.darkBrown),
            ),
            Text(
              commentData?["comment"] ?? "comment",
              style: TextStyle(color: AppColors.darkBrown),
            ),
          ],
        ),
      ],
    );
  }
}
