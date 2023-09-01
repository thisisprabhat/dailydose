import 'package:dailydose/constants/values.dart';
import 'package:dailydose/provider/news_provider.dart';
import 'package:dailydose/provider/search_provider.dart';
import 'package:dailydose/ui/search_page/components/search_history.dart';
import 'package:dailydose/ui/search_page/components/search_results.dart';
import 'package:dailydose/ui/search_page/components/topics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewsSearchPage extends StatefulWidget {
  const NewsSearchPage({super.key});

  @override
  State<NewsSearchPage> createState() => _NewsSearchPageState();
}

class _NewsSearchPageState extends State<NewsSearchPage> {
  bool showCategory = true;

  late FocusNode _searchFocusNode;

  @override
  void initState() {
    super.initState();
    context.read<SearchProvider>().updateLoadingState = LoadingState.hidden;
    context.read<SearchProvider>().searchController.clear();
    _searchFocusNode = FocusNode();
    _searchFocusNode.addListener(() {
      if (_searchFocusNode.hasFocus) {
        setState(() {
          showCategory = false;
        });
      } else {
        Future.delayed(const Duration(milliseconds: 300))
            .then((value) => setState(() => showCategory = true));
      }
    });
  }

  @override
  void dispose() {
    _searchFocusNode.removeListener(() {});
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<SearchProvider>();
    return Scaffold(
      appBar: _appBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Column(
          children: [
            if (watch.loadingState != LoadingState.hidden)
              const Expanded(child: SearchResults())
            else if (showCategory && watch.searchController.text.isEmpty)
              const Expanded(child: Topic())
            else
              const Expanded(child: SearchHistory()),
          ],
        ),
      ),
    );
  }

  AppBar _appBar() {
    final read = context.read<SearchProvider>();
    final url = context.read<NewsProvider>().urlWithoutTopic;
    return AppBar(
      // The search field here
      title: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 40,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: TextField(
            focusNode: _searchFocusNode,
            controller: read.searchController,
            onSubmitted: (value) {
              read.searchNews(url);
              read.addSearchItem = value;
            },
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  read.searchController.clear();
                  read.updateLoadingState = LoadingState.hidden;
                },
              ),
              hintText: 'Search...',
              hintStyle:
                  TextStyle(color: Theme.of(context).colorScheme.surface),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(
            right: 8.0, /*top: 10, bottom: 10*/
          ),
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.onBackground,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              // padding:
              //     const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
            ),
            onPressed: () {
              read.searchNews(url);
              read.addSearchItem = read.searchController.text;
            },
            child: const Text("Search"),
          ),
        ),
      ],
    );
  }
}
