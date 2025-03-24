import 'package:flutter/material.dart';
import 'package:furniture_app/views/navbar/UI/widgets/bottom_nav_bar.dart';
import 'package:furniture_app/views/navbar/UI/widgets/main_content.dart';

class MainHomeViewContent extends StatelessWidget {
  const MainHomeViewContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const MainContent(),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
