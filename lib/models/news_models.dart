class NewsModels {
  final String? author;
  final String title;
  final String? description;
  final String url;

  final String? urlToImage;
  final String? category;
  final String? language;
  final String? country;
  final String publishedAt;

  NewsModels(
      {required this.author,
      required this.title,
      required this.description,
      required this.url,
      required this.urlToImage,
      required this.category,
      required this.language,
      required this.country,
      required this.publishedAt});

  factory NewsModels.fromJson(Map<String, dynamic> json) {
    return NewsModels(
      author: json['author'] ?? '',
      title: json['title'],
      description: json['description'] ?? '',
      url: json['url'],
      urlToImage: json['urlToImage'] ?? '',
      category: json['category'] ?? '',
      language: json['language'] ?? '',
      country: json['country'] ?? '',
      publishedAt: json['publishedAt'] ?? '',
    );
  }
}
