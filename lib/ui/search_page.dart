import 'package:dailydose/constants/values.dart';
import 'package:flutter/material.dart';

class NewsSearchPage extends StatefulWidget {
  const NewsSearchPage({super.key});

  @override
  State<NewsSearchPage> createState() => _NewsSearchPageState();
}

class _NewsSearchPageState extends State<NewsSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: kPaddingAll,
          child: Column(children: [
            TextField(
              decoration: InputDecoration(),
              keyboardType: TextInputType.url,
            )
          ]),
        ),
      ),
    );
  }
}
