import 'package:flutter/material.dart';

import '../constants/category.dart';

class TopicSelector extends StatelessWidget {
  const TopicSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: kListOfTopic.length,
      itemBuilder: (context, index) {
        String? topicName = kListOfTopic[index]['name'];
        String? topicCode = kListOfTopic[index]['code'];
        return ListTile(
          title: Text(topicName!),
          enableFeedback: true,
          onTap: () {
            print(topicCode);
          },
          enabled: true,
        );
      },
    );
  }
}
