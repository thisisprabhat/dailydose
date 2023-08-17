import 'package:dailydose/provider/news_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouritesAndSavedPage extends StatefulWidget {
  const FavouritesAndSavedPage({super.key, this.isSaved = false});
  final bool isSaved;

  @override
  State<FavouritesAndSavedPage> createState() => _FavouritesAndSavedPageState();
}

class _FavouritesAndSavedPageState extends State<FavouritesAndSavedPage> {
  @override
  Widget build(BuildContext context) {
    final watch = context.watch<NewsProvider>();
    final data = watch.dailyNews;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isSaved ? "Saved" : "Favourites"),
      ),
      body: ListView.builder(
        itemCount: data?.articles?.length ?? 0,
        itemBuilder: (context, index) {
          final news = data?.articles?[index];
          return ListTile(
            leading: Image.network(news?.image ?? ""),
            title: Text(
              news?.title ?? "",
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
          );
        },
      ),
    );
  }
}
