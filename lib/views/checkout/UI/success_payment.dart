import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/views/auth/logic/repository%20pattern/cubit/authentication_cubit.dart';
import 'package:furniture_app/views/checkout/UI/widgets/success_payment_body.dart';
import 'package:furniture_app/views/profile/logic/models/userdata_model.dart';

class SuccessPayment extends StatelessWidget {
  const SuccessPayment({super.key});

  @override
  Widget build(BuildContext context) {
    UserDataModel? userDataModel =
        context.read<AuthenticationCubit>().userDataModel;
    return Scaffold(
      backgroundColor: Colors.white,
      body: success_payment_body(userDataModel: userDataModel),
    );
  }
}
