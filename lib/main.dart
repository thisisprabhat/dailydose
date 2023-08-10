import 'package:flutter/material.dart';
import 'package:dailydose/constants/themes.dart';
import 'package:dailydose/provider/theme_provider.dart';
import 'package:dailydose/provider/url_provider.dart';
import 'package:provider/provider.dart';

import 'ui/home_page/homepage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool opened = false;

  // Future<void> openBox() async {
  //   if (!Hive.isAdapterRegistered(0)) {
  //     Hive.registerAdapter(NewsDetailsAdapter());
  //   }
  //   var dir = await getApplicationDocumentsDirectory();
  //   print(dir.path);
  //   Hive.initFlutter(dir.path);

  //   var themeBox = await Hive.openBox<int>(kThemeBox);
  //   print(themeBox.get(0));

  //   var newsBox = await Hive.openBox<NewsDetails>(kScienceNews);
  //   setState(() {
  //     opened = true;
  //   });
  // }

  @override
  void initState() {
    // getHttpRequest();
    // getAssetJsonData(kDailyNewsAssetPath);
    // openBox();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ChangeNotifierProvider(create: (_) => UrlProvider())
        ],
        builder: (context, child) {
          // context.read<ThemeProvider>().setThemeModeIndex =
          //     Hive.box(kThemeBox).get(0);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Daily Dose",
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: context.watch<ThemeProvider>().themeMode,
            home: const HomePage(),
          );
        });
  }
}
