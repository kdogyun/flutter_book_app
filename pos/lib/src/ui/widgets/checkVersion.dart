import 'package:flutter/material.dart';
import 'package:pos/src/blocs/login_bloc.dart';
import 'package:pos/src/blocs/login_bloc_provider.dart';

// ignore: camel_case_types
class checkVersion extends StatefulWidget {
  @override
  checkVersionState createState() => checkVersionState();
}

// ignore: camel_case_types
class checkVersionState extends State<checkVersion> {
  LoginBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = LoginBlocProvider.of(context);
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

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
              future: _bloc.checkVersion(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print(snapshot);
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
}
