import 'package:flutter/material.dart';
import 'package:dailydose/constants/themes.dart';
import 'package:dailydose/provider/theme_provider.dart';
import 'package:dailydose/provider/news_provider.dart';
import 'package:provider/provider.dart';

import 'provider/search_provider.dart';
import 'ui/homepage/homepage.dart';

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => NewsProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
      ],
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Daily Dose",
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: context.watch<ThemeProvider>().themeMode,
          home: const HomePage(),
        );
      },
    );
  }
}
