import 'package:flutter/cupertino.dart';
import 'package:dailydose/constants/api_key.dart';
import 'package:dailydose/constants/category.dart';

class UrlProvider extends ChangeNotifier {
  final String baseUrl = "https://gnews.io/api/v4/";
  final String apiKey = kApiKey;
  int _countryIndex = 0;
  int _topicIndex = 0;
  int _languageIndex = 0;

  String? get countryCode => kListOfCountry[_countryIndex]['code'];
  int get countryIndex => _countryIndex;
  set setCountry(int index) {
    _countryIndex = index;
    notifyListeners();
  }

  String? get topicCode => kListOfTopic[_topicIndex]['code'];
  int get topicIndex => _topicIndex;
  set setTopic(int index) {
    _topicIndex = index;
    notifyListeners();
  }

  String? get languageCode => kListOfLanguage[_languageIndex]['code'];
  int get languageIndex => _languageIndex;
  set setLanguage(int index) {
    _languageIndex = index;
    notifyListeners();
  }
}
