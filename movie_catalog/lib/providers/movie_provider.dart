import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../services/api_service.dart';

class MovieProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Movie> _movies = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Movie> get movies => _movies;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> searchMovies(String query) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _movies = await _apiService.searchMovies(query);
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}