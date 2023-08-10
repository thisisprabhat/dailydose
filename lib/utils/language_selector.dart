import 'package:dailydose/utils/colored_log.dart';
import 'package:flutter/material.dart';

import '../constants/category.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: kListOfLanguage.length,
      itemBuilder: (context, index) {
        String? languageName = kListOfLanguage[index]['name'];
        String? languageCode = kListOfLanguage[index]['code'];
        return ListTile(
          title: Text(languageName!),
          enableFeedback: true,
          onTap: () {
            ColoredLog(languageCode, name: "Language Code");
          },
          enabled: true,
        );
      },
    );
  }
}
