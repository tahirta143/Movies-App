
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/features/home/domain/entities/movie.dart';
import 'package:myapp/features/movie_details/domain/entities/movie_detail.dart';

class MovieService {
  final String _apiKey = dotenv.env['TMDB_API_KEY']!;
  static const String _baseUrl = 'https://api.themoviedb.org/3';

  Future<List<Movie>> getPopularMovies() async {
    final response = await http.get(Uri.parse('$_baseUrl/movie/popular?api_key=$_apiKey'));
    return _parseMovies(response);
  }

  Future<List<Movie>> getTopRatedMovies() async {
    final response = await http.get(Uri.parse('$_baseUrl/movie/top_rated?api_key=$_apiKey'));
    return _parseMovies(response);
  }

  Future<List<Movie>> getNowPlayingMovies() async {
    final response = await http.get(Uri.parse('$_baseUrl/movie/now_playing?api_key=$_apiKey'));
    return _parseMovies(response);
  }

  Future<List<Movie>> getUpcomingMovies() async {
    final response = await http.get(Uri.parse('$_baseUrl/movie/upcoming?api_key=$_apiKey'));
    return _parseMovies(response);
  }

  Future<MovieDetail> getMovieDetail(int movieId) async {
    final response = await http.get(Uri.parse('$_baseUrl/movie/$movieId?api_key=$_apiKey'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return MovieDetail.fromJson(data);
    } else {
      throw Exception('Failed to load movie details');
    }
  }

  Future<List<Movie>> searchMovies(String query) async {
    final response = await http.get(Uri.parse('$_baseUrl/search/movie?api_key=$_apiKey&query=$query'));
    return _parseMovies(response);
  }

  Future<String?> getMovieTrailer(int movieId) async {
    final response = await http.get(Uri.parse('$_baseUrl/movie/$movieId/videos?api_key=$_apiKey'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'] as List;
      if (results.isNotEmpty) {
        final trailer = results.firstWhere((video) => video['type'] == 'Trailer', orElse: () => null);
        return trailer != null ? trailer['key'] : null;
      }
    } else {
      throw Exception('Failed to load movie trailer');
    }
    return null;
  }

  List<Movie> _parseMovies(http.Response response) {
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<Movie> movies = (data['results'] as List)
          .map((movieData) => Movie.fromJson(movieData))
          .toList();
      return movies;
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
