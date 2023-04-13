// import 'package:flutter/material.dart';
// import 'package:moovies/models.dart';

// class FutureBuilderPage extends StatefulWidget {
//   @override
//   _FutureBuilderPageState createState() => _FutureBuilderPageState();
// }

// class _FutureBuilderPageState extends State<FutureBuilderPage> {
//   late Future<List<Moovie>> future;

//   @override
//   void initState() {
//     super.initState();
//     future = Moovies.getPopularMovies();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Sistema de conocimiento"),
//         actions: const <Widget>[
//           IconButton(
//               icon: Icon(
//                 Icons.search,
//                 color: Colors.white,
//               ),
//               onPressed: null)
//         ],
//       ),
//       body: buildFutureBuilder(),
//       floatingActionButton: FloatingActionButton(onPressed: () {
//         setState(() {
//           // Prueba si futurebuilder realiza operaciones de redibujado innecesarias
//         });
//       }),
//     );
//   }

//   FutureBuilder<List<Moovie>> buildFutureBuilder() {
//     return FutureBuilder<List<Moovie>>( 
//       builder: (context, snapshot) {
//         // Devuelve el widget correspondiente aquí según el estado de la instantánea
//         if (snapshot.connectionState == ConnectionState.active ||
//             snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//         if (snapshot.connectionState == ConnectionState.done) {
//           debugPrint("done");
//           if (snapshot.hasError) {
//             return const Center(
//               child: Text("ERROR"),
//             );
//           } else if (snapshot.hasData) {
//             List<Moovie>? list = snapshot.data;
//             return RefreshIndicator(
//                 child: buildListView(context, list!), onRefresh: refresh);
//           }
//         }
//       },
//       future: future,
//     );
//   }

//   Future refresh() async {
//     setState(() {
//       future = Moovies.getPopularMovies();
//     });
//   }

//   buildListView(BuildContext context, List<Moovie> list) {
//     return ListView.builder(
//       itemBuilder: (context, index) {
//         List<Moovie> bean = list;
//         StringBuffer str = StringBuffer();
//         for (Moovie mooviw in bean) {
//           str.write(mooviw.year);
//         }
//         return ListTile(
//           title: Text(bean[index].title),
//           subtitle: Text(str.toString()),
//           trailing: IconButton(
//               icon: const Icon(
//                 Icons.navigate_next,
//                 color: Colors.grey,
//               ),
//               onPressed: () {}),
//         );
//       },
//       itemCount: list.length,
//     );
//   }
// }
