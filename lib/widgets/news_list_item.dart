import 'package:bullet_news/models/news.dart';
import 'package:bullet_news/views/article_detail_page.dart';
import 'package:flutter/material.dart';

class NewsListItem extends StatelessWidget {
  final News news;
  const NewsListItem({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleDetailPage(news: news),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: news.urlToImage.isNotEmpty
                    ? Image.network(
                        news.urlToImage,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        height: 200,
                        errorBuilder: (context, error, stackTrace) {
                          debugPrint(news.urlToImage);
                          return Container(
                            width: double.infinity,
                            height:
                                200, // Specify a fixed height for consistency
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(
                                  255, 57, 52, 58), // A light grey background
                              borderRadius: BorderRadius.circular(8),
                            ),
                          );
                        },
                      )
                    : Container(
                        width: double.infinity,
                        height: 200, // Specify a fixed height for consistency
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(
                              255, 57, 52, 58), // A light grey background
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
              ),
              const SizedBox(height: 8),
              Text(
                news.title,
                style: Theme.of(context).textTheme.titleLarge,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              const SizedBox(height: 8),
              Text(
                news.description,
                style: Theme.of(context).textTheme.bodyMedium,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
