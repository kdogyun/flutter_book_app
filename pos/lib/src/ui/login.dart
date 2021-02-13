import 'package:flutter/material.dart';
import 'package:pos/src/utils/strings.dart';
import 'widgets/sign_in_form.dart';
// import 'widgets/sign_in_form.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(color: Colors.white),
      alignment: Alignment(0.0, 0.0),
      child: SignInForm(),
    );
  }
}
