import 'package:flutter/Material.dart';
import 'package:provider/provider.dart';

import '../../../constants/values.dart';
import '../../../provider/news_provider.dart';
import '../../../provider/search_provider.dart';
import '../../widgets/error_widget.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({super.key});

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<SearchProvider>();
    final read = context.read<SearchProvider>();
    final url = context.read<NewsProvider>().urlWithoutTopic;
    switch (watch.loadingState) {
      case LoadingState.loading:
        return Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        );
      case LoadingState.error:
        return CustomErrorWidget(
          exceptionCaught: watch.getNewsException,
          onPressed: () {
            read.searchNews(url);
          },
        );
      case LoadingState.loaded:
        return ListView.builder(
          itemCount: watch.searchNewsResult?.articles?.length ?? 0,
          itemBuilder: (context, index) {
            final news = watch.searchNewsResult?.articles?[index];
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: kBorderRadiusMedium,
              ),
              child: ListTile(
                onTap: () {},
                leading: Container(
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: kBorderRadiusMedium,
                    image: DecorationImage(
                      image: NetworkImage(news?.image ?? ""),
                      fit: BoxFit.fill,
                    ),
                  ),
                  // child: Image.network(news?.image ?? ""),
                ),
                title: Text(
                  news?.title ?? "",
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 3,
                ),
              ),
            );
          },
        );
      default:
        return Container();
    }
  }
}
