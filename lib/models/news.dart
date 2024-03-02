class News {
  final int id;
  final String title;
  final String description;
  final String summary;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;
  final String sourceName;
  final String categoryName;

  News({
    required this.id,
    required this.title,
    required this.description,
    required this.summary,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
    required this.sourceName,
    required this.categoryName,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id'],
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? 'No Description',
      summary: json['summary'] ?? 'No Summary',
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'] ?? '',
      publishedAt: json['publishedAt'] ?? '',
      content: json['content'] ?? 'No Content',
      sourceName: json['sourceName'] ?? 'No Source Name',
      categoryName: json['categoryName'] ?? 'No Category',
    );
  }
}
