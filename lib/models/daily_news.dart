import 'dart:convert';

class DailyNewsArticlesSource {
/*
{
  "name": "Hindustan Times",
  "url": "https://www.hindustantimes.com"
} 
*/

  String? name;
  String? url;

  DailyNewsArticlesSource({
    this.name,
    this.url,
  });
  DailyNewsArticlesSource.fromJson(Map<String, dynamic> json) {
    name = json['name']?.toString();
    url = json['url']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['url'] = url;
    return data;
  }
}

class DailyNewsArticles {
/*
{
  "title": "5 essential nutrients every woman must have after 40",
  "description": "A woman's body and mind can change a lot after she hits 40. However, with the right lifestyle changes, one can easily prevent health issues. | Health",
  "content": "A lot can change in a woman's body and mind when she hits 40. Some of the not-so-welcome changes could be accumulation of belly fat, a bit of weight gain, increased risk of diabetes, dementia and also certain kinds of cancer. Perimenopause stage coul... [2925 chars]",
  "url": "https://www.hindustantimes.com/lifestyle/health/5-essential-nutrients-every-woman-must-have-after-40-101682234133316.html",
  "image": "https://www.hindustantimes.com/ht-img/img/2023/04/23/1600x900/woman_in_40s_1682234220695_1682234232860.jpg",
  "publishedAt": "2023-04-23T07:23:15Z",
  "source": {
    "name": "Hindustan Times",
    "url": "https://www.hindustantimes.com"
  }
} 
*/

  String? title;
  String? description;
  String? content;
  String? url;
  String? image;
  String? publishedAt;
  DailyNewsArticlesSource? source;

  DailyNewsArticles({
    this.title,
    this.description,
    this.content,
    this.url,
    this.image,
    this.publishedAt,
    this.source,
  });
  DailyNewsArticles.fromString(String val) {
    Map<String, dynamic> json = jsonDecode(val);
    title = json['title']?.toString();
    description = json['description']?.toString();
    content = json['content']?.toString();
    url = json['url']?.toString();
    image = json['image']?.toString();
    publishedAt = json['publishedAt']?.toString();
    source = (json['source'] != null)
        ? DailyNewsArticlesSource.fromJson(json['source'])
        : null;
  }
  DailyNewsArticles.fromJson(Map<String, dynamic> json) {
    title = json['title']?.toString();
    description = json['description']?.toString();
    content = json['content']?.toString();
    url = json['url']?.toString();
    image = json['image']?.toString();
    publishedAt = json['publishedAt']?.toString();
    source = (json['source'] != null)
        ? DailyNewsArticlesSource.fromJson(json['source'])
        : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['content'] = content;
    data['url'] = url;
    data['image'] = image;
    data['publishedAt'] = publishedAt;
    if (source != null) {
      data['source'] = source!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}

class DailyNews {
/*
{
  "totalArticles": 422751,
  "articles": [
    {
      "title": "5 essential nutrients every woman must have after 40",
      "description": "A woman's body and mind can change a lot after she hits 40. However, with the right lifestyle changes, one can easily prevent health issues. | Health",
      "content": "A lot can change in a woman's body and mind when she hits 40. Some of the not-so-welcome changes could be accumulation of belly fat, a bit of weight gain, increased risk of diabetes, dementia and also certain kinds of cancer. Perimenopause stage coul... [2925 chars]",
      "url": "https://www.hindustantimes.com/lifestyle/health/5-essential-nutrients-every-woman-must-have-after-40-101682234133316.html",
      "image": "https://www.hindustantimes.com/ht-img/img/2023/04/23/1600x900/woman_in_40s_1682234220695_1682234232860.jpg",
      "publishedAt": "2023-04-23T07:23:15Z",
      "source": {
        "name": "Hindustan Times",
        "url": "https://www.hindustantimes.com"
      }
    }
  ]
} 
*/

  String? totalArticles;
  List<DailyNewsArticles?>? articles;

  DailyNews({
    this.totalArticles,
    this.articles,
  });
  DailyNews.fromJson(Map<String, dynamic> json) {
    totalArticles = json['totalArticles']?.toString();
    if (json['articles'] != null) {
      final v = json['articles'];
      final arr0 = <DailyNewsArticles>[];
      v.forEach((v) {
        arr0.add(DailyNewsArticles.fromJson(v));
      });
      articles = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['totalArticles'] = totalArticles;
    if (articles != null) {
      final v = articles;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v!.toJson());
      }
      data['articles'] = arr0;
    }
    return data;
  }

  DailyNews.fromString(String data) {
    final json = jsonDecode(data);
    totalArticles = json['totalArticles']?.toString();
    if (json['articles'] != null) {
      final v = json['articles'];
      final arr0 = <DailyNewsArticles>[];
      v.forEach((v) {
        arr0.add(DailyNewsArticles.fromJson(v));
      });
      articles = arr0;
    }
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
