
import 'package:flutter/material.dart';
import 'package:myapp/core/services/movie_service.dart';
import 'package:myapp/features/home/domain/entities/movie.dart';
import 'package:myapp/features/home/presentation/widgets/movie_card.dart';


class HomeScreenScaffold extends StatefulWidget {
  const HomeScreenScaffold({super.key});

  @override
  State<HomeScreenScaffold> createState() => _HomeScreenScaffoldState();
}

class _HomeScreenScaffoldState extends State<HomeScreenScaffold> {
  late Future<List<Movie>> _popularMovies;
  late Future<List<Movie>> _topRatedMovies;
  late Future<List<Movie>> _nowPlayingMovies;
  late Future<List<Movie>> _upcomingMovies;

  final _movieService = MovieService();

  @override
  void initState() {
    super.initState();
    _popularMovies = _movieService.getPopularMovies();
    _topRatedMovies = _movieService.getTopRatedMovies();
    _nowPlayingMovies = _movieService.getNowPlayingMovies();
    _upcomingMovies = _movieService.getUpcomingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroBanner(context),
            _buildMovieList('Popular Movies', _popularMovies),
            _buildMovieList('Top Rated', _topRatedMovies),
            _buildMovieList('Now Playing', _nowPlayingMovies),
            _buildMovieList('Upcoming', _upcomingMovies),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroBanner(BuildContext context) {
    return Container(
      height: 400,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage('https://picsum.photos/800/600'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.transparent, Colors.black],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Featured Movie',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.yellow, size: 20),
                    const SizedBox(width: 5),
                    Text(
                      '8.7',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Watch Trailer'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMovieList(String title, Future<List<Movie>> movies) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 280,
          child: FutureBuilder<List<Movie>>(
            future: movies,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final movie = snapshot.data![index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MovieCard(movie: movie),
                    );
                  },
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
        ),
      ],
    );
  }
}
