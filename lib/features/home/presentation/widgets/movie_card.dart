
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/features/home/domain/entities/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go('/movie/${movie.id}'),
      child: Hero(
        tag: 'movie-poster-${movie.id}',
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Image.network(
            movie.posterUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
