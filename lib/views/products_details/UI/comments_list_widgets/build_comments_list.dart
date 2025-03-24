import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/views/products_details/UI/user_comment.dart';

Widget buildCommentsList(List<Map<String, dynamic>> comments) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: comments.length,
      separatorBuilder: (context, index) => const Divider(
        color: AppColors.lightBeige,
        height: 24.0,
      ),
      itemBuilder: (context, index) => UserComment(
        commentData: comments[index],
      ),
    ),
  );
}
