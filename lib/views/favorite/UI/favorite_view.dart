import 'package:flutter/material.dart';
import 'package:furniture_app/core/functions/build_appbar.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildCustomAppBar(context, "Favorites"),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(),
        ));
  }
}
