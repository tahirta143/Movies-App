
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/core/services/movie_service.dart';
import 'package:myapp/features/movie_details/domain/entities/movie_detail.dart';
import 'package:provider/provider.dart';

class MovieDetailScreen extends StatefulWidget {
  final String movieId;

  const MovieDetailScreen({super.key, required this.movieId});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> with SingleTickerProviderStateMixin {
  late Future<MovieDetail> _movieDetail;
  late Future<String?> _movieTrailer;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final movieService = Provider.of<MovieService>(context, listen: false);
    _movieDetail = movieService.getMovieDetail(int.parse(widget.movieId));
    _movieTrailer = movieService.getMovieTrailer(int.parse(widget.movieId));
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(_animationController);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Details'),
      ),
      body: FutureBuilder<MovieDetail>(
        future: _movieDetail,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final movie = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: 'movie-poster-${movie.id}',
                    child: Image.network(
                      movie.posterUrl,
                      height: 500,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.title,
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Icon(Icons.star, color: Colors.yellow, size: 20),
                                const SizedBox(width: 5),
                                Text(
                                  movie.rating.toString(),
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(width: 20),
                                Text(
                                  '${movie.runtime} min',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(width: 20),
                                Text(
                                  movie.releaseDate,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            FutureBuilder<String?>(
                              future: _movieTrailer,
                              builder: (context, snapshot) {
                                if (snapshot.hasData && snapshot.data != null) {
                                  return ElevatedButton(
                                    onPressed: () {
                                      context.go('/trailer/${snapshot.data}');
                                    },
                                    child: const Text('Watch Trailer'),
                                  );
                                }
                                return const SizedBox.shrink();
                              },
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Overview',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              movie.overview,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
