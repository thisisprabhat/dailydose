import 'package:dailydose/constants/values.dart';
import 'package:dailydose/provider/saved_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../single_feed/single_feed_page.dart';

class FavouritesAndSavedPage extends StatelessWidget {
  const FavouritesAndSavedPage({super.key, this.isSaved = false});
  final bool isSaved;

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<SavedProvider>();
    final data = isSaved ? watch.savedNews : watch.favouriteNews;
    return Scaffold(
      appBar: AppBar(
        title: Text(isSaved ? "Saved" : "Favourites"),
      ),
      body: data.isEmpty
          ? SizedBox(
              height: double.maxFinite,
              width: double.maxFinite,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/empty-folder.png",
                    height: 100,
                    width: 100,
                  ),
                  Text(
                    "No ${isSaved ? "Saved" : "Favourite"} news found!",
                    style: Theme.of(context).textTheme.titleLarge,
                  )
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.only(right: 12, left: 12, top: 10),
              itemCount: data.length ?? 0,
              itemBuilder: (context, index) {
                final news = data[index];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: kBorderRadiusMedium,
                  ),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SingleFeedPage(
                            data: news,
                          ),
                        ),
                      );
                    },
                    leading: Container(
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: kBorderRadiusMedium,
                        color: Theme.of(context).colorScheme.background,
                        image: DecorationImage(
                          image: NetworkImage(news.image ?? ""),
                          fit: BoxFit.fill,
                        ),
                      ),
                      // child: Image.network(news?.image ?? ""),
                    ),
                    title: Text(
                      news.title ?? "",
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 3,
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        if (isSaved == true) {
                          context.read<SavedProvider>().removeFromSaved(news);
                        } else {
                          context
                              .read<SavedProvider>()
                              .removeFromFavourite(news);
                        }
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
