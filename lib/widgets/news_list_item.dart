import 'package:bullet_news/models/news.dart';
import 'package:bullet_news/views/article_detail_page.dart';
import 'package:flutter/material.dart';

class NewsListItem extends StatelessWidget {
  final News news;
  const NewsListItem({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _navigateToArticleDetailPage(context),
      child: Card(
        margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImage(context),
              const SizedBox(height: 8),
              _buildTitle(context),
              const SizedBox(height: 8),
              _buildDescription(context),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToArticleDetailPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ArticleDetailPage(news: news),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      news.title,
      style: Theme.of(context).textTheme.titleLarge,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Text(
      news.description,
      style: Theme.of(context).textTheme.bodyMedium,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      maxLines: 3,
    );
  }

  Widget _buildImage(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: news.urlToImage.isNotEmpty
          ? Image.network(
              news.urlToImage,
              width: double.infinity,
              fit: BoxFit.cover,
              height: 200,
              errorBuilder: (_, __, ___) => _imageFallback(),
            )
          : _imageFallback(),
    );
  }

  Widget _imageFallback() {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 57, 52, 58),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
