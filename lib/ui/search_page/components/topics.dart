import 'package:flutter/material.dart';

import '../../../constants/category.dart';
import '../../../constants/values.dart';

class Topic extends StatefulWidget {
  const Topic({super.key, required this.onSelect});
  final Function(String? val)? onSelect;

  @override
  State<Topic> createState() => _TopicState();
}

class _TopicState extends State<Topic> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100)).then(
      (value) => setState(() => _opacity = 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(
        kListOfTopic.length,
        (index) => InkWell(
          borderRadius: kBorderRadius,
          onTap: () => widget.onSelect!(kListOfTopic[index]["name"]!),
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 200 * index),
            opacity: _opacity,
            child: Container(
              padding: kPaddingAll,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: kBorderRadius,
              ),
              margin: const EdgeInsets.all(4),
              child: Text(kListOfTopic[index]["name"]!),
            ),
          ),
        ),
      ),
    );
  }
}
