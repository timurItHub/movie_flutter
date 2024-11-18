import 'package:flutter/material.dart';
import '../models/movie_detail.dart'; // Импортируем модель MovieDetail
import '../services/api_service.dart'; // Импортируем ApiService

class MovieDetailScreen extends StatefulWidget {
  final String movieId; // Передаем id фильма

  MovieDetailScreen({required this.movieId});

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late Future<MovieDetail> _movieDetail;

  @override
  void initState() {
    super.initState();
    // Загружаем подробную информацию о фильме при инициализации
    _movieDetail = ApiService().getMovieDetails(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Детали фильма'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context), // Возврат на главный экран
        ),
      ),
      body: FutureBuilder<MovieDetail>(
        future: _movieDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('Данные не найдены'));
          } else {
            final movie = snapshot.data!; // Получаем данные о фильме
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: <Widget>[
                  movie.poster.isNotEmpty
                      ? Image.network(movie.poster)
                      : Placeholder(fallbackHeight: 200), // Показываем постер фильма
                  SizedBox(height: 16),
                  Text(
                    movie.title,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('Дата выпуска: ${movie.releaseDate}'),
                  SizedBox(height: 8),
                  Text('Жанры: ${movie.genres}'),
                  SizedBox(height: 8),
                  Text('Описание: ${movie.plot}'),
                  SizedBox(height: 8),
                  Text('Рейтинг: ${movie.rating}/10'),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
