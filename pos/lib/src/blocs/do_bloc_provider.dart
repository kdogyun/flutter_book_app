import 'package:flutter/material.dart';
import 'do_bloc.dart';
export 'do_bloc.dart';

class DoBlocProvider extends InheritedWidget {
  final bloc = DoBloc();

  DoBlocProvider({Key key, Widget child}) : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static DoBloc of(BuildContext context) {
    print('두블록');
    return context.dependOnInheritedWidgetOfExactType<DoBlocProvider>().bloc;
  }
}
