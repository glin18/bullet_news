import 'package:bullet_news/models/news.dart';
import 'package:bullet_news/widgets/news_list_item.dart';
import 'package:flutter/material.dart';

class NewsList extends StatelessWidget {
  final String category;
  final List<News> newsList = [
    News(title: "Article 1", description: "Description of Article 1"),
    News(title: "Article 2", description: "Description of Article 2"),
    // Add more articles as needed
  ];

  NewsList({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: newsList.length,
      itemBuilder: (BuildContext context, int index) {
        return NewsListItem(news: newsList[index]);
      },
    );
  }
}
