import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/views/auth/logic/repository%20pattern/cubit/authentication_cubit.dart';
import 'package:furniture_app/views/profile/UI/widgets/profile_options.dart';
import 'package:furniture_app/views/profile/UI/widgets/screens_subclasses.dart';

Widget buildProfileOptions(BuildContext context) {
  final profileOptions = [
    ProfileOption(
      icon: Icons.settings,
      color: const Color(0xff493628),
      title: "Settings",
      onTap: () => navigateTo(context, const SettingScreen()),
    ),
    ProfileOption(
      icon: Icons.schedule,
      color: const Color(0xffFD9F12),
      title: "Order History",
      onTap: () => navigateTo(context, const OrderHistoryScreen()),
    ),
    ProfileOption(
      icon: Icons.lock_outline,
      color: const Color(0xff008BD9),
      title: "Privacy & Policy",
      onTap: () => navigateTo(context, const PrivacyPolicyScreen()),
    ),
    ProfileOption(
      icon: Icons.report_gmailerrorred_outlined,
      color: const Color(0xffFFCC47),
      title: "Terms & Conditions",
      onTap: () => navigateTo(context, const TermsConditionsScreen()),
    ),
    ProfileOption(
      icon: Icons.logout_outlined,
      color: const Color(0xffF44545),
      title: "Log Out",
      onTap: () => context.read<AuthenticationCubit>().signOut(),
    ),
  ];

  return Expanded(
    child: ListView.builder(
      itemCount: profileOptions.length,
      itemBuilder: (context, index) => profileOptions[index],
    ),
  );
}

void navigateTo(BuildContext context, Widget screen) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
}
