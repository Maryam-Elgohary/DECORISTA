import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/functions/convert_px_to_dp.dart';
import 'package:furniture_app/core/components/navigate_to.dart';
import 'package:furniture_app/views/navbar/UI/main_home_view.dart';
import 'package:furniture_app/views/profile/logic/models/userdata_model.dart';

class success_payment_back_home_button extends StatelessWidget {
  const success_payment_back_home_button({
    super.key,
    required this.userDataModel,
  });

  final UserDataModel? userDataModel;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => naviagteTo(
          context,
          MainHomeView(
            userDataModel: userDataModel!,
          )),
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: AppColors.darkBrown,
          minimumSize: Size(pxToSp(context, 327), pxToSp(context, 56))),
      child: Text(
        "Back To Home",
        style: TextStyle(
            fontSize: pxToSp(context, 20),
            color: Colors.white,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}
