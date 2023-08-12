import 'package:flutter/material.dart';

class FavouritesAndSavedPage extends StatefulWidget {
  const FavouritesAndSavedPage({super.key, this.isSaved = false});
  final bool isSaved;

  @override
  State<FavouritesAndSavedPage> createState() => _FavouritesAndSavedPageState();
}

class _FavouritesAndSavedPageState extends State<FavouritesAndSavedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isSaved ? "Saved" : "Favourites"),
      ),
    );
  }
}
