import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/functions/convert_px_to_dp.dart';
import 'package:furniture_app/core/functions/navigate_to.dart';
import 'package:furniture_app/views/auth/UI/sign_in.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isPasswordHidden = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Color(0xfff4f4f4))),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back)),
        ),
        body: Padding(
          padding: EdgeInsets.only(
            left: pxToSp(context, 24),
            right: pxToSp(context, 24),
            top: pxToSp(context, 30),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Create Account",
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
                      labelText: "First Name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none),
                      fillColor: const Color(0xfff4f4f4)),
                  keyboardType: TextInputType.name,
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
                  controller: emailController,
                  decoration: InputDecoration(
                      filled: true,
                      labelText: "Last Name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none),
                      fillColor: const Color(0xfff4f4f4)),
                  keyboardType: TextInputType.name,
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
                  controller: emailController,
                  decoration: InputDecoration(
                      filled: true,
                      labelText: "Email Address",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none),
                      fillColor: const Color(0xfff4f4f4)),
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
                    fillColor: const Color(0xfff4f4f4),
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
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkBrown,
                      minimumSize: const Size(double.infinity, 50)),
                  child: Text(
                    "Continue",
                    style: TextStyle(
                        fontSize: pxToSp(context, 20),
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const FaIcon(
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
                      backgroundColor: const Color(0xfff4f4f4),
                      minimumSize: const Size(double.infinity, 50)),
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      naviagteTo(context, SignIn());
                    },
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "Already have an account? ",
                          style: TextStyle(
                              color: Color(0xff828A89),
                              fontSize: pxToSp(context, 16),
                              fontWeight: FontWeight.w500)),
                      TextSpan(
                        text: "Sign in",
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
