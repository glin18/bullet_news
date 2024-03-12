class Comment {
  final int id;
  final String content;
  final DateTime createdTime;
  final int newsId;
  final int userId;

  Comment({
    required this.id,
    required this.content,
    required this.createdTime,
    required this.newsId,
    required this.userId,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      content: json['content'],
      createdTime: DateTime.parse(json['createdTime']),
      newsId: json['newsId'],
      userId: json['userId'],
    );
  }
}
