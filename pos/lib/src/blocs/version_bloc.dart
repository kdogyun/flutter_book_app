import 'dart:async';
import 'package:inject/inject.dart';
import '../resources/repository.dart';
import 'bloc_base.dart';

class LoginBloc extends BlocBase {
  final Repository _repository;

  @provide
  LoginBloc(this._repository);

  Future<Map<String, dynamic>> checkVersion() {
    return _repository.checkVersion();
  }

  @override
  dispose() {}
}
