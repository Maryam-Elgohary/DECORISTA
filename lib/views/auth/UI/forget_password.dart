import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/components/custom_circle_pro_indicator.dart';
import 'package:furniture_app/core/components/navigate_to.dart';
import 'package:furniture_app/core/components/show_msg.dart';
import 'package:furniture_app/views/auth/UI/email_sent.dart';
import 'package:furniture_app/views/auth/UI/widgets/forget_password_widgets/auth_back_button.dart';
import 'package:furniture_app/views/auth/UI/widgets/sign_in_widgets/auth_header.dart';
import 'package:furniture_app/views/auth/UI/widgets/sign_in_widgets/auth_text_field.dart';
import 'package:furniture_app/views/auth/UI/widgets/sign_up_widgets/auth_button.dart';
import 'package:furniture_app/views/auth/logic/repository%20pattern/cubit/authentication_cubit.dart';
import 'package:furniture_app/views/auth/logic/repository%20pattern/cubit/authentication_state.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is PasswordResetSuccess) {
          naviagteTo(context, EmailSent());
          showMsg(context, "Email was sent");
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: AuthBackButton(
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: state is PasswordResetLoading
              ? const CustomCircleProIndicator()
              : Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 30,
                  ),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const AuthHeader(title: "Forget Password"),
                          const SizedBox(height: 30),
                          AuthTextField(
                            controller: _emailController,
                            labelText: "Enter Email Address",
                            validator: (value) => value?.isEmpty ?? true
                                ? "This field is required"
                                : null,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 30),
                          AuthButton(
                            text: "Continue",
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                context
                                    .read<AuthenticationCubit>()
                                    .resetPasswords(
                                      email: _emailController.text,
                                    );
                              }
                            },
                            backgroundColor: AppColors.darkBrown,
                            textColor: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
