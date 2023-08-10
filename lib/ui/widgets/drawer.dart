import 'package:dailydose/test_widgets/textTheme.dart';
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
    return Container(
      height: double.infinity,
      width: MediaQuery.of(context).size.width * 0.7,
      color: Theme.of(context).colorScheme.background,
      // color: Colors.yellow,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SwitchListTile(
                title: const Text("Change Theme"),
                value:
                    context.watch<ThemeProvider>().themeMode == ThemeMode.dark,
                activeColor: Theme.of(context).colorScheme.onBackground,
                onChanged: (value) async {
                  context.read<ThemeProvider>().setThemeModeIndex =
                      value ? 0 : 1;
                },
              ),
              DropdownButton(
                dropdownColor: Theme.of(context).colorScheme.background,
                borderRadius: kBorderRadius,
                isExpanded: true,
                focusColor: Theme.of(context).colorScheme.tertiary,
                icon: ClipOval(
                  child: SvgPicture.network(
                    clipBehavior: Clip.antiAlias,
                    height: 50,
                    kListOfCountry[context.watch<UrlProvider>().countryIndex]
                        ['flag']!,
                  ),
                ),
                elevation: 8,
                underline: null,
                enableFeedback: true,
                hint: const Row(
                  children: [
                    Icon(Icons.location_on),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Country')
                  ],
                ),
                // value: kListOfCountry[
                //     context.watch<UrlProvider>().countryIndex]['name'],
                items: [
                  for (int i = 0; i < kListOfCountry.length; i++)
                    DropdownMenuItem(
                      value: kListOfCountry[i]['name'],
                      enabled: true,
                      onTap: () => context.read<UrlProvider>().setCountry = i,
                      child: Container(
                        decoration: BoxDecoration(
                            color:
                                context.watch<UrlProvider>().countryIndex == i
                                    ? Theme.of(context).colorScheme.secondary
                                    : Colors.transparent,
                            borderRadius: kBorderRadius),
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
                ],
                onChanged: (value) {},
              ),
              ListTile(
                title: const Text("Text Theme"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TextThemeWidget(),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
