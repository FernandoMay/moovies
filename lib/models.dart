import 'package:http/http.dart' as http;
import 'dart:convert';

// To parse this JSON data, do
//
//     final tmdb = tmdbFromJson(jsonString);

import 'dart:convert';

Tmdb tmdbFromJson(String str) => Tmdb.fromJson(json.decode(str));

String tmdbToJson(Tmdb data) => json.encode(data.toJson());

class Tmdb {
  Tmdb({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Moovie> results;
  int totalPages;
  int totalResults;

  factory Tmdb.fromJson(Map<String, dynamic> json) => Tmdb(
        page: json["page"],
        results:
            List<Moovie>.from(json["results"].map((x) => Moovie.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

class Moovie {
  Moovie({
    required this.adult,
    this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  bool adult;
  String? backdropPath;
  List<int> genreIds;
  int id;
  OriginalLanguage originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  DateTime releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  factory Moovie.fromJson(Map<String, dynamic> json) => Moovie(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalLanguage:
            originalLanguageValues.map[json["original_language"]]!,
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: 'https://image.tmdb.org/t/p/w500${json['poster_path']}',
        releaseDate: DateTime.parse(json["release_date"]),
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "original_language": originalLanguageValues.reverse[originalLanguage],
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "release_date":
            "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}

enum OriginalLanguage { EN, ES }

final originalLanguageValues =
    EnumValues({"en": OriginalLanguage.EN, "es": OriginalLanguage.ES});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
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