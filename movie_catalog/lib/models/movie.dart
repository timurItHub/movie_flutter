class Movie {
  final String title;
  final String year;
  final String poster;
  final String id;

  Movie({
    required this.title,
    required this.year,
    required this.poster,
    required this.id,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['Title'] ?? 'Нет названия',
      year: json['Year'] ?? 'Неизвестно',
      poster: json['Poster'] ?? '',
      id: json['imdbID'] ?? '',
    );
  }
}