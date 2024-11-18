import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import '../widgets/movie_card.dart';
import '../screens/movie_detail_screen.dart'; // Импортируем экран детализации

class HomeScreen extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Каталог фильмов'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Введите название фильма...',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    if (_searchController.text.isNotEmpty) {
                      movieProvider.searchMovies(_searchController.text);
                    }
                  },
                ),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            if (movieProvider.isLoading)
              Center(child: CircularProgressIndicator())
            else if (movieProvider.errorMessage != null)
              Center(child: Text(movieProvider.errorMessage!))
            else if (movieProvider.movies.isEmpty)
              Center(child: Text('Фильмы не найдены'))
            else
              Expanded(
                child: ListView.builder(
                  itemCount: movieProvider.movies.length,
                  itemBuilder: (context, index) {
                    final movie = movieProvider.movies[index];
                    return GestureDetector(
                      onTap: () {
                        // Переход на экран детализации фильма
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MovieDetailScreen(
                              movieId: movie.id,  // Передаем только movieId
                            ),
                          ),
                        );
                      },
                      child: MovieCard(
                        title: movie.title,
                        year: movie.year,
                        poster: movie.poster,
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
