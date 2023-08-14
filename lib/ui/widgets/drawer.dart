import 'package:dailydose/ui/favourites_and_saved/favourites_and_saved.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dailydose/constants/category.dart';
import 'package:dailydose/constants/values.dart';
import 'package:dailydose/provider/url_provider.dart';
import 'package:provider/provider.dart';

import '../../provider/theme_provider.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              "assets/images/logo.png",
              height: 80,
              width: 80,
            ),
            const Text(
              "Daily Dose",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            Expanded(child: _items()),
          ],
        ),
      ),
    );
  }

  _items() {
    final colorScheme = Theme.of(context).colorScheme;
    return ListView(
      children: [
        ListTile(
          title: const Text("Favourites"),
          leading: const Icon(Icons.favorite),
          contentPadding: const EdgeInsets.all(0),
          enabled: true,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const FavouritesAndSavedPage(),
              ),
            );
          },
        ),
        ListTile(
          title: const Text("Saved"),
          leading: const Icon(Icons.save),
          contentPadding: const EdgeInsets.all(0),
          enabled: true,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const FavouritesAndSavedPage(
                  isSaved: true,
                ),
              ),
            );
          },
        ),
        ListTile(
          title: const Text("Dark Mode"),
          leading: const Icon(Icons.dark_mode),
          contentPadding: const EdgeInsets.all(0),
          trailing: Switch(
            value: context.watch<ThemeProvider>().themeMode == ThemeMode.dark,
            onChanged: (value) async {
              context.read<ThemeProvider>().setThemeModeIndex = value ? 0 : 1;
            },
            activeColor: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        DropdownButton(
          dropdownColor: Theme.of(context).colorScheme.surface,
          borderRadius: kBorderRadius,
          isExpanded: true,
          focusColor: Theme.of(context).colorScheme.tertiary,
          icon: ClipRRect(
            borderRadius: kBorderRadius,
            child: SvgPicture.network(
              height: 50,
              kListOfCountry[context.watch<NewsProvider>().countryIndex]
                  ['flag']!,
            ),
          ),
          elevation: 10,
          underline: const SizedBox.shrink(),
          enableFeedback: true,
          hint: Row(
            children: [
              const Icon(Icons.location_on),
              const SizedBox(width: 10),
              Text(
                'Country',
                style: Theme.of(context).textTheme.titleSmall,
              )
            ],
          ),
          items: List.generate(
            kListOfCountry.length,
            (i) => DropdownMenuItem(
              value: kListOfCountry[i]['name'],
              enabled: true,
              onTap: () => context.read<NewsProvider>().setCountry = i,
              child: Container(
                decoration: BoxDecoration(
                  color: context.watch<NewsProvider>().countryIndex == i
                      ? Theme.of(context).colorScheme.secondary
                      : Colors.transparent,
                  borderRadius: kBorderRadius,
                ),
                child: Row(
                  children: [
                    SvgPicture.network(
                      kListOfCountry[i]['flag']!,
                    ),
                    Text(
                      kListOfCountry[i]['name']!,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ),
          onChanged: (value) {},
        ),
        DropdownButton(
          dropdownColor: Theme.of(context).colorScheme.surface,
          borderRadius: kBorderRadius,
          isExpanded: true,
          focusColor: Theme.of(context).colorScheme.tertiary,
          elevation: 10,
          underline: const SizedBox.shrink(),
          enableFeedback: true,
          icon: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: kBorderRadiusSmall,
            ),
            child: Text(
              kListOfLanguage[context.watch<NewsProvider>().languageIndex]
                      ['code'] ??
                  "",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          hint: Row(
            children: [
              const Icon(Icons.language),
              const SizedBox(width: 10),
              Text(
                'Language',
                style: Theme.of(context).textTheme.titleSmall,
              )
            ],
          ),
          items: List.generate(
            kListOfLanguage.length,
            (i) => DropdownMenuItem(
              value: kListOfLanguage[i]['name'],
              enabled: true,
              onTap: () => context.read<NewsProvider>().setLanguage = i,
              child: Container(
                decoration: BoxDecoration(
                  color: context.watch<NewsProvider>().languageIndex == i
                      ? Theme.of(context).colorScheme.secondary
                      : Colors.transparent,
                  borderRadius: kBorderRadius,
                ),
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        kListOfLanguage[i]['name'] ?? "",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color:
                              context.watch<NewsProvider>().languageIndex == i
                                  ? Colors.black
                                  : colorScheme.onBackground,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: context.watch<NewsProvider>().languageIndex == i
                            ? Theme.of(context).colorScheme.tertiary
                            : colorScheme.background,
                        borderRadius: kBorderRadiusSmall,
                      ),
                      child: Text(
                        kListOfLanguage[i]['code'] ?? "",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color:
                                  context.watch<NewsProvider>().languageIndex ==
                                          i
                                      ? Colors.black
                                      : colorScheme.onBackground,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          onChanged: (value) {},
        ),
        ExpansionTile(
          // collapsedIconColor: colorScheme.onBackground,
          collapsedIconColor: colorScheme.onSurface,
          iconColor: colorScheme.onBackground,
          leading: const Icon(Icons.topic),
          title: const Text("Topic"),
          tilePadding: EdgeInsets.zero,
          children: [
            ...List.generate(
              kListOfTopic.length,
              (index) => ListTile(
                enabled: true,
                onTap: () {
                  context.read<NewsProvider>().setTopic = index;
                },
                selected: index == context.watch<NewsProvider>().topicIndex,
                selectedColor: colorScheme.tertiary,
                selectedTileColor: Colors.green,
                title: Text(kListOfTopic[index]['name'] ?? ""),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
