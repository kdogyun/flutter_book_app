import 'package:flutter/material.dart';
import 'package:pos/src/utils/strings.dart';
import 'blocs/login_bloc_provider.dart';
import 'ui/login.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('앱');
    return MaterialApp(
      theme: ThemeData(
        accentColor: Colors.red,
        primaryColor: Colors.white,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            StringConstant.domain,
            style: TextStyle(color: Color.fromRGBO(224, 15, 26, .99)),
          ),
          backgroundColor: Colors.red[50],
          elevation: 0.0,
        ),
        body: LoginBlocProvider(child: LoginScreen()),
      ),
    );
  }
}
