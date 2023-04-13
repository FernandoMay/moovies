import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:moovies/constants.dart';
import 'package:moovies/firebase_options.dart';
import 'package:moovies/providers.dart';
import 'package:moovies/splash.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<MoovieProvider>(
      create: (_) => MoovieProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'Moovies',
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(
        primaryColor: lightColor,
      ),
      home: Splash(),
    );
  }
}
