import 'package:bullet_news/widgets/saved_news_list.dart';
import 'package:flutter/material.dart';

class SavedNewsPage extends StatelessWidget {
  const SavedNewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved News'),
      ),
      body: const SavedNewsList(),
    );
  }
}
