import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';
import '../models/movie_detail.dart';  // Модель для деталей фильма

class ApiService {
  static const String baseUrl = 'https://www.omdbapi.com/';
  static const String apiKey = '5d52f97f'; 

  // Метод для поиска фильмов по запросу
  Future<List<Movie>> searchMovies(String query) async {
    final response = await http.get(Uri.parse('$baseUrl/?s=$query&apikey=$apiKey'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['Response'] == 'True') {
        return (data['Search'] as List).map((movie) => Movie.fromJson(movie)).toList();
      } else {
        throw Exception('Фильмы не найдены: ${data['Error']}');
      }
    } else {
      throw Exception('Ошибка подключения к API: ${response.statusCode}');
    }
  }

  // Новый метод для получения деталей фильма по imdbID
  Future<MovieDetail> getMovieDetails(String movieId) async {
    final response = await http.get(Uri.parse('$baseUrl/?i=$movieId&apikey=$apiKey'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['Response'] == 'True') {
        return MovieDetail.fromJson(data); // Преобразуем в MovieDetail
      } else {
        throw Exception('Детали фильма не найдены: ${data['Error']}');
      }
    } else {
      throw Exception('Ошибка подключения к API: ${response.statusCode}');
    }
  }
}
