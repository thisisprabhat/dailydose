import 'package:dailydose/constants/values.dart';
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

  String get urlWithoutTopic {
    String token = "?token=$kApiKey";
    String country = "&country=${kListOfCountry[countryIndex]['code']}";
    String language = "&lang=${kListOfLanguage[languageIndex]['code']}";
    return baseUrl + token + country + language;
  }

  String get url {
    String topic = "&topic=${kListOfTopic[topicIndex]["code"]}";
    return urlWithoutTopic + topic;
  }

  Settings _setting = Settings();
  _updateSetting() {
    SharedPrefRepo.updateSetting(_setting);
  }

  int get countryIndex => _setting.country ?? 0;
  set setCountry(int index) {
    _setting.country = index;
    _updateSetting();
    getDailyNews();
  }

  int get topicIndex => _setting.topic ?? 0;
  set setTopic(int index) {
    _setting.topic = index;
    _updateSetting();
    getDailyNews();
  }

  int get languageIndex => _setting.language ?? 0;
  set setLanguage(int index) {
    _setting.language = index;
    _updateSetting();
    getDailyNews();
  }

//!~~~~~~~~~~~Get News~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  DailyNews? dailyNews;
  LoadingState loadingState = LoadingState.loading;
  CustomException? getNewsException;

  getDailyNews() {
    dailyNews = null;
    getNewsException = null;
    loadingState = LoadingState.loading;
    notifyListeners();

    NewsRepo.getNews(url).then((value) {
      if (value is DailyNews) {
        if (value.articles?.isEmpty ?? false) {
          getNewsException = NotFoundException();
          loadingState = LoadingState.error;
        } else {
          dailyNews = value;
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
