import 'package:dailydose/models/daily_news.dart';
import 'package:dailydose/utils/app_exception.dart';
import 'package:http/http.dart' as http;

import '../utils/colored_log.dart';

class NewsRepo {
  static Future getNews(url) async {
    ColoredLog.blue(url, name: "getDailyNewsUrl");
    http.Response? response;
    DailyNews? news;
    try {
      response = await http.get(Uri.parse(url));
      news = DailyNews.fromString(response.body);
      ColoredLog(news, name: "Response object");
      return news;
    } catch (e) {
      AppExceptionHandler.handleExceptions(e, response?.statusCode);
    }
    ColoredLog.red(response?.body, name: "Get Http Request");
  }
}
