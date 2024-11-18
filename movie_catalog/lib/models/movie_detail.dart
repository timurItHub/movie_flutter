class MovieDetail {
  final String title;
  final String year;
  final String poster;
  final String plot;
  final String genres;
  final String releaseDate;
  final String rating;

  MovieDetail({
    required this.title,
    required this.year,
    required this.poster,
    required this.plot,
    required this.genres,
    required this.releaseDate,
    required this.rating,
  });

  factory MovieDetail.fromJson(Map<String, dynamic> json) {
    return MovieDetail(
      title: json['Title'] ?? 'Нет названия',
      year: json['Year'] ?? 'Неизвестно',
      poster: json['Poster'] ?? '',
      plot: json['Plot'] ?? 'Нет описания',
      genres: json['Genre'] ?? 'Неизвестно',
      releaseDate: json['Released'] ?? 'Неизвестно',
      rating: json['imdbRating'] ?? 'Не доступен',
    );
  }
}
