import 'package:bullet_news/models/news.dart';
import 'package:flutter/material.dart';

class NewsListItem extends StatelessWidget {
  final News news;
  const NewsListItem({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Text(news.title),
    );
  }
}
