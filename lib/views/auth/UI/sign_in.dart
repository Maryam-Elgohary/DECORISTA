import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/functions/convert_px_to_dp.dart';

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
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.only(
        left: pxToSp(context, 24),
        right: pxToSp(context, 24),
        top: pxToSp(context, 100),
      ),
      child: SingleChildScrollView(
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
              height: pxToSp(context, 32),
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
                    isPasswordHidden ? Icons.visibility : Icons.visibility_off,
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
                onPressed: () {},
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
            SizedBox(height: 5),
            ElevatedButton(
              onPressed: () {},
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
            SizedBox(height: 15),
            ElevatedButton.icon(
              onPressed: () {},
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
                onPressed: () {},
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
    ));
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
