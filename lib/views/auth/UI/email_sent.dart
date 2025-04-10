// email_sent.dart (UPDATED)
import 'package:flutter/material.dart';
import 'package:furniture_app/views/auth/UI/widgets/email_sent_widgets/auth_message_factory.dart';

class EmailSent extends StatelessWidget {
  const EmailSent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthMessageFactory.createEmailSentMessage(context),
    );
  }
}
