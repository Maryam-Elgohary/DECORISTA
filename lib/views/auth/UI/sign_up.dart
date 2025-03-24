import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/components/custom_circle_pro_indicator.dart';
import 'package:furniture_app/core/functions/show_msg.dart';
import 'package:furniture_app/views/auth/UI/sign_in.dart';
import 'package:furniture_app/views/auth/UI/widgets/build_custom_field.dart';
import 'package:furniture_app/views/auth/UI/widgets/input_decoration.dart';
import 'package:furniture_app/views/auth/UI/widgets/build_continue_button.dart';
import 'package:furniture_app/views/auth/UI/widgets/build_google_button.dart';
import 'package:furniture_app/views/auth/UI/widgets/build_sign_prompt.dart';
import 'package:furniture_app/views/auth/UI/widgets/build_title.dart';
import 'package:furniture_app/views/auth/UI/widgets/validate_field.dart';
import 'package:furniture_app/views/auth/logic/repository%20pattern/cubit/authentication_state.dart';
import 'package:furniture_app/views/auth/logic/repository%20pattern/cubit/authentication_cubit.dart';
import 'package:furniture_app/views/navbar/UI/main_home_view.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordHidden = true;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: _authListener,
        builder: (context, state) {
          return state is SignUpLoading
              ? const Center(child: CustomCircleProIndicator())
              : _buildFormContent(context);
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          style: const ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Color(0xfff4f4f4)),
          ),
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ));
  }

  void _authListener(BuildContext context, AuthenticationState state) {
    if (state is SignUpSuccess || state is GoogleSignInSuccess) {
      final userData = context.read<AuthenticationCubit>().userDataModel;
      if (userData != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => MainHomeView(userDataModel: userData),
          ),
        );
      }
    } else if (state is SignUpError) {
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
            buildTitle(context, "Create Account"),
            const SizedBox(height: 20),
            buildCustomField(_firstNameController, validateField,
                TextInputType.name, "First Name"),
            const SizedBox(height: 20),
            buildCustomField(_lastNameController, validateField,
                TextInputType.name, "Last Name"),
            const SizedBox(height: 20),
            buildCustomField(_emailController, validateField,
                TextInputType.emailAddress, "Email Address"),
            const SizedBox(height: 20),
            buildPasswordField(),
            const SizedBox(height: 20),
            buildContinueButton(context, submitForm),
            const SizedBox(height: 15),
            buildGoogleButton(context),
            buildSignPrompt(
                context, "Already have an account? ", "Sign in", SignIn()),
          ],
        ),
      ),
    );
  }


  Widget buildPasswordField() {
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

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthenticationCubit>().register(
            firstName: _firstNameController.text,
            lastName: _lastNameController.text,
            email: _emailController.text,
            password: _passwordController.text,
          );
    }
  }
}
