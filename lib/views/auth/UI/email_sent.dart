import 'package:flutter/material.dart';
import 'package:furniture_app/views/auth/UI/widgets/email_sent_widgets/build_email_image.dart';
import 'package:furniture_app/views/auth/UI/widgets/email_sent_widgets/build_message_text.dart';
import 'package:furniture_app/views/auth/UI/widgets/email_sent_widgets/build_return_button.dart';

class EmailSent extends StatelessWidget {
  const EmailSent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildEmailImage(context),
              const SizedBox(height: 25),
              buildMessageText(context),
              const SizedBox(height: 25),
              buildReturnButton(context),
            ],
          ),
        ),
      ),
    );
  }
}
