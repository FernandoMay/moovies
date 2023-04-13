import 'package:cloud_firestore/cloud_firestore.dart';
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

final favRef =
    FirebaseFirestore.instance.collection('favmoovies').withConverter<FMoovie>(
          fromFirestore: (snapshots, _) => FMoovie.fromJson(snapshots.data()!),
          toFirestore: (FMoovie, _) => FMoovie.toJson(),
        );
final userFavRef =
    FirebaseFirestore.instance.collection('favmoovies').doc('userFavs');

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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              if (index == _currentPageIndex.floor()) {
                return Transform(
                    transform: Matrix4.identity()
                      ..rotateX(_currentPageIndex.toDouble() - index),
                    child: MovieTile(movie: data.moovies[index]));
              } else if (index == _currentPageIndex.floor() + 1) {
                return Transform(
                    transform: Matrix4.identity()
                      ..rotateX(_currentPageIndex.toDouble() - index),
                    child: MovieTile(movie: data.moovies[index]));
              } else {
                return MovieTile(movie: data.moovies[index]);
              }
            },
            itemCount: data.moovies.length,
          ),
        )
        // Expanded(
        // child:
        // ListView.builder(
        //   shrinkWrap: true,
        //   scrollDirection: Axis.horizontal,
        //   itemCount: data.moovies.length,
        //   itemBuilder: (context, index) {
        // if (!data.isLoading) {
        // return
        //     PageView.builder(
        //   controller: _pageController,
        //   scrollDirection: Axis.horizontal,
        //   itemCount: data.moovies.length,
        //   onPageChanged: (index) {
        //     setState(() {
        //       _currentPageIndex = index;
        //     });
        //   },
        //   itemBuilder: (context, index) {
        //     return MovieTile(movie: data.moovies[index]);
        //   },
        // )
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: bgColor,
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Favs', style: tsH2White),
        backgroundColor: bgColor,
      ),
      child: StreamBuilder<QuerySnapshot<FMoovie>>(
        stream: favRef.where('favorite').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (!snapshot.hasData) {
            return const Center(child: CupertinoActivityIndicator());
          }
          final data = snapshot.requireData;
          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: data.size,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return FavsTile(
                data: data.docs[index].data(),
                reference: data.docs[index].reference,
              );
            },
          );
        },
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
      // height: MediaQuery.of(context).size.height * 0.7,
      // width: MediaQuery.of(context).size.width * 0.8,
      decoration: const BoxDecoration(
          backgroundBlendMode: BlendMode.darken, color: bgColor),
      child: Stack(
        children: [
          Expanded(
              child:
                  // PageView.builder(
                  //   controller: _pageController,
                  //   itemCount: 1,
                  //   itemBuilder: (context, index) {
                  //     return
                  Image.network(
            widget.movie.posterPath,
            fit: BoxFit.cover,
          )
              // },
              // ),
              ),
          Positioned(
            bottom: 10.0,
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      bgColor.withOpacity(0.0),
                      bgColor,
                    ]),
              ),
            ),
          ),
          Positioned(
            bottom: 10.0,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.movie.releaseDate.year.toString(),
                        style: tsH2Black,
                      ),
                      Text(
                        widget.movie.title,
                        style: tsH3Black,
                      ),
                    ],
                  ),
                  CupertinoButton(
                      child: Icon(_isActive
                          ? CupertinoIcons.heart_fill
                          : CupertinoIcons.heart),
                      onPressed: () {
                        setState(() {
                          !_isActive;
                        });
                        FMoovie fmoovie = FMoovie(
                            id: widget.movie.id,
                            title: widget.movie.originalTitle,
                            overview: widget.movie.overview,
                            posterPath: widget.movie.posterPath,
                            releaseYear: widget.movie.releaseDate.year,
                            favorite: _isActive);
                        favRef
                            .doc(DateTime.now().microsecond.toString())
                            .set(fmoovie)
                            .onError((e, _) =>
                                Exception("Error writing document: $e"));
                        final data = {
                          "favs": FieldValue.arrayUnion([widget.movie.id])
                        };
                        userFavRef.update(data).onError(
                            (e, _) => Exception("Error writing document: $e"));
                      })
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FavsTile extends StatefulWidget {
  const FavsTile({super.key, required this.data, required this.reference});

  final FMoovie data;
  final DocumentReference<FMoovie> reference;

  @override
  State<FavsTile> createState() => _FavsTileState();
}

class _FavsTileState extends State<FavsTile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: greyLightColor,
      width: size.width,
      padding: const EdgeInsets.symmetric(
        horizontal: 4.0,
        vertical: 8.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8.0),
              topRight: Radius.circular(8.0),
              bottomLeft: Radius.circular(8.0),
            ),
            child: SizedBox(
              width: size.width * 0.38,
              height: size.height * 0.24,
              child: Image.network(
                widget.data.posterPath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: size.width * 0.57,
            decoration: const BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
              ),
            ),
            padding: const EdgeInsets.only(
              bottom: 16.0,
              // top: 10.0,
              left: 14.0,
              right: 8.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 4.0),
                    CupertinoButton(
                      onPressed: () {
                        final data = {
                          "favs": FieldValue.arrayRemove([widget.data.id])
                        };
                        userFavRef.update(data).onError(
                            (e, _) => Exception("Error writing document: $e"));
                      },
                      child: const Icon(CupertinoIcons.heart_slash_fill,
                          size: 17.0, color: lightColor),
                    ),
                  ],
                ),
                Text(
                  widget.data.releaseYear.toString(),
                  style: tsH2Black,
                ),
                Text(
                  widget.data.title,
                  style: tsH3Black,
                ),
                Text(
                  widget.data.overview,
                  maxLines: 4,
                  softWrap: true,
                  style: tsH1Black,
                ),
                const SizedBox(
                  height: 4.0,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
