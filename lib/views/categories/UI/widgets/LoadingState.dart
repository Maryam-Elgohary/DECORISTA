import 'package:flutter/material.dart';

class LoadingState extends StatelessWidget {
  const LoadingState();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
