import 'package:flutter/cupertino.dart';
import 'package:moovies/models.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  late Future<List<Moovie>> _movies;
  int _currentPageIndex = 0;

  @override
  void initState() {
    _movies = Moovies.getPopularMovies();
    super.initState(); // Obtener las películas desde la API
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        // leading: Center(
        //   child: CupertinoButton(
        //     child: const Icon(CupertinoIcons.refresh_circled_solid),
        //     onPressed: () {
        //       Navigator.of(context).push(
        //         CupertinoPageRoute(
        //           builder: (_) => const Home(),
        //         ),
        //       );
        //     },
        //   ),
        // ),
        middle: Text('Recommended Moovies'),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: FutureBuilder<List<Moovie>>(
              future: _movies,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return PageView.builder(
                    controller: _pageController,
                    itemCount: snapshot.data!.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPageIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return MovieTile(movie: snapshot.data![index]);
                    },
                  );
                } else {
                  return const CupertinoActivityIndicator();
                }
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              _movies.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MovieTile extends StatefulWidget {
  final Moovie movie;

  const MovieTile({Key? key, required this.movie}) : super(key: key);

  @override
  _MovieTileState createState() => _MovieTileState();
}

class _MovieTileState extends State<MovieTile> {
  late final PageController _pageController;
  bool _isActive = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.9);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _isActive ? 700 : 600,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: 1,
              itemBuilder: (context, index) {
                return Image.network(
                  widget.movie.poster,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.movie.title,
                  style: const TextStyle(
                    color: CupertinoColors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: CupertinoColors.black,
                        blurRadius: 2.0,
                        offset: Offset(1.0, 1.0),
                      ),
                    ],
                  ),
                ),
                Text(
                  widget.movie.year.toString(),
                  style: const TextStyle(
                    color: CupertinoColors.white,
                    fontSize: 16.0,
                    shadows: [
                      Shadow(
                        color: CupertinoColors.black,
                        blurRadius: 2.0,
                        offset: Offset(1.0, 1.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
