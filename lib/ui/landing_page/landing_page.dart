import 'package:dailydose/constants/values.dart';
import 'package:dailydose/provider/news_provider.dart';
import 'package:dailydose/ui/search_page/search_page.dart';
import 'package:dailydose/ui/widgets/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/feed.dart';

class LandingPage extends StatelessWidget {
  LandingPage({super.key, required this.onMenuPressed});
  final Function() onMenuPressed;

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<NewsProvider>();
    final read = context.read<NewsProvider>();
    final data = watch.dailyNews;
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: onMenuPressed,
        ),
        backgroundColor:
            Theme.of(context).colorScheme.background.withAlpha(240),
        elevation: 0,
        title: const Text('Daily Dose'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NewsSearchPage(),
                  ),
                );
              },
              icon: const Icon(Icons.search)),
        ],
      ),
      body: () {
        switch (watch.loadingState) {
          case LoadingState.loading:
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            );
          case LoadingState.error:
            return CustomErrorWidget(
              exceptionCaught: watch.getNewsException,
              onPressed: () {
                read.getDailyNews();
              },
            );
          case LoadingState.loaded:
            return PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              itemCount: data?.articles?.length ?? 0,
              itemBuilder: (context, index) {
                return Feed(
                  data: data?.articles?[index],
                );
              },
            );
          default:
            return Container();
        }
      }(),
    );
  }
}
