import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/views/navbar/UI/widgets/get_view_for_index.dart';
import 'package:furniture_app/views/navbar/cubit/cubit/nav_bar_cubit.dart';

class MainContent extends StatelessWidget {
  const MainContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBarCubit, NavBarState>(
      builder: (context, state) {
        final currentIndex = context.select(
          (NavBarCubit cubit) => cubit.currentIndex,
        );
        return SafeArea(
          child: getViewForIndex(currentIndex),
        );
      },
    );
  }
}
