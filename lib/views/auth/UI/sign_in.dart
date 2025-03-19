import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/components/custom_circle_pro_indicator.dart';
import 'package:furniture_app/core/functions/convert_px_to_dp.dart';
import 'package:furniture_app/core/functions/navigate_to.dart';
import 'package:furniture_app/core/functions/show_msg.dart';
import 'package:furniture_app/views/auth/UI/forget_password.dart';
import 'package:furniture_app/views/auth/UI/sign_up.dart';
import 'package:furniture_app/views/auth/cubit/authentication_cubit.dart';
import 'package:furniture_app/views/auth/cubit/authentication_state.dart';
import 'package:furniture_app/views/navbar/UI/main_home_view.dart';
import 'package:furniture_app/views/profile/logic/models/userdata_model.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isPasswordHidden = true;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is LoginSuccess || state is GoogleSignInSuccess) {
          UserDataModel userDataModel =
              context.read<AuthenticationCubit>().userDataModel!;
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      MainHomeView(userDataModel: userDataModel)));
        }
        if (state is LoginError) {
          showMsg(context, state.message);
        }
      },
      builder: (context, state) {
        AuthenticationCubit cubit = context.read<AuthenticationCubit>();
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
            ),
            body: state is LoginLoading
                ? CustomCircleProIndicator()
                : Padding(
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
                            Text(
                              "Sign in",
                              style: TextStyle(
                                  color: AppColors.darkBrown,
                                  fontSize: pxToSp(context, 32),
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "This field is required";
                                }
                                return null;
                              },
                              controller: emailController,
                              decoration: InputDecoration(
                                  filled: true,
                                  labelText: "Email Address",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide.none),
                                  fillColor: Color(0xfff4f4f4)),
                              keyboardType: TextInputType.emailAddress,
                            ),

                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "This field is required";
                                }
                                return null;
                              },
                              controller: passwordController,
                              decoration: InputDecoration(
                                filled: true,
                                labelText: "Password",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide.none),
                                fillColor: Color(0xfff4f4f4),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isPasswordHidden = !isPasswordHidden;
                                    });
                                  },
                                  icon: Icon(
                                    isPasswordHidden
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: AppColors.darkBrown,
                                  ),
                                ),
                              ),
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: isPasswordHidden,
                            ),

                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  naviagteTo(context, ForgetPassword());
                                },
                                child: RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text: "Forgot password?",
                                      style: TextStyle(
                                          color: AppColors.darkBrown,
                                          fontSize: pxToSp(context, 16),
                                          fontWeight: FontWeight.w500)),
                                  TextSpan(
                                    text: " Reset",
                                    style: TextStyle(
                                        color: AppColors.darkBrown,
                                        fontSize: pxToSp(context, 16),
                                        fontWeight: FontWeight.w700),
                                  )
                                ])),
                              ),
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  cubit.login(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.darkBrown,
                                  minimumSize: Size(double.infinity, 50)),
                              child: Text(
                                "Continue",
                                style: TextStyle(
                                    fontSize: pxToSp(context, 20),
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(height: 20),
                            ElevatedButton.icon(
                              onPressed: () {
                                cubit.googleSignIn();
                              },
                              icon: FaIcon(
                                FontAwesomeIcons.google,
                                size: 25,
                                color: Colors.red,
                              ),
                              label: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  "Continue With Google",
                                  style: TextStyle(
                                      fontSize: pxToSp(context, 20),
                                      color: AppColors.darkBrown,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xfff4f4f4),
                                  minimumSize: Size(double.infinity, 50)),
                            ),

                            //  Spacer(),
                            Center(
                              child: TextButton(
                                onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUp())),
                                child: RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text: "Don't have an account? ",
                                      style: TextStyle(
                                          color: AppColors.darkBrown,
                                          fontSize: pxToSp(context, 16),
                                          fontWeight: FontWeight.w500)),
                                  TextSpan(
                                    text: "Create one",
                                    style: TextStyle(
                                        color: AppColors.darkBrown,
                                        fontSize: pxToSp(context, 16),
                                        fontWeight: FontWeight.w700),
                                  )
                                ])),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ));
      },
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
