import 'package:dailydose/models/daily_news.dart';
import 'package:dailydose/utils/colored_log.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/settings.dart';

class SharedPrefRepo {
  static const String _settings = "settings";
  static const String _searchList = "search_list";
  static const String _favouriteNews = "favourite_news";
  static const String _saveForLater = "save_for_later";
  static const String _darkModeValue = "daily_dose_dark_mode";

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

  static Future updateFavouriteNews(List<DailyNewsArticles> news) async {
    ColoredLog.green(news.length, name: "Favourite Items length");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await prefs
          .setStringList(_favouriteNews, news.map((e) => e.toString()).toList())
          .then((value) {
        return "List Updated";
      });
    } catch (e) {
      ColoredLog.red(e, name: "updateFavouriteNews Shared Pref error");
      return e.toString();
    }
  }

  static Future getFavouriteNews() async {
    ColoredLog.green("Getting favourites News");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<DailyNewsArticles> listOfFavouriteNews = [];
    try {
      List<String>? listInString = prefs.getStringList(_favouriteNews);
      if (listInString != null) {
        listOfFavouriteNews = listInString
                .map((element) => DailyNewsArticles.fromString(element))
                .toList() ??
            [];
        return listOfFavouriteNews;
      } else {
        return [];
      }
    } catch (e) {
      ColoredLog.red(e, name: "Get Favourite News Shared Pref error");
      return e.toString();
    }
  }

  static Future updateSaveForLaterNews(List<DailyNewsArticles> news) async {
    ColoredLog.green(news.length, name: "Saved Items length");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await prefs
          .setStringList(_saveForLater, news.map((e) => e.toString()).toList())
          .then((value) {
        return "List Updated";
      });
    } catch (e) {
      ColoredLog.red(e, name: "UpdateSaveForLaterNews Shared Pref error");
      return e.toString();
    }
  }

  static Future getSaveForLaterNews() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<DailyNewsArticles> listofSavedForLaterNews = [];
    try {
      List<String>? listInString = prefs.getStringList(_saveForLater);
      if (listInString != null) {
        listofSavedForLaterNews = listInString
                .map((element) => DailyNewsArticles.fromString(element))
                .toList() ??
            [];
        return listofSavedForLaterNews;
      } else {
        return [];
      }
    } catch (e) {
      ColoredLog.red(e, name: "Get SavedForLater News Shared Pref error");
      return e.toString();
    }
  }

  static Future getThemeModeIndex() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final themeModeIndex = prefs.getInt(_darkModeValue);
      if (themeModeIndex != null) {
        return themeModeIndex;
      } else {
        return 2;
      }
    } catch (e) {
      ColoredLog.red(e, name: "getDarkModeValue Shared Pref error");
      return e.toString();
    }
  }

  static Future updateThemeModeIndex(int themeModeIndex) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await prefs.setInt(_darkModeValue, themeModeIndex).then((value) {
        return "List Updated";
      });
    } catch (e) {
      ColoredLog.red(e, name: "updateSaveForLaterNews Shared Pref error");
      return e.toString();
    }
  }
}
