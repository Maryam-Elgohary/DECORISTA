import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/views/products_details/UI/user_comment.dart';

class comments_list_listview extends StatelessWidget {
  const comments_list_listview({
    super.key,
    required this.data,
  });

  final List<Map<String, dynamic>>? data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => UserComment(
                commentData: data?[index],
              ),
          separatorBuilder: (context, index) => const Divider(
                color: AppColors.lightBeige,
              ),
          itemCount: data?.length ?? 0),
    );
  }
}
