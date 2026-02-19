
import 'package:flutter/material.dart';
import 'package:myapp/features/home/presentation/screens/home_screen.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  final List<Movie> _watchlist = [
    Movie(title: 'Movie 4', posterUrl: 'https://picsum.photos/200/300', rating: 8.2),
    Movie(title: 'Movie 5', posterUrl: 'https://picsum.photos/200/300', rating: 7.5),
    Movie(title: 'Movie 6', posterUrl: 'https://picsum.photos/200/300', rating: 8.8),
  ];

  void _removeMovie(Movie movie) {
    setState(() {
      _watchlist.remove(movie);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Watchlist'),
      ),
      body: ListView.builder(
        itemCount: _watchlist.length,
        itemBuilder: (context, index) {
          final movie = _watchlist[index];
          return ListTile(
            leading: Image.network(movie.posterUrl, width: 50, fit: BoxFit.cover),
            title: Text(movie.title),
            subtitle: Row(
              children: [
                const Icon(Icons.star, color: Colors.yellow, size: 16),
                const SizedBox(width: 4),
                Text(movie.rating.toString()),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
              onPressed: () => _removeMovie(movie),
            ),
          );
        },
      ),
    );
  }
}
