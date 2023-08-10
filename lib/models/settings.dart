import 'dart:convert';

Settings settingsFromJsonString(String str) =>
    Settings.fromJson(json.decode(str));

String settingsToJson(Settings data) => json.encode(data.toJson());

class Settings {
  bool? darkMode;
  int? language;
  int? topic;
  int? country;

  Settings({
    this.darkMode,
    this.language,
    this.topic,
    this.country,
  });

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
        darkMode: json["darkMode"] ?? true,
        language: json["language"] ?? 0,
        topic: json["topic"] ?? 0,
        country: json["country"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "darkMode": darkMode ?? true,
        "language": language ?? 0,
        "topic": topic ?? 0,
        "country": country ?? 0,
      };
  @override
  String toString() => jsonEncode(toJson());
}
