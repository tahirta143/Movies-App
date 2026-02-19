
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/core/services/movie_service.dart';
import 'package:myapp/features/movie_details/domain/entities/movie_detail.dart';

class MovieDetailScreen extends StatefulWidget {
  final String movieId;

  const MovieDetailScreen({super.key, required this.movieId});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late Future<MovieDetail> _movieDetail;
  late Future<String?> _movieTrailer;

  @override
  void initState() {
    super.initState();
    _movieDetail = MovieService().getMovieDetail(int.parse(widget.movieId));
    _movieTrailer = MovieService().getMovieTrailer(int.parse(widget.movieId));
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
                  Image.network(
                    movie.posterUrl,
                    height: 500,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Padding(
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
