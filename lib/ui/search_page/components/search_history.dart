import 'package:flutter/Material.dart';
import 'package:provider/provider.dart';

import '../../../provider/news_provider.dart';
import '../../../provider/search_provider.dart';

class SearchHistory extends StatelessWidget {
  const SearchHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final read = context.read<SearchProvider>();
    final watch = context.watch<SearchProvider>();
    return ListView.builder(
      itemCount: watch.listOfSearches.length,
      itemBuilder: (BuildContext context, int index) {
        String val = watch.listOfSearches[index];
        return ListTile(
          hoverColor: Colors.transparent,
          title: Text(val),
          onTap: () {
            read.searchController.text = val;
            read.updateSearchIndex = index;
            read.searchNews(context.read<NewsProvider>().urlWithoutTopic);
          },
          trailing: IconButton(
            icon: const Icon(Icons.cancel),
            onPressed: () {
              read.removeSearchHistory(index: index);
            },
          ),
        );
      },
    );
  }
}
