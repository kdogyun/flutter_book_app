import 'package:flutter/material.dart';
import 'package:pos/src/ui/widgets/tabMain.dart';
// import 'widgets/sign_in_form.dart';

class DoMainScreen extends StatelessWidget {
  final String _phone, _name;
  DoMainScreen(this._phone, this._name);

  @override
  Widget build(BuildContext context) {
    print('두스크린');
    return TabMain(_phone, _name);
  }
}
