import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/components/custom_circle_pro_indicator.dart';
import 'package:furniture_app/core/functions/convert_px_to_dp.dart';
import 'package:furniture_app/core/functions/navigate_to.dart';
import 'package:furniture_app/core/functions/show_msg.dart';
import 'package:furniture_app/views/auth/UI/sign_in.dart';
import 'package:furniture_app/views/auth/UI/widgets/sign_up_widgets/auth_button.dart';
import 'package:furniture_app/views/auth/UI/widgets/sign_up_widgets/auth_field.dart';
import 'package:furniture_app/views/auth/UI/widgets/sign_up_widgets/sign_up_controller.dart';
import 'package:furniture_app/views/auth/logic/repository%20pattern/cubit/authentication_cubit.dart';
import 'package:furniture_app/views/auth/logic/repository%20pattern/cubit/authentication_state.dart';
import 'package:furniture_app/views/navbar/UI/main_home_view.dart';

// sign_up.dart
class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final SignUpController _controller = SignUpController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSignUp(BuildContext context) {
    if (_controller.formKey.currentState!.validate()) {
      context.read<AuthenticationCubit>().register(
            firstName: _controller.firstName.text,
            lastName: _controller.lastName.text,
            email: _controller.email.text,
            password: _controller.password.text,
          );
    }
  }

  void _handleGoogleSignIn(BuildContext context) {
    context.read<AuthenticationCubit>().googleSignIn();
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      "Create Account",
      style: TextStyle(
        color: AppColors.darkBrown,
        fontSize: pxToSp(context, 32),
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildSignInRedirect(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () => naviagteTo(context, const SignIn()),
        child: RichText(
          text: TextSpan(children: [
            TextSpan(
              text: "Already have an account? ",
              style: TextStyle(
                color: const Color(0xff828A89),
                fontSize: pxToSp(context, 16),
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text: "Sign in",
              style: TextStyle(
                color: AppColors.darkBrown,
                fontSize: pxToSp(context, 16),
                fontWeight: FontWeight.w700,
              ),
            )
          ]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is SignUpSuccess || state is GoogleSignInSuccess) {
          final userDataModel =
              context.read<AuthenticationCubit>().userDataModel!;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MainHomeView(userDataModel: userDataModel),
            ),
          );
          log("Success");
        }
        if (state is SignUpError) {
          showMsg(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is SignUpLoading) return const CustomCircleProIndicator();

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Color(0xfff4f4f4)),
              ),
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.only(
              left: pxToSp(context, 24),
              right: pxToSp(context, 24),
              top: pxToSp(context, 30),
            ),
            child: SingleChildScrollView(
              child: Form(
                key: _controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitle(context),
                    const SizedBox(height: 20),
                    AuthField(
                      controller: _controller.firstName,
                      labelText: "First Name",
                      validator: (value) =>
                          _controller.validateRequired(value, "First name"),
                    ),
                    const SizedBox(height: 20),
                    AuthField(
                      controller: _controller.lastName,
                      labelText: "Last Name",
                      validator: (value) =>
                          _controller.validateRequired(value, "Last name"),
                    ),
                    const SizedBox(height: 20),
                    AuthField(
                      controller: _controller.email,
                      labelText: "Email Address",
                      keyboardType: TextInputType.emailAddress,
                      validator: _controller.validateEmail,
                    ),
                    const SizedBox(height: 20),
                    AuthField(
                      controller: _controller.password,
                      labelText: "Password",
                      obscureText: _controller.isPasswordHidden,
                      validator: (value) =>
                          _controller.validateRequired(value, "Password"),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(_controller.togglePasswordVisibility);
                        },
                        icon: Icon(
                          _controller.isPasswordHidden
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppColors.darkBrown,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    AuthButton(
                      onPressed: () => _handleSignUp(context),
                      text: "Continue",
                      backgroundColor: AppColors.darkBrown,
                      textColor: Colors.white,
                    ),
                    const SizedBox(height: 15),
                    AuthButton(
                      onPressed: () => _handleGoogleSignIn(context),
                      text: "Continue With Google",
                      backgroundColor: const Color(0xfff4f4f4),
                      textColor: AppColors.darkBrown,
                      icon: const FaIcon(
                        FontAwesomeIcons.google,
                        size: 25,
                        color: Colors.red,
                      ),
                    ),
                    _buildSignInRedirect(context),
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
