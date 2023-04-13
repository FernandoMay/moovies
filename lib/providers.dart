import 'package:flutter/cupertino.dart';
import 'package:moovies/models.dart';

class MoovieProvider extends ChangeNotifier {
  late List<Moovie> moovies;
  bool isLoading = false;
  String query = "happiness";
  int page = 1;

  fetchData() async {
    isLoading = true;
    moovies = await Moovies.getPopularMovies();
    isLoading = false;
    notifyListeners();
    return moovies;
  }
}
