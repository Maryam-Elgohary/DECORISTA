import 'package:flutter/material.dart';
import 'package:furniture_app/core/components/custom_circle_pro_indicator.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CustomCircleProIndicator(),
    );
  }
}
