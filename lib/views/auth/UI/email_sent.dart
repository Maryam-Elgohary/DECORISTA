import 'package:flutter/material.dart';
import 'package:furniture_app/core/functions/navigate_to.dart';
import 'package:furniture_app/views/auth/UI/sign_in.dart';
import 'package:furniture_app/views/auth/UI/widgets/email_sent_widgets/auth_success_message.dart';

class EmailSent extends StatelessWidget {
  const EmailSent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthSuccessMessage(
        imagePath: "assets/email_sent.png",
        message: "We Sent you an Email to reset your password.",
        buttonText: "Return to Login",
        onButtonPressed: () => naviagteTo(context, const SignIn()),
      ),
    );
  }
}
