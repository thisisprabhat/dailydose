import 'package:dailydose/models/daily_news.dart';
import 'package:flutter/cupertino.dart';
import '../repository/shared_pref_repo.dart';

class SavedProvider extends ChangeNotifier {
  SavedProvider() {
    SharedPrefRepo.getSaveForLaterNews().then((value) {
      savedNews = value;
    });
    SharedPrefRepo.getFavouriteNews().then((value) {
      favouriteNews = value;
    });
  }

  //Saved news
  List<DailyNewsArticles> savedNews = [];

  set addToSaved(DailyNewsArticles news) {
    savedNews.insert(0, news);
    SharedPrefRepo.updateSaveForLaterNews(savedNews);
    notifyListeners();
  }

  removeFromSaved(DailyNewsArticles news) {
    savedNews.removeWhere((element) => element.url == news.url);
    SharedPrefRepo.updateSaveForLaterNews(savedNews);
    notifyListeners();
  }

  //Favourite news
  List<DailyNewsArticles> favouriteNews = [];

  set addToFavourite(DailyNewsArticles news) {
    favouriteNews.insert(0, news);
    SharedPrefRepo.updateFavouriteNews(favouriteNews);
    notifyListeners();
  }

  removeFromFavourite(DailyNewsArticles news) {
    favouriteNews.removeWhere((element) => element.url == news.url);
    SharedPrefRepo.updateFavouriteNews(favouriteNews);
    notifyListeners();
  }
}
