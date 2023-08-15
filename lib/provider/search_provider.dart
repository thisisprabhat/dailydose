import 'package:dailydose/repository/shared_pref_repo.dart';
import 'package:dailydose/utils/colored_log.dart';
import 'package:flutter/material.dart';

import '../models/daily_news.dart';
import '../repository/get_daily_news_repo.dart';
import '../utils/app_exception.dart';

class SearchProvider extends ChangeNotifier {
  SearchProvider() {
    SharedPrefRepo.getSearchList().then((value) {
      _listOfSearches = value;
    });
  }

  void removeSearchHistory({int? index, bool removeAll = false}) {
    if (removeAll) {
      _listOfSearches = [];
    } else if (index != null) {
      if (_listOfSearches.length > 1) {
        _listOfSearches.removeAt(index);
      } else {
        _listOfSearches = [];
      }
    }
    notifyListeners();
    _updateSearchList();
  }

  set addSearchItem(String item) {
    if (_listOfSearches.contains(item)) {
      _listOfSearches.removeWhere((element) => element == item);
      _listOfSearches.insert(0, item);
    } else {
      _listOfSearches.insert(0, item);
    }
    _updateSearchList();
  }

  _updateSearchList() {
    SharedPrefRepo.updateSearchList(_listOfSearches);
  }

  List<String> _listOfSearches = [];

  List<String> get listOfSearches => _listOfSearches;

  set updateSearchIndex(int index) {
    if (_listOfSearches[index].isNotEmpty) {
      String value = _listOfSearches[index];
      _listOfSearches.removeAt(index);
      _listOfSearches.insert(0, value);
      notifyListeners();
    }
  }

//!~~~~~~~~Search News~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  DailyNews? searchNews;
  bool isSearchNewsLoaded = false;
  CustomException? getNewsException;

  getSearchedNews(String url, String value) {
    getNewsException = null;
    isSearchNewsLoaded = false;
    notifyListeners();
    String searchUrl = "$url&$value";
    ColoredLog.green(searchUrl, name: "Search Url");
    //   try {
    //     NewsRepo.getNews(searchUrl).then((value) {
    //       searchNews = value;
    //     }).whenComplete(() {
    //       isSearchNewsLoaded = true;
    //       notifyListeners();
    //     });
    //   } on CustomException catch (e) {
    //     getNewsException = e;
    //     isSearchNewsLoaded = true;
    //     notifyListeners();
    //   }
  }
}
