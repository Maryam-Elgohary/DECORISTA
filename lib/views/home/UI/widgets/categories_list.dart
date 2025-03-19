import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/components/products_list.dart';
import 'package:furniture_app/core/functions/convert_px_to_dp.dart';
import 'package:furniture_app/views/categories/cubit/cubit/category_cubit.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({super.key});

  @override
  _CategoriesListState createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CategoryCubit()..fetchCategories(), // FIX: Fetch categories
      child: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CategoryError) {
            return Center(child: Text(state.message));
          }
          if (state is CategoryLoaded) {
            return Column(
              children: [
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.categories.length,
                    itemBuilder: (context, index) {
                      bool isSelected = index == selectedIndex;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.darkBrown
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: Text(
                              state.categories[index]['name'],
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: pxToSp(context, 16),
                                color: isSelected
                                    ? Colors.white
                                    : AppColors.darkBrown,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 500, // Adjust height as needed
                  child: ProductsList(
                      category: state.categories[selectedIndex]['name']),
                ),
              ],
            );
          }
          return const Center(child: Text("No Categories Available"));
        },
      ),
    );
  }
}
