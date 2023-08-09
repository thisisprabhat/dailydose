import 'package:dailydose/constants/category.dart';
import 'package:dailydose/constants/values.dart';
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
        setState(() {
          showCategory = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        // The search area here
        title: Container(
          width: double.infinity,
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
                  onPressed: () {
                    _controller.clear();
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
            padding: const EdgeInsets.only(right: 8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.onBackground,
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
      ),
      body: Padding(
        padding: kPaddingAll,
        child: Column(
          children: [
            const SizedBox(height: 10),
            if (showCategory && _controller.text.isEmpty)
              Expanded(
                child: Wrap(
                  children: List.generate(
                    kListOfTopic.length,
                    (index) => InkWell(
                      borderRadius: kBorderRadius,
                      onTap: () {},
                      child: Container(
                        padding: kPaddingAll,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: kBorderRadius,
                        ),
                        margin: const EdgeInsets.all(4),
                        child: Text(kListOfTopic[index]["name"]!),
                      ),
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
