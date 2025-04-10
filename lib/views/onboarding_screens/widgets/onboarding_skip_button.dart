import 'package:flutter/material.dart';
import 'package:furniture_app/core/functions/convert_px_to_dp.dart';
import 'package:furniture_app/views/onboarding_screens/widgets/onboarding_floating_action_button.dart';

class onboarding_skip_button extends StatelessWidget {
  const onboarding_skip_button({
    super.key,
    required PageController controller,
    required this.onboardingData,
  }) : _controller = controller;

  final PageController _controller;
  final List<Map<String, String>> onboardingData;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {
            _controller.jumpToPage(onboardingData.length - 1);
          },
          child: Text(
            "Skip",
            style: TextStyle(
                color: Color(0xff828A89), fontSize: pxToSp(context, 16)),
          ),
        ),
        onboarding_floating_action_button(controller: _controller),
      ],
    );
  }
}
