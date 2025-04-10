import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/core/functions/build_appbar.dart';
import 'package:furniture_app/core/functions/navigate_to.dart';
import 'package:furniture_app/views/categories/UI/selected_category.dart';
import 'package:furniture_app/views/categories/UI/widgets/category_listtile_leading.dart';
import 'package:furniture_app/views/categories/UI/widgets/category_listtile_title.dart';
import 'package:furniture_app/views/categories/UI/widgets/category_listtile_trailing.dart';
import 'package:furniture_app/views/categories/cubit/cubit/category_cubit.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(context, "Categories"),
      body: BlocProvider(
        create: (context) => CategoryCubit()..fetchCategories(),
        child: BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, state) {
            if (state is CategoryLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is CategoryError) {
              return Center(child: Text(state.message));
            }
            if (state is CategoryLoaded) {
              return ListView.builder(
                itemCount: state.categories.length,
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  final category = state.categories[index];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 5,
                            spreadRadius: 1),
                      ],
                    ),
                    child: ListTile(
                      leading: category_listtile_leading(category: category),
                      title: category_listtile_title(category: category),
                      // subtitle: Text(
                      //     "${context.read<HomeCubit>().categoryProductsCount} products"),
                      trailing: category_listtile_trailing(),
                      onTap: () {
                        navigate_to_selected_category(context, category);
                      },
                    ),
                  );
                },
              );
            }
            return const Center(child: Text("No Categories Available"));
          },
        ),
      ),
      backgroundColor: Colors.grey[100],
    );
  }

  Future<dynamic> navigate_to_selected_category(
      BuildContext context, Map<String, dynamic> category) {
    return naviagteTo(
        context,
        SelectedCategory(
          title: category['name'],
        ));
  }
}
