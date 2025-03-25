import 'package:flutter/material.dart';
import 'package:furniture_app/core/app_colors.dart';
import 'package:furniture_app/core/functions/convert_px_to_dp.dart';
import 'package:furniture_app/core/functions/navigate_to.dart';
import 'package:furniture_app/views/home/UI/search_view.dart';

class CustomSearchField extends StatefulWidget {
  const CustomSearchField({
    super.key,
  });

  @override
  State<CustomSearchField> createState() => _CustomSearchFieldState();
}

class _CustomSearchFieldState extends State<CustomSearchField> {
  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 10,
      child: TextFormField(
          controller: _searchController,
          decoration: InputDecoration(
            filled: true,
            hintText: "Search",
            suffixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      //  minimumSize: Size(10, 55),
                      backgroundColor: AppColors.darkBrown,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  onPressed: () {
                    if (_searchController.text.isNotEmpty) {
                      naviagteTo(
                          context,
                          SearchView(
                            query: _searchController.text,
                          ));
                      _searchController.clear();
                    }
                  },
                  label: const Icon(
                    Icons.search,
                    size: 20,
                  )),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(pxToSp(context, 100)),
              borderSide: BorderSide.none,
            ),
            fillColor: const Color.fromRGBO(167, 167, 167, 0.20),
          )),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
