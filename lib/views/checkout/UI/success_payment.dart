import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/functions/convert_px_to_dp.dart';
import 'package:furniture_app/core/functions/navigate_to.dart';
import 'package:furniture_app/views/auth/cubit/authentication_cubit.dart';
import 'package:furniture_app/views/navbar/UI/main_home_view.dart';
import 'package:furniture_app/views/profile/logic/models/userdata_model.dart';

class SuccessPayment extends StatelessWidget {
  const SuccessPayment({super.key});

  @override
  Widget build(BuildContext context) {
    UserDataModel? userDataModel =
        context.read<AuthenticationCubit>().userDataModel;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: AppColors.darkBrown,
                radius: 50,
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 50,
                ),
              ),
              const SizedBox(height: 25),
              Text(
                "Thank you for your order",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.darkBrown,
                    fontSize: pxToSp(context, 26),
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 15),
              Text(
                "Your order have been placed successfully! ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xff828A89),
                  fontSize: pxToSp(context, 20),
                ),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () => naviagteTo(
                    context,
                    MainHomeView(
                      userDataModel: userDataModel!,
                    )),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: AppColors.darkBrown,
                    minimumSize:
                        Size(pxToSp(context, 327), pxToSp(context, 56))),
                child: Text(
                  "Back To Home",
                  style: TextStyle(
                      fontSize: pxToSp(context, 20),
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
