import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';

class onboarding_floating_action_button extends StatelessWidget {
  const onboarding_floating_action_button({
    super.key,
    required PageController controller,
  }) : _controller = controller;

  final PageController _controller;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: CircleBorder(),
      backgroundColor: AppColors.darkBrown,
      onPressed: () {
        _controller.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );
      },
      child: const Icon(Icons.arrow_forward, color: Colors.white),
    );
  }
}
