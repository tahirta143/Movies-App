
class MovieDetail {
  final int id;
  final String title;
  final String overview;
  final String posterUrl;
  final double rating;
  final String releaseDate;
  final int runtime;

  MovieDetail({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterUrl,
    required this.rating,
    required this.releaseDate,
    required this.runtime,
  });

  factory MovieDetail.fromJson(Map<String, dynamic> json) {
    return MovieDetail(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      posterUrl: 'https://image.tmdb.org/t/p/w500/${json['poster_path']}',
      rating: json['vote_average'].toDouble(),
      releaseDate: json['release_date'],
      runtime: json['runtime'],
    );
  }
}
