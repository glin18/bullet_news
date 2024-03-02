import 'package:bullet_news/models/news.dart';
import 'package:bullet_news/widgets/news_list_item.dart';
import 'package:flutter/material.dart';
import 'package:bullet_news/services/news_service.dart';

class NewsList extends StatefulWidget {
  final String category;
  final String id;

  const NewsList({super.key, required this.category, required this.id});

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  final List<News> _newsList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  Future<void> _fetchNews() async {
    try {
      List<News> fetchedNews = await NewsService().fetchNews(widget.id);
      setState(() {
        _newsList.addAll(fetchedNews);
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Failed to fetch news: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            itemCount: _newsList.length,
            itemBuilder: (BuildContext context, int index) {
              return NewsListItem(news: _newsList[index]);
            },
          );
  }
}
