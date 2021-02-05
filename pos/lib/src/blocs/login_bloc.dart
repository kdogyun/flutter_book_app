import 'dart:async';
import '../resources/repository.dart';
import 'bloc_base.dart';

class LoginBloc extends BlocBase {
  final Repository _repository = Repository();

  Future<Map<String, dynamic>> checkVersion() {
    return _repository.checkVersion();
  }

  @override
  dispose() {}
}
