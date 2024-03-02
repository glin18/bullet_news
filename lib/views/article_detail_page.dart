import 'package:flutter/material.dart';
import 'package:bullet_news/models/news.dart';

class ArticleDetailPage extends StatelessWidget {
  final News news;

  const ArticleDetailPage({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(news.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (news.urlToImage.isNotEmpty)
              Image.network(
                news.urlToImage,
                errorBuilder: (context, error, stackTrace) {
                  debugPrint(news.urlToImage);
                  return const SizedBox.shrink();
                },
              ),
            const SizedBox(height: 8),
            Text(
              news.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              news.publishedAt,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              news.summary,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
