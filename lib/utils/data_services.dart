import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:dailydose/constants/api_key.dart';
import 'package:dailydose/models/daily_news.dart';
import 'package:dailydose/utils/colored_log.dart';
import 'package:dailydose/utils/helper/faliure.dart';

getHttpRequest() async {
  const url =
      "https://gnews.io/api/v4/top-headlines?token=$kApiKey&topic=technology&lang=en";
  dynamic response;

  dynamic news;
  try {
    response = await http.get(Uri.parse(url));
    news = jsonDecode(response.body);
    return news;
  } on SocketException {
    ColoredLog.red("No Internet Found", name: "Error");
  } catch (e) {
    ColoredLog.red(e, name: "Error");
    return response;
  }

  ColoredLog.red(response.body, name: "Get Http Request");
}

Future<dynamic> getAssetJsonData(String path) async {
  dynamic news;

  try {
    var data = await rootBundle.loadString(path);
    news = jsonDecode(data);
    // print(news['articles']);
    ColoredLog.yellow(news["articles"], name: "Assets data");

    return DailyNews.fromJson(news);
  } catch (e) {
    ColoredLog.red(e, name: "Error Log");
  }
}
