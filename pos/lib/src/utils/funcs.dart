import 'package:shared_preferences/shared_preferences.dart';

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
