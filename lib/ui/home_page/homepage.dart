import 'package:dailydose/ui/search_page/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dailydose/constants/db_constants.dart';
import 'package:dailydose/models/daily_news.dart';
import 'package:dailydose/ui/widgets/drawer.dart';
import 'package:dailydose/ui/home_page/components/feed.dart';
import 'package:dailydose/utils/data_services.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DailyNews? data;
  final PageController _pageController = PageController();
  int currentPageIndex = 0;

  bool _onKey(KeyEvent event) {
    final key = event.logicalKey.keyLabel;
    if (key.toString() == "Arrow Down" || key.toString() == " ") {
      _pageController.nextPage(
          duration: const Duration(seconds: 1), curve: Curves.linearToEaseOut);
    } else if (key.toString() == "Arrow Up") {
      _pageController.previousPage(
          duration: const Duration(seconds: 1), curve: Curves.linearToEaseOut);
    } else if (key.toString() == "Enter" || key.toString() == "Arrow Right") {
      launchUrl(Uri.parse(data!.articles![currentPageIndex]!.url.toString()))
          .then((value) => null);
    }

    return false;
  }

  fetchData() async {
    var fetchedValue = await getAssetJsonData(kDailyNewsAssetPath);

    setState(() {
      data = fetchedValue;
    });
  }

  @override
  void initState() {
    fetchData();
    ServicesBinding.instance.keyboard.addHandler(_onKey);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      drawer: const CustomDrawer(),
      appBar: AppBar(
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
                    ));
              },
              icon: const Icon(Icons.search)),
        ],
      ),
      body: data == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              itemCount: data?.articles!.length,
              itemBuilder: (context, index) {
                currentPageIndex = index;
                return Feed(
                  data: data!.articles![index],
                );
              }),
    );
  }
}