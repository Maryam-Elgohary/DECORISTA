import 'package:flutter/material.dart';
import 'package:furniture_app/views/home/UI/widgets/buildInputBorder.dart';
import 'package:furniture_app/views/home/UI/widgets/buildSearchButton.dart';

class CustomSearchField extends StatefulWidget {
  const CustomSearchField({super.key});

  @override
  State<CustomSearchField> createState() => _CustomSearchFieldState();
}

class _CustomSearchFieldState extends State<CustomSearchField> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width - 10,
      ),
      child: TextFormField(
        controller: _searchController,
        decoration: InputDecoration(
          filled: true,
          hintText: "Search",
          suffixIcon: buildSearchButton(context, _searchController),
          border: buildInputBorder(context),
          fillColor: const Color.fromRGBO(167, 167, 167, 0.20),
        ),
      ),
    );
  }
}
