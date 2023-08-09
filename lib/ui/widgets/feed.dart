import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:dailydose/constants/values.dart';
import 'package:dailydose/models/daily_news.dart';
import 'package:dailydose/ui/widgets/feed_image_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class Feed extends StatefulWidget {
  const Feed({super.key, required this.data});
  final DailyNewsArticles? data;

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  double scaleFactor = 1;

  void changeScaleFactor() {
    Future.delayed(const Duration(seconds: 2));
    setState(() {
      scaleFactor += 2;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    // changeScaleFactor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

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
            Expanded(child: FeedImageWidget(imageUrl: widget.data!.image!)),
            const SizedBox(
              height: 5,
            ),
            Text(
              widget.data!.title!,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
            Text(
              widget.data!.description!,
              style: textTheme.labelLarge,
            ),
            const SizedBox(
              height: 8,
            ),
            InkWell(
              onTap: () async {
                await launchUrl(Uri.parse(widget.data!.url!));
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
                  widget.data!.content!,
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
                          " ${widget.data!.publishedAt!.substring(0, 10)}",
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: colorScheme.onBackground),
                        ),
                        InkWell(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Text(
                              widget.data!.source!.name.toString(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style:
                                  TextStyle(color: Colors.lightBlue.shade900),
                            ),
                          ),
                          onTap: () async {
                            await launchUrl(
                                Uri.parse(widget.data!.source!.url!));
                          },
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.favorite),
                    tooltip: "Add to favourite",
                  ),
                  IconButton(
                      onPressed: () async {
                        // await Clipboard.setData(
                        //     ClipboardData(text: widget.data!.url));
                        await FlutterShare.share(
                            title: widget.data!.title!,
                            text: widget.data!.description,
                            linkUrl: widget.data!.url,
                            chooserTitle: 'Daily Dose Share');
                      },
                      tooltip: "Share",
                      icon: const Icon(Icons.share)),
                  PopupMenuButton(
                    shape: const RoundedRectangleBorder(
                        borderRadius: kBorderRadius),
                    child: const Icon(Icons.more_vert),
                    itemBuilder: (context) {
                      List<String> menuItems = [
                        "Report content",
                        "Save for later",
                        "visit ${widget.data!.source}"
                      ];
                      return List.generate(
                        menuItems.length,
                        (index) {
                          return PopupMenuItem(
                            child: Text(
                              menuItems[index],
                            ),
                          );
                        },
                      );
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
