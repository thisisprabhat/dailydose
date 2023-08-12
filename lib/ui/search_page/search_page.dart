import 'package:dailydose/constants/category.dart';
import 'package:dailydose/constants/values.dart';
import 'package:dailydose/ui/search_page/components/topics.dart';
import 'package:dailydose/utils/colored_log.dart';
import 'package:flutter/material.dart';

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
        Future.delayed(const Duration(milliseconds: 200))
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
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: _appBar(),
      body: Padding(
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
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      Future.delayed(const Duration(milliseconds: 200));
                      return ListTile(
                        onTap: () {
                          _controller.text = index.toString();
                          ColoredLog.green(index, name: "listTile index");
                        },
                        title: Text("the index is $index"),
                      );
                    }),
              )
          ],
        ),
      ),
    );
  }

  AppBar _appBar() => AppBar(
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
            padding: const EdgeInsets.only(right: 8.0, top: 10, bottom: 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.onBackground,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
              ),
              onPressed: () {},
              child: const Text("Search"),
            ),
          ),
        ],
      );
}
