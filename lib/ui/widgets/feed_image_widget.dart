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
        AnimationController(duration: const Duration(seconds: 70), vsync: this);

    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(seconds: 5)).then((val) {
          _controller.reverse();
        });
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.removeStatusListener((status) {});
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius: kBorderRadius,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: colorScheme.surfaceVariant,
              image: DecorationImage(
                onError: (exception, stackTrace) =>
                    const CircularProgressIndicator(),
                image: NetworkImage(widget.imageUrl),
                fit: BoxFit.fitHeight,
                filterQuality: FilterQuality.low,
                alignment: Alignment(animation.value, 0),
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.65),
                  BlendMode.multiply,
                ),
              ),
              borderRadius: kBorderRadius,
            ),
            child: Image.network(
              errorBuilder: (context, error, stackTrace) => Center(
                child: Text(
                  "${error.toString()}\nFailed to load image...",
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
          );
        },
      ),
    );
  }
}
