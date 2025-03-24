import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/core/components/custom_circle_pro_indicator.dart';
import 'package:furniture_app/core/functions/navigate_to.dart';
import 'package:furniture_app/core/functions/show_msg.dart';
import 'package:furniture_app/views/auth/UI/email_sent.dart';
import 'package:furniture_app/views/auth/UI/widgets/build_custom_field.dart';
import 'package:furniture_app/views/auth/UI/widgets/build_continue_button.dart';
import 'package:furniture_app/views/auth/UI/widgets/build_title.dart';
import 'package:furniture_app/views/auth/UI/widgets/validate_field.dart';
import 'package:furniture_app/views/auth/logic/repository%20pattern/cubit/authentication_state.dart';
import 'package:furniture_app/views/auth/logic/repository%20pattern/cubit/authentication_cubit.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: _authListener,
        builder: (context, state) {
          return state is PasswordResetLoading
              ? const Center(child: CustomCircleProIndicator())
              : _buildFormContent(context);
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
        style: const ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Color(0xfff4f4f4)),
        ),
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back),
      ),
    );
  }

  void _authListener(BuildContext context, AuthenticationState state) {
    if (state is PasswordResetSuccess) {
      naviagteTo(context, EmailSent());
      showMsg(context, "Email was sent");
    }
  }

  Widget _buildFormContent(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTitle(context, "Forgot Password"),
            const SizedBox(height: 30),
            buildCustomField(_emailController, validateField,
                TextInputType.emailAddress, "Enter Email Address"),
            const SizedBox(height: 30),
            buildContinueButton(context, _submitForm),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthenticationCubit>().resetPasswords(
            email: _emailController.text,
          );
    }
  }
}
