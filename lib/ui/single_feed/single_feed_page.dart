import 'package:dailydose/models/daily_news.dart';
import 'package:dailydose/ui/widgets/feed.dart';
import 'package:flutter/Material.dart';

class SingleFeedPage extends StatelessWidget {
  const SingleFeedPage({super.key, this.data});
  final DailyNewsArticles? data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor:
            Theme.of(context).colorScheme.background.withAlpha(240),
        elevation: 0,
        title: Text(data?.source?.name ?? ""),
      ),
      body: Feed(data: data),
    );
  }
}
