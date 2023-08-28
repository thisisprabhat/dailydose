import 'package:dailydose/repository/shared_pref_repo.dart';
import 'package:dailydose/utils/colored_log.dart';
import 'package:flutter/material.dart';

import '../constants/values.dart';
import '../models/daily_news.dart';
import '../repository/get_daily_news_repo.dart';
import '../utils/app_exception.dart';

class SearchProvider extends ChangeNotifier {
  SearchProvider() {
    SharedPrefRepo.getSearchList().then((value) {
      _listOfSearches = value;
    });
  }

  TextEditingController searchController = TextEditingController();
  set onTopicSelect(String value) {
    searchController.text = value;
    notifyListeners();
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
    } else if (item.length >= 3) {
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
  DailyNews? searchNewsResult;
  LoadingState loadingState = LoadingState.hidden;
  CustomException? getNewsException;
  set updateLoadingState(LoadingState state) {
    loadingState = state;
    notifyListeners();
  }

  searchNews(urlWithoutTopic, {String? topic}) {
    searchNewsResult = null;
    getNewsException = null;
    String url = "$urlWithoutTopic${topic ?? "&q=${searchController.text}"}";
    loadingState = LoadingState.loading;
    notifyListeners();

    NewsRepo.getNews(url).then((value) {
      if (value is DailyNews) {
        if (value.articles?.isEmpty ?? false) {
          getNewsException = NotFoundException();
          loadingState = LoadingState.error;
        } else {
          searchNewsResult = value;
          loadingState = LoadingState.loaded;
        }
      } else if (value is CustomException) {
        loadingState = LoadingState.error;
        getNewsException = value;
      } else {
        getNewsException = CustomException();
        loadingState = LoadingState.error;
      }
    }).whenComplete(() {
      notifyListeners();
    });
  }
}
