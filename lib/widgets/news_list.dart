import 'package:bullet_news/widgets/news_list_item.dart';
import 'package:flutter/material.dart';

class NewsList extends StatelessWidget {
  final String category;

  const NewsList({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return const NewsListItem();
      },
    );
  }
}
