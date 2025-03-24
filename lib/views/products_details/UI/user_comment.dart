import 'dart:math';

import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';

class UserComment extends StatelessWidget {
  const UserComment({
    super.key,
    required this.commentData,
  });

  final Map<String, dynamic> commentData;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildUserAvatar(),
          const SizedBox(width: 12),
          Expanded(
            child: _buildCommentContent(theme),
          ),
        ],
      ),
    );
  }

  Widget _buildUserAvatar() {
    return CircleAvatar(
      backgroundColor: _generatePastelColor(),
      radius: 20,
      child: Text(
        _getUserInitial(),
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildCommentContent(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          commentData["user_name"] ?? "Anonymous",
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.darkBrown,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          commentData["comment"] ?? "",
          style: theme.textTheme.bodyMedium?.copyWith(
            color: AppColors.darkBrown,
          ),
        ),
      ],
    );
  }

  String _getUserInitial() {
    final userName = commentData["user_name"]?.toString().trim();
    return userName != null && userName.isNotEmpty
        ? userName[0].toUpperCase()
        : "?";
  }

  Color _generatePastelColor() {
    final random = Random(
      (commentData["user_name"]?.hashCode ?? 0) +
          (commentData["comment"]?.hashCode ?? 0),
    );

    return Color.fromRGBO(
      150 + random.nextInt(106), // 150-255 range for pastel
      150 + random.nextInt(106),
      150 + random.nextInt(106),
      1.0,
    );
  }
}
