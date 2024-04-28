// article_model.dart

class Article {
  final String source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String imageUrl;
  final DateTime publishedAt;
  final String content;
  bool isFavorite;

  Article(
      {required this.source,
      required this.author,
      required this.title,
      required this.description,
      required this.url,
      required this.imageUrl,
      required this.publishedAt,
      required this.content,
      this.isFavorite = false});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      source: json['source']['name'] ?? "",
      author: json['author'] ?? '',
      title: json['title'] ?? "",
      description: json['description'] ?? '',
      url: json['url'] ?? "",
      imageUrl: json['urlToImage'] ?? '',
      publishedAt: DateTime.parse(json['publishedAt'] ?? ''),
      content: json['content'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'source': {'name': source},
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': imageUrl,
      'publishedAt': publishedAt.toIso8601String(),
      'content': content,
    };
  }
}
