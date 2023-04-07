import 'package:http/http.dart' as http;
import 'dart:convert';

class Moovie {
  int id;
  String title;
  String poster;
  String overview;
  int year;

  Moovie(
      {required this.id,
      required this.overview,
      required this.poster,
      required this.title,
      required this.year});

  factory Moovie.fromJson(Map<String, dynamic> json) {
    return Moovie(
      id: json['id'],
      title: json['title'],
      poster: 'https://image.tmdb.org/t/p/w500${json['poster_path']}',
      overview: json['overview'],
      year: json['year'],
    );
  }
}

class Moovies {
  static const String apiKey = 'eb818004d67dcb370cbea5e017c7a6e5';
  static const String baseUrl = 'https://api.themoviedb.org/3';

  static Future<List<Moovie>> getPopularMovies() async {
    const String uri = '$baseUrl/movie/popular?api_key=$apiKey';
    final response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      List<Moovie> movies = [];
      var data = jsonDecode(response.body)['results'];
      print(data);
      for (var item in data) {
        movies.add(Moovie.fromJson(item));
      }
      return movies;
    } else {
      throw Exception('Failed to load popular movies');
    }
  }
}

// add a pageviewcontroller with viewport index of 0.8 and also in movie tile make the height of the image around 400
// give a pageview a fixed height of 700 and then for inactive page reduce their height to 600