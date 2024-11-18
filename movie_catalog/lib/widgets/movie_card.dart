import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MovieCard extends StatelessWidget {
  final String title;
  final String year;
  final String poster;

  MovieCard({
    required this.title,
    required this.year,
    required this.poster,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CachedNetworkImage(
          imageUrl: poster,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        title: Text(title),
        subtitle: Text(year),
      ),
    );
  }
}