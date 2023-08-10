import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/category.dart';
import 'colored_log.dart';

class CountrySelector extends StatelessWidget {
  const CountrySelector({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: kListOfCountry.length,
      itemBuilder: (context, index) {
        String? countryName = kListOfCountry[index]['name'];
        String? flagUrl = kListOfCountry[index]['flag'];
        String? countryCode = kListOfCountry[index]['code'];
        return ListTile(
          title: Text(countryName!),
          leading: SvgPicture.network(flagUrl!),
          enableFeedback: true,
          onTap: () {
            ColoredLog(countryCode, name: "Country Code");
          },
          enabled: true,
        );
      },
    );
  }
}
