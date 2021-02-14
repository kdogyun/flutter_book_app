import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Funcs {
  bool isNumeric(String str) {
    if (str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }

  bool onlySpace(String str) {
    if (str.replaceAll(" ", '').length > 0)
      return false;
    else
      return true;
  }

  String numComma(int price) {
    return NumberFormat('###,###,###,###').format(price).replaceAll(' ', '');
  }

  void showErrorMessage(BuildContext context, String str) {
    final snackbar =
        SnackBar(content: Text(str), duration: new Duration(seconds: 2));
    Scaffold.of(context).showSnackBar(snackbar);
  }

  // Timestamp datetimeToTimestamp(DateTime dt) {
  //   return Timestamp.fromDate(dt);
  //   // return Timestamp.fromMillisecondsSinceEpoch(
  //   //     DateTime.parse(new DateFormat('yyyy-MM-dd 00:00:00.000').format(dt))
  //   //         .millisecondsSinceEpoch);
  // }

  // DateTime timestampToDateTime(Timestamp ts) {
  //   print(ts.toDate());
  //   return ts.toDate();
  //   // return DateTime.parse(ts.toDate().toString());
  //   // return Timestamp.fromMillisecondsSinceEpoch(
  //   //     DateTime.parse(new DateFormat('yyyy-MM-dd 00:00:00.000')
  //   //             .format(new DateTime.now()))
  //   //         .millisecondsSinceEpoch);
  // }

  // // sharedpreference
  // //시작할 때 counter 값을 불러옵니다.
  // _loadCounter() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     _counter = (prefs.getInt('counter') ?? 0);
  //   });
  // }

  // //클릭하면 counter를 증가시킵니다.
  // _incrementCounter() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     _counter = (prefs.getInt('counter') ?? 0) + 1;
  //     prefs.setInt('counter', _counter);
  //   });
  // }
}
