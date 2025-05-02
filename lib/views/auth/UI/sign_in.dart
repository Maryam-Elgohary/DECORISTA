import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/components/custom_circle_pro_indicator.dart';
import 'package:furniture_app/core/functions/convert_px_to_dp.dart';
import 'package:furniture_app/core/components/navigate_to.dart';
import 'package:furniture_app/core/components/show_msg.dart';
import 'package:furniture_app/views/auth/UI/forget_password.dart';
import 'package:furniture_app/views/auth/UI/sign_up.dart';
import 'package:furniture_app/views/auth/UI/widgets/sign_in_widgets/auth_footer.dart';
import 'package:furniture_app/views/auth/UI/widgets/sign_in_widgets/auth_google_button.dart';
import 'package:furniture_app/views/auth/UI/widgets/sign_in_widgets/auth_header.dart';
import 'package:furniture_app/views/auth/UI/widgets/sign_in_widgets/auth_text_field.dart';
import 'package:furniture_app/views/auth/UI/widgets/sign_up_widgets/auth_button.dart';
import 'package:furniture_app/views/auth/logic/repository%20pattern/cubit/authentication_cubit.dart';
import 'package:furniture_app/views/auth/logic/repository%20pattern/cubit/authentication_state.dart';
import 'package:furniture_app/views/navbar/UI/main_home_view.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isPasswordHidden = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is LoginSuccess || state is GoogleSignInSuccess) {
          final userDataModel =
              context.read<AuthenticationCubit>().userDataModel!;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MainHomeView(userDataModel: userDataModel),
            ),
          );
        }
        if (state is LoginError) {
          showMsg(context, state.message);
        }
      },
      builder: (context, state) {
        final cubit = context.read<AuthenticationCubit>();

        if (state is LoginLoading) {
          return const CustomCircleProIndicator();
        }

        return Scaffold(
          appBar: AppBar(backgroundColor: Colors.transparent),
          body: Padding(
            padding: EdgeInsets.only(
              left: pxToSp(context, 24),
              right: pxToSp(context, 24),
              top: pxToSp(context, 30),
            ),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AuthHeader(title: "Sign in"),
                    const SizedBox(height: 20),
                    AuthTextField(
                      controller: _emailController,
                      labelText: "Email Address",
                      validator: (value) => value?.isEmpty ?? true
                          ? "This field is required"
                          : null,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 20),
                    AuthTextField(
                      controller: _passwordController,
                      labelText: "Password",
                      isPassword: true,
                      isPasswordHidden: _isPasswordHidden,
                      onTogglePasswordVisibility: () => setState(
                          () => _isPasswordHidden = !_isPasswordHidden),
                      validator: (value) => value?.isEmpty ?? true
                          ? "This field is required"
                          : null,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () =>
                            naviagteTo(context, const ForgetPassword()),
                        child: AuthFooter(
                          questionText: "Forgot password? ",
                          actionText: "Reset",
                          onPressed: () {
                            naviagteTo(context, const ForgetPassword());
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    AuthButton(
                      text: "Continue",
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          cubit.login(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                        }
                      },
                      backgroundColor: AppColors.darkBrown,
                      textColor: Colors.white,
                    ),
                    const SizedBox(height: 20),
                    AuthGoogleButton(
                      onPressed: () => cubit.googleSignIn(),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: AuthFooter(
                        questionText: "Don't have an account? ",
                        actionText: "Create one",
                        onPressed: () => naviagteTo(context, const SignUp()),
                      ),
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
