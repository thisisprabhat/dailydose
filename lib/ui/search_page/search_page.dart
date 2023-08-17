import 'package:dailydose/constants/values.dart';
import 'package:dailydose/provider/news_provider.dart';
import 'package:dailydose/provider/search_provider.dart';
import 'package:dailydose/ui/search_page/components/topics.dart';
import 'package:dailydose/utils/colored_log.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class NewsSearchPage extends StatefulWidget {
  const NewsSearchPage({super.key});

  @override
  State<NewsSearchPage> createState() => _NewsSearchPageState();
}

class _NewsSearchPageState extends State<NewsSearchPage> {
  final TextEditingController _controller = TextEditingController();
  bool showCategory = true;

  late FocusNode _searchFocusNode;

  @override
  void initState() {
    super.initState();

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
    final read = context.read<SearchProvider>();
    final url = context.read<NewsProvider>().url;
    return Scaffold(
      appBar: _appBar(),
      body: GestureDetector(
        onTap: () {
          // setState(() => _searchFocusNode.unfocus());
        },
        child: Padding(
          padding: kPaddingAll,
          child: Column(
            children: [
              const SizedBox(height: 10),
              if (showCategory && _controller.text.isEmpty)
                Expanded(
                  child: Topic(
                    onSelect: (val) {
                      ColoredLog.yellow(val);
                    },
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: watch.listOfSearches.length,
                    itemBuilder: (BuildContext context, int index) {
                      String val = watch.listOfSearches[index];
                      return ListTile(
                        hoverColor: Colors.transparent,
                        title: Text(val),
                        onTap: () {
                          _controller.text = val;
                          read.updateSearchIndex = index;
                          read.getSearchedNews(url, val);
                        },
                        trailing: IconButton(
                          icon: const Icon(Icons.cancel),
                          onPressed: () {
                            read.removeSearchHistory(index: index);
                          },
                        ),
                      );
                    },
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appBar() {
    final read = context.read<SearchProvider>();
    final url = context.read<NewsProvider>().url;
    return AppBar(
      // The search area here
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
            controller: _controller,
            onSubmitted: (value) {
              read.getSearchedNews(url, value);
              read.addSearchItem = value;
            },
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () => setState(() => _controller.clear()),
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
              read.getSearchedNews(url, _controller.text);
              read.addSearchItem = _controller.text;
            },
            child: const Text("Search"),
          ),
        ),
      ],
    );
  }
}
