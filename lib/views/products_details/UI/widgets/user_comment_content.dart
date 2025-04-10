import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';

class product_details_comment_content extends StatelessWidget {
  const product_details_comment_content({
    super.key,
    required this.commentData,
  });

  final Map<String, dynamic>? commentData;

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
