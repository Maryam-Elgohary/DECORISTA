import 'package:flutter/material.dart';

class EmptyReviewsMessage extends StatelessWidget {
  const EmptyReviewsMessage();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "No Reviews Yet",
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.grey,
        ),
      ),
    );
  }
}
