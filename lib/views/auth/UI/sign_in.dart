import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/components/custom_circle_pro_indicator.dart';
import 'package:furniture_app/core/functions/show_msg.dart';
import 'package:furniture_app/views/auth/UI/sign_up.dart';
import 'package:furniture_app/views/auth/UI/widgets/build_custom_field.dart';
import 'package:furniture_app/views/auth/UI/widgets/build_forget_password_button.dart';
import 'package:furniture_app/views/auth/UI/widgets/input_decoration.dart';
import 'package:furniture_app/views/auth/UI/widgets/build_continue_button.dart';
import 'package:furniture_app/views/auth/UI/widgets/build_google_button.dart';
import 'package:furniture_app/views/auth/UI/widgets/build_sign_prompt.dart';
import 'package:furniture_app/views/auth/UI/widgets/build_title.dart';
import 'package:furniture_app/views/auth/UI/widgets/validate_field.dart';
import 'package:furniture_app/views/auth/logic/repository%20pattern/cubit/authentication_state.dart';
import 'package:furniture_app/views/auth/logic/repository%20pattern/cubit/authentication_cubit.dart';
import 'package:furniture_app/views/navbar/UI/main_home_view.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordHidden = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: _authListener,
        builder: (context, state) {
          return state is LoginLoading
              ? const Center(child: CustomCircleProIndicator())
              : _buildFormContent(context);
        },
      ),
    );
  }

  void _authListener(BuildContext context, AuthenticationState state) {
    if (state is LoginSuccess || state is GoogleSignInSuccess) {
      final userData = context.read<AuthenticationCubit>().userDataModel;
      if (userData != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => MainHomeView(userDataModel: userData),
          ),
        );
      }
    } else if (state is LoginError) {
      showMsg(context, state.message);
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
            buildTitle(context, "Sign in"),
            const SizedBox(height: 20),
            buildCustomField(_emailController, validateField,
                TextInputType.emailAddress, "Email Address"),
            const SizedBox(height: 20),
            _buildPasswordField(),
            buildForgotPasswordButton(context),
            const SizedBox(height: 20),
            buildContinueButton(context, _submitForm),
            const SizedBox(height: 20),
            buildGoogleButton(context),
            buildSignPrompt(
                context, "Don't have an account? ", "Create one", SignUp()),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      validator: validateField,
      obscureText: _isPasswordHidden,
      decoration: inputDecoration("Password").copyWith(
        suffixIcon: IconButton(
          onPressed: () =>
              setState(() => _isPasswordHidden = !_isPasswordHidden),
          icon: Icon(
            _isPasswordHidden ? Icons.visibility : Icons.visibility_off,
            color: AppColors.darkBrown,
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthenticationCubit>().login(
            email: _emailController.text,
            password: _passwordController.text,
          );
    }
  }
}
