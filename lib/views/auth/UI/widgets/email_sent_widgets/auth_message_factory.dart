//Problem: We might need different types of auth messages (success, error, info) with similar structures but different visuals.
import 'package:flutter/material.dart';
import 'package:furniture_app/core/functions/navigate_to.dart';
import 'package:furniture_app/views/auth/UI/sign_in.dart';

import 'auth_success_message.dart';

abstract class AuthMessageFactory {
  static Widget createEmailSentMessage(BuildContext context) {
    return AuthSuccessMessage(
      imagePath: "assets/email_sent.png",
      message: "We Sent you an Email to reset your password.",
      buttonText: "Return to Login",
      onButtonPressed: () => naviagteTo(context, const SignIn()),
    );
  }

  // Add more factory methods for other messages later
}
