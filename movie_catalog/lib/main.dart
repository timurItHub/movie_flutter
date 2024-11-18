import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/movie_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MovieCatalogApp());
}

class MovieCatalogApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MovieProvider(),
      child: MaterialApp(
        title: 'Каталог фильмов',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        home: HomeScreen(),
      ),
    );
  }
}