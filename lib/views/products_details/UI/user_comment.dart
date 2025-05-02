import 'package:flutter/material.dart';
import 'package:furniture_app/views/home/UI/widgets/home_circle_avatar_row.dart';
import 'package:furniture_app/views/products_details/UI/widgets/user_comment_content.dart';

class UserComment extends StatelessWidget {
  const UserComment({
    super.key,
    required this.commentData,
  });
  final Map<String, dynamic>? commentData;

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
        product_details_comment_content(commentData: commentData),
      ],
    );
  }
}
