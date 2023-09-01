import 'package:dailydose/provider/saved_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:dailydose/constants/values.dart';
import 'package:dailydose/models/daily_news.dart';
import 'package:dailydose/ui/widgets/feed_image_widget.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Feed extends StatelessWidget {
  const Feed({super.key, required this.data});
  final DailyNewsArticles? data;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final readSaved = context.read<SavedProvider>();
    final watchSaved = context.watch<SavedProvider>();

    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(15),
        height: double.infinity,
        // width: double.infinity,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 0),
              color: Colors.black26,
              blurRadius: 6,
              spreadRadius: 1,
            ),
          ],
          color: colorScheme.surface,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        child: Column(
          children: [
            Expanded(
              child: FeedImageWidget(imageUrl: data?.image ?? ""),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              data?.title ?? "",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            Text(
              data?.description ?? "",
              style: textTheme.labelLarge,
            ),
            const SizedBox(
              height: 8,
            ),
            InkWell(
              onTap: () async {
                await launchUrl(
                  Uri.parse(data?.url ?? ""),
                );
              },
              borderRadius: kBorderRadius,
              child: Container(
                height: 76,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  borderRadius: kBorderRadius,
                ),
                child: Text(
                  data?.content ?? "",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: textTheme.bodySmall,
                ),
              ),
            ),
            const Divider(),
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          " ${data?.publishedAt?.substring(0, 10)}",
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: colorScheme.onBackground,
                          ),
                        ),
                        InkWell(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Text(
                              data?.source?.name.toString() ?? "",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style:
                                  TextStyle(color: Colors.lightBlue.shade900),
                            ),
                          ),
                          onTap: () async {
                            await launchUrl(
                              Uri.parse(data?.source?.url ?? ""),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (watchSaved.favouriteNews
                          .where((element) => element.url == data?.url)
                          .isEmpty) {
                        readSaved.addToFavourite = data!;
                      } else if (watchSaved.favouriteNews
                          .where((element) => element.url == data?.url)
                          .isNotEmpty) {
                        readSaved.removeFromFavourite(data!);
                      }
                    },
                    icon: watchSaved.favouriteNews
                            .where((element) =>
                                element.description == data?.description)
                            .isEmpty
                        ? const Icon(Icons.favorite_border)
                        : const Icon(Icons.favorite),
                    tooltip: "Add to favourite",
                  ),
                  IconButton(
                    onPressed: () async {
                      // await Clipboard.setData(
                      //     ClipboardData(text: widget.data!.url));
                      await FlutterShare.share(
                          title: data?.title ?? "",
                          text: data?.description ?? "",
                          linkUrl: data?.url ?? "",
                          chooserTitle: 'Daily Dose Share');
                    },
                    tooltip: "Share",
                    icon: const Icon(Icons.share),
                  ),
                  PopupMenuButton(
                    color: colorScheme.background,
                    shape: const RoundedRectangleBorder(
                      borderRadius: kBorderRadius,
                    ),
                    child: const Icon(Icons.more_vert),
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          onTap: () {
                            if (watchSaved.savedNews
                                .where((element) => element.url == data?.url)
                                .isEmpty) {
                              readSaved.addToSaved = data!;
                            } else if (watchSaved.savedNews
                                .where((element) => element.url == data?.url)
                                .isNotEmpty) {
                              readSaved.removeFromSaved(data!);
                            }
                          },
                          child: watchSaved.savedNews
                                  .where((element) => element.url == data?.url)
                                  .isEmpty
                              ? const Text("Save for Later")
                              : const Text("Removed from Saved"),
                        ),
                        PopupMenuItem(
                          onTap: () {
                            launchUrl(Uri.parse(data?.source?.url ?? ""));
                          },
                          child: Text(
                            "visit  ${data?.source?.name ?? ""}",
                          ),
                        )
                      ];

                      // return List.generate(
                      //   menuItems.length,
                      //   (index) {
                      //     return PopupMenuItem(
                      //       onTap: ,
                      //       child: Text(
                      //         menuItems[index],
                      //       ),
                      //     );
                      //   },
                      // );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
