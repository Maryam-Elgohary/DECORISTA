import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class alert_dialog_no_button extends StatelessWidget {
  const alert_dialog_no_button({
    super.key,
    required this.dialogContext,
  });

  final BuildContext dialogContext;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(dialogContext).pop(); // Close the dialog
      },
      child: Text(
        'No',
        style: GoogleFonts.poppins(
          fontSize: 16,
          color: AppColors.darkBrown,
        ),
      ),
    );
  }
}
