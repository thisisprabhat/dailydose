import 'package:dailydose/models/daily_news.dart';
import 'package:dailydose/models/settings.dart';
import 'package:dailydose/repository/get_daily_news_repo.dart';
import 'package:dailydose/repository/shared_pref_repo.dart';
import 'package:dailydose/utils/app_exception.dart';
import 'package:flutter/cupertino.dart';
import 'package:dailydose/constants/api_key.dart';
import 'package:dailydose/constants/category.dart';

class NewsProvider extends ChangeNotifier {
  NewsProvider() {
    initMethod();
  }

  initMethod() async {
    _setting = await SharedPrefRepo.getSettings();
    getDailyNews();
  }

  //! Url Provider______________________________________________________________
  final String baseUrl = "https://gnews.io/api/v4/top-headlines";
  String get url {
    String token = "?token=$kApiKey";
    String country = "&country=${kListOfCountry[countryIndex]['code']}";
    String language = "&lang=${kListOfLanguage[languageIndex]['code']}";
    String topic = "&topic=${kListOfTopic[topicIndex]["code"]}";
    return baseUrl + token + country + language + topic;
  }

  Settings _setting = Settings();
  _updateSetting() {
    SharedPrefRepo.updateSetting(_setting);
  }

  int get countryIndex => _setting.country ?? 0;
  set setCountry(int index) {
    _setting.country = index;
    _updateSetting();
    notifyListeners();
  }

  int get topicIndex => _setting.topic ?? 0;
  set setTopic(int index) {
    _setting.topic = index;
    _updateSetting();
    notifyListeners();
  }

  int get languageIndex => _setting.language ?? 0;
  set setLanguage(int index) {
    _setting.language = index;
    _updateSetting();
    notifyListeners();
  }

//!~~~~~~~~~~~Get News~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  DailyNews? dailyNews;
  bool isDailyNewsLoaded = false;
  CustomException? getNewsException;

  getDailyNews() {
    dailyNews = null;
    getNewsException = null;
    isDailyNewsLoaded = false;
    notifyListeners();
    try {
      NewsRepo.getNews(url).then((value) {
        dailyNews = value;
      }).whenComplete(() {
        isDailyNewsLoaded = true;
        notifyListeners();
      });
    } on CustomException catch (e) {
      getNewsException = e;
      isDailyNewsLoaded = true;
      notifyListeners();
    }
  }
}
