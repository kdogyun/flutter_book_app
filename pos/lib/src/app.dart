import 'package:flutter/material.dart';
import 'package:inject/inject.dart';
import 'blocs/version_bloc.dart';

class App extends StatelessWidget {
  final LoginBloc bloc;

  @provide
  App(this.bloc);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text("Welcome to Flutter"),
        ),
        body: ListView(
          children: [
            Text('Hello World'),
            Text('ㄴ이ㅏㅓㅗ리ㅓㅏㄴ욀'),
            FutureBuilder<Map<String, dynamic>>(
              future: bloc.checkVersion(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text("${snapshot.data['version']}");
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   // TODO: implement build
  //   return MaterialApp(
  //     theme: ThemeData.dark(),
  //     initialRoute: '/',
  //     home: Scaffold(),
  //     // routes: {
  //     //   '/': (context) => MovieList(moviesBloc),
  //     // },
  //   );
  // }
}
