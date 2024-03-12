import 'package:bullet_news/widgets/comments_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bullet_news/models/news.dart';

import '../models/comment.dart';
import '../services/news_service.dart';

class ArticleDetailPage extends StatefulWidget {
  final int newsId;

  const ArticleDetailPage({super.key, required this.newsId});

  @override
  State<ArticleDetailPage> createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  late News news;
  late List<Comment> comments;
  bool isLoading = true;
  bool isLiked = false;
  int likesCount = 0;
  bool isSaved = false;
  final NewsService newsService = NewsService();

  @override
  void initState() {
    super.initState();
    _fetchNewsDetails();
  }

  Future<void> _fetchNewsDetails() async {
    try {
      News fetchedNews = await NewsService().fetchNewsById(widget.newsId);
      final String userId = FirebaseAuth.instance.currentUser?.uid ?? "";
      setState(() {
        news = fetchedNews;
        isLoading = false;
        isLiked = news.usersWhoLiked.contains(userId);
        isSaved = news.isSaved;
        likesCount = news.usersWhoLiked.length;
      });
    } catch (e) {
      debugPrint("Failed to fetch news details: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _likeNews() async {
    setState(() {
      isLiked = !isLiked;
      isLiked ? likesCount++ : likesCount--;
    });
    try {
      await newsService.likeNews(news.id.toString());
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to like the news'),
          ),
        );
      }
    }
  }

  Future<void> _saveNews() async {
    setState(() {
      isSaved = !isSaved;
    });
    try {
      await newsService.saveNews(news.id.toString());
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to like the news'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            appBar: AppBar(title: const Text('Loading...')),
            body: const Center(child: CircularProgressIndicator()),
          )
        : Scaffold(
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
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      IconButton(
                          icon: Icon(
                              isLiked ? Icons.favorite : Icons.favorite_border),
                          color: Colors.red,
                          onPressed: _likeNews),
                      const SizedBox(width: 8),
                      Text("$likesCount likes",
                          style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(width: 16),
                      IconButton(
                          icon: Icon(
                              isSaved ? Icons.bookmark : Icons.bookmark_border),
                          color: Colors.blue,
                          onPressed: _saveNews),
                      const SizedBox(width: 8),
                      if (isSaved)
                        Text("Saved",
                            style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                  const SizedBox(height: 20),
                  CommentsList(newsId: widget.newsId),
                ],
              ),
            ),
          );
  }
}
