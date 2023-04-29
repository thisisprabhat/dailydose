import 'package:hive/hive.dart';

part 'news_details.g.dart';

@HiveType(typeId: 0)
class NewsDetails {
  @HiveField(0)
  String? title;
  @HiveField(1)
  String? description;
  @HiveField(2)
  String? content;
  @HiveField(3)
  String? url;
  @HiveField(4)
  String? image;
  @HiveField(5)
  String? publishedAt;
  @HiveField(6)
  String? sourceName;
  @HiveField(7)
  String? sourceUrl;

  NewsDetails(
      {this.title,
      this.description,
      this.content,
      this.url,
      this.image,
      this.publishedAt,
      this.sourceName,
      this.sourceUrl});

  NewsDetails.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    content = json['content'];
    url = json['url'];
    image = json['image'];
    publishedAt = json['publishedAt'];
    sourceName = json['source']['name'];
    sourceUrl = json['source']['url'];
  }
}
