import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/functions/convert_px_to_dp.dart';
import 'package:furniture_app/core/functions/navigate_to.dart';
import 'package:furniture_app/views/auth/UI/email_sent.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                  "Forget Password",
                  style: TextStyle(
                      color: AppColors.darkBrown,
                      fontSize: pxToSp(context, 32),
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 30,
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
                      labelText: "Enter Email Address",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none),
                      fillColor: const Color(0xfff4f4f4)),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    naviagteTo(context, EmailSent());
                    //ToDo: Forget Password
                  },
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
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
