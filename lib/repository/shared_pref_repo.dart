import 'package:dailydose/models/daily_news.dart';
import 'package:dailydose/utils/colored_log.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/settings.dart';

class SharedPrefRepo {
  static const String _settings = "settings";
  static const String _searchList = "search_list";
  static const String _favouriteNews = "favourite_news";
  static const String _saveForLater = "save_for_later";

  static Future<String?> updateSetting(Settings settings) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      return await prefs
          .setString(_settings, settings.toString())
          .then((value) {
        return "Settings Updated";
      });
    } catch (e) {
      ColoredLog.red(e, name: "update Setting Shared Pref error");
      return e.toString();
    }
  }

  static Future getSettings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final String? settings = prefs.getString(_settings);
      if (settings != null) {
        return settingsFromJsonString(settings);
      } else {
        return Settings();
      }
    } catch (e) {
      ColoredLog.red(e, name: "get Settings Shared Pref error");
      return e.toString();
    }
  }

  static Future updateSearchList(List<String> listOfSearches) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await prefs.setStringList(_searchList, listOfSearches).then((value) {
        return "List Updated";
      });
    } catch (e) {
      ColoredLog.red(e, name: "Update Search List Shared Pref error");
      return e.toString();
    }
  }

  static Future getSearchList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> listOfSearches = [];
    try {
      listOfSearches = prefs.getStringList(_searchList) ?? [];
      return listOfSearches;
    } catch (e) {
      ColoredLog.red(e, name: "getSearchList Shared Pref error");
      return e.toString();
    }
  }

  static Future updateFavouriteNews(DailyNews? dailyNews) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await prefs.setString(_favouriteNews, dailyNews.toString()).then((value) {
        return "List Updated";
      });
    } catch (e) {
      ColoredLog.red(e, name: "updateFavouriteNews Shared Pref error");
      return e.toString();
    }
  }

  static Future getFavouriteNews() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final newsString = prefs.getString(_favouriteNews);
      if (newsString != null) {
        return DailyNews.fromString(newsString);
      } else {
        return DailyNews();
      }
    } catch (e) {
      ColoredLog.red(e, name: "Get Favourite News Shared Pref error");
      return e.toString();
    }
  }

  static Future updateSaveForLaterNews(DailyNews? dailyNews) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await prefs.setString(_saveForLater, dailyNews.toString()).then((value) {
        return "List Updated";
      });
    } catch (e) {
      ColoredLog.red(e, name: "updateSaveForLaterNews Shared Pref error");
      return e.toString();
    }
  }

  static Future getSaveForLaterNews() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final newsString = prefs.getString(_saveForLater);
      if (newsString != null) {
        return DailyNews.fromString(newsString);
      } else {
        return DailyNews();
      }
    } catch (e) {
      ColoredLog.red(e, name: "getSaveForLaterNews Shared Pref error");
      return e.toString();
    }
  }
}
