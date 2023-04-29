import 'package:flutter/material.dart';

import '../../constants/values.dart';

class FeedImageWidget extends StatefulWidget {
  const FeedImageWidget({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  State<FeedImageWidget> createState() => _FeedImageWidgetState();
}

class _FeedImageWidgetState extends State<FeedImageWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> animation;

  double scaleFactor = 1;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    AnimationController(duration: const Duration(seconds: 2), vsync: this);

    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInToLinear,
    ));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius: kBorderRadius,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: colorScheme.surfaceVariant,
          image: DecorationImage(
            onError: (exception, stackTrace) =>
                const CircularProgressIndicator(),
            // scale:  animation.value,

            image: NetworkImage(widget.imageUrl),
            fit: BoxFit.fitHeight,
            filterQuality: FilterQuality.low,
            alignment: Alignment.centerLeft,
            colorFilter: const ColorFilter.mode(
              Colors.black54,
              BlendMode.multiply,
            ),
          ),
          borderRadius: kBorderRadius,
        ),
        child: Image.network(
          errorBuilder: (context, error, stackTrace) => Center(
            child: Text(
              "${error.toString().substring(32, 36)}\nFailed to load image...",
              textAlign: TextAlign.center,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
          widget.imageUrl,
          fit: BoxFit.fitWidth,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                color: colorScheme.onBackground,
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
        ),
      ),
    );
  }
}


//  Image.network(
//                   widget.networkUrl,
//                   fit: BoxFit.fill,
//                   loadingBuilder: (BuildContext context, Widget child,
//                       ImageChunkEvent? loadingProgress) {
//                     if (loadingProgress == null) return child;
//                     return Center(
//                       child: CircularProgressIndicator(
//                         value: loadingProgress.expectedTotalBytes != null
//                             ? loadingProgress.cumulativeBytesLoaded /
//                                 loadingProgress.expectedTotalBytes!
//                             : null,
//                       ),
//                     );
//                   },