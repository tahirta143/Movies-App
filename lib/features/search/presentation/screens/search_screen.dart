
import 'package:flutter/material.dart';
import 'package:myapp/core/services/movie_service.dart';
import 'package:myapp/features/home/domain/entities/movie.dart';
import 'package:myapp/features/home/presentation/widgets/movie_card.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  Future<List<Movie>>? _searchResults;

  void _searchMovies() {
    if (_searchController.text.isNotEmpty) {
      final movieService = Provider.of<MovieService>(context, listen: false);
      setState(() {
        _searchResults = movieService.searchMovies(_searchController.text);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Movies'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for a movie...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _searchMovies,
                ),
              ),
              onSubmitted: (_) => _searchMovies(),
            ),
          ),
          Expanded(
            child: _searchResults == null
                ? const Center(child: Text('Enter a search term to begin.'))
                : FutureBuilder<List<Movie>>(
                    future: _searchResults,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No movies found.'));
                      }
                      final movies = snapshot.data!;
                      return GridView.builder(
                        padding: const EdgeInsets.all(16.0),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.6,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                        ),
                        itemCount: movies.length,
                        itemBuilder: (context, index) {
                          final movie = movies[index];
                          return MovieCard(movie: movie);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
