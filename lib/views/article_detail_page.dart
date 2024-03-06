import 'package:flutter/material.dart';
import 'package:bullet_news/models/news.dart';

class ArticleDetailPage extends StatefulWidget {
  final News news;

  const ArticleDetailPage({super.key, required this.news});

  @override
  State<ArticleDetailPage> createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  bool isLiked = false;
  int likesCount = 0;
  bool isSaved = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.news.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.news.urlToImage.isNotEmpty)
              Image.network(
                widget.news.urlToImage,
                errorBuilder: (context, error, stackTrace) {
                  debugPrint(widget.news.urlToImage);
                  return const SizedBox.shrink();
                },
              ),
            const SizedBox(height: 8),
            Text(
              widget.news.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              widget.news.publishedAt,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              widget.news.summary,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20), // Add some space before the like button
            Row(
              children: [
                IconButton(
                  icon: Icon(isLiked ? Icons.favorite : Icons.favorite_border),
                  color: Colors.red,
                  onPressed: () {
                    setState(() {
                      isLiked = !isLiked;
                      isLiked ? likesCount++ : likesCount--;
                    });
                  },
                ),
                const SizedBox(width: 8),
                Text("$likesCount likes",
                    style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(width: 16), // Space between like and save buttons
                IconButton(
                  icon: Icon(isSaved ? Icons.bookmark : Icons.bookmark_border),
                  color: Colors.blue,
                  onPressed: () {
                    setState(() {
                      isSaved = !isSaved;
                      // Here you can also handle the save action with your backend.
                    });
                  },
                ),
                const SizedBox(width: 8),
                if (isSaved) Text("Saved", style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
