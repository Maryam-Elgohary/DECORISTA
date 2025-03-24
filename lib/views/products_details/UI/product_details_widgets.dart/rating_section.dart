import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingSection extends StatelessWidget {
  const RatingSection({
    required this.averageRate,
    required this.userRate,
    required this.onRatingUpdate,
  });

  final double averageRate;
  final int userRate;
  final ValueChanged<double> onRatingUpdate;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RatingBar.builder(
        initialRating: userRate.toDouble(),
        minRating: 1,
        direction: Axis.horizontal,
        allowHalfRating: false,
        itemCount: 5,
        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
        itemBuilder: (context, _) =>
            const Icon(Icons.star, color: Colors.amber),
        onRatingUpdate: onRatingUpdate,
      ),
    );
  }
}
