import 'package:flutter/cupertino.dart';
import 'package:moovies/constants.dart';
import 'package:moovies/models.dart';
import 'package:moovies/providers.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Widget> _tabs = [
    const Homie(),
    const Watchlist(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: bgColor,
        activeColor: lightColor,
        inactiveColor: CupertinoColors.inactiveGray,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.bookmark_solid), label: 'Watchlist'),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (BuildContext context) {
            return _tabs[index];
          },
        );
      },
    );
  }
}

class Homie extends StatefulWidget {
  const Homie({super.key});

  @override
  State<Homie> createState() => _HomieState();
}

class _HomieState extends State<Homie> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  late Future<List<Moovie>> _moovies;
  int _currentPageIndex = 0;

  @override
  void initState() {
    final moovies = Provider.of<MoovieProvider>(context, listen: false);
    moovies.fetchData();
    _moovies = Moovies.getPopularMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<MoovieProvider>(context);
    return CupertinoPageScaffold(
        backgroundColor: bgColor,
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Moovies', style: tsH2White),
          backgroundColor: bgColor,
        ),
        child:
            // Expanded(
            // child:
            // ListView.builder(
            //   shrinkWrap: true,
            //   scrollDirection: Axis.horizontal,
            //   itemCount: data.moovies.length,
            //   itemBuilder: (context, index) {
            // if (!data.isLoading) {
            // return
            PageView.builder(
          controller: _pageController,
          scrollDirection: Axis.horizontal,
          itemCount: data.moovies.length,
          onPageChanged: (index) {
            setState(() {
              _currentPageIndex = index;
            });
          },
          itemBuilder: (context, index) {
            return MovieTile(movie: data.moovies[index]);
          },
        )
        // } else {
        //   return const CupertinoActivityIndicator();
        // }
        // },
        // ),
        // ),
        );
  }
}

class Watchlist extends StatefulWidget {
  const Watchlist({super.key});

  @override
  State<Watchlist> createState() => _WatchlistState();
}

class _WatchlistState extends State<Watchlist> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
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
      // height: MediaQuery.of(context).size.height * 0.7,
      // width: MediaQuery.of(context).size.width * 0.8,
      decoration:
          BoxDecoration(backgroundBlendMode: BlendMode.darken, color: bgColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: 1,
              itemBuilder: (context, index) {
                return Image.network(
                  widget.movie.posterPath,
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
                  widget.movie.releaseDate.year.toString(),
                  style: tsH1Black,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
