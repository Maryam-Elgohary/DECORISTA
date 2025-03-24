import 'package:flutter/material.dart';
import 'package:furniture_app/views/onboarding_screens/widgets/build_started_button.dart';

Widget buildNavigationControls(
    BuildContext context, bool _isLastPage, Widget widget) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: _isLastPage ? buildGetStartedButton(context) : widget,
  );
}
