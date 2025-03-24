import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/functions/navigate_to.dart';

Widget buildSignPrompt(
    BuildContext context, String text_1, String text_2, Widget view) {
  return Center(
    child: TextButton(
      onPressed: () => naviagteTo(context, view),
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
            text: text_1,
            style: TextStyle(
              color: Color(0xff828A89),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextSpan(
            text: text_2,
            style: TextStyle(
              color: AppColors.darkBrown,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ]),
      ),
    ),
  );
}
