import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/views/auth/logic/repository%20pattern/cubit/authentication_cubit.dart';
import 'package:furniture_app/views/auth/logic/repository%20pattern/cubit/authentication_state.dart';
import 'package:furniture_app/views/home/UI/widgets/CategoriesHeader.dart';
import 'package:furniture_app/views/home/UI/widgets/HeaderSection.dart';
import 'package:furniture_app/views/home/UI/widgets/SpecialOffersHeader.dart';
import 'package:furniture_app/views/home/UI/widgets/categories_list.dart';
import 'package:furniture_app/views/home/UI/widgets/custom_search_field.dart';
import 'package:furniture_app/views/home/UI/widgets/discount_banner.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F4F4),
      body: const _HomeContent(),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeaderSection(),
                  const SizedBox(height: 10),
                  const CustomSearchField(),
                  const SizedBox(height: 10),
                  const SpecialOffersHeader(),
                  const SizedBox(height: 10),
                  DiscountBanner(),
                  const SizedBox(height: 5),
                  const CategoriesHeader(),
                  const SizedBox(height: 5),
                  const CategoriesList(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
