import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:moovies/constants.dart';
import 'package:moovies/home.dart';
import 'package:moovies/providers.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  // late Moovie moovie;
  Future<Timer> loadData() async {
    final moovies = Provider.of<MoovieProvider>(context, listen: false);
    await moovies.fetchData();
    return Timer(const Duration(seconds: 1, milliseconds: 618), onDoneLoading);
  }

  onDoneLoading() async {
    Navigator.pushAndRemoveUntil(context,
        CupertinoPageRoute<Widget>(builder: (BuildContext context) {
      return const Home();
    }), (route) => false);
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: bgColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Icon(
              CupertinoIcons.video_camera_solid,
              size: 111,
              color: lightColor,
            ),
            SizedBox(
              height: 18.0,
            ),
            Text(
              "Moovies",
              style: tsH4White,
            ),
          ],
        ),
      ),
    );
  }
}
