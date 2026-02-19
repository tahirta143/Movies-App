
class Movie {
  final int id;
  final String title;
  final String posterUrl;
  final double rating;

  Movie({required this.id, required this.title, required this.posterUrl, required this.rating});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      posterUrl: 'https://image.tmdb.org/t/p/w500/${json['poster_path']}',
      rating: json['vote_average'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'poster_path': posterUrl,
      'vote_average': rating,
    };
  }
}
