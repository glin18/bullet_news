class News {
  final String title;
  final String description;
  // Add other fields

  News({required this.title, required this.description});

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['title'],
      description: json['description'],
      // Initialize other fields
    );
  }
}
