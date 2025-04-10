import 'package:flutter/material.dart';

class product_details_arrow_back extends StatelessWidget {
  const product_details_arrow_back({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Icon(
            Icons.arrow_back,
            size: 30,
          ),
        ),
      ),
    );
  }
}
