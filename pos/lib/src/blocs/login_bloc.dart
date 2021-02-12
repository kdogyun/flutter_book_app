import 'dart:async';
import 'package:pos/src/utils/funcs.dart';
import 'package:pos/src/utils/strings.dart';
import 'package:rxdart/rxdart.dart';

import '../resources/repository.dart';
import 'bloc_base.dart';

class LoginBloc extends BlocBase {
  final Repository _repository = Repository();
  final _phone = BehaviorSubject<String>();
  final _name = BehaviorSubject<String>();
  final _area = BehaviorSubject<String>();
  final _item = BehaviorSubject<String>();
  final _isSignedIn = BehaviorSubject<bool>();
  final _isChange = BehaviorSubject<bool>();

  // 네트워크 stream 용...
  Future<Map<String, dynamic>> checkVersion() {
    return _repository.checkVersion();
  }

  // 변수 stream 용...
  // stream.transform : 유효성 및 데이터 가공
  Stream<String> get phone => _phone.stream.transform(_validatePhone);
  Stream<String> get name => _name.stream.transform(_validateSpace);
  Stream<String> get area => _area.stream.transform(_validateSpace);
  Stream<String> get item => _item.stream.transform(_validateSpace);

  Stream<bool> get signInStatus => _isSignedIn.stream;
  Stream<bool> get changeStatus => _isChange.stream;
  // String get emailAddress => _email.value;

  // Change data
  Function(String) get changePhone => _phone.sink.add;
  Function(String) get changeName => _name.sink.add;
  Function(String) get changeArea => _area.sink.add;
  Function(String) get changeItem => _item.sink.add;
  Function(bool) get showProgressBar => _isSignedIn.sink.add;
  Function(bool) get chageButton => _isChange.sink.add;

  final _validatePhone =
      StreamTransformer<String, String>.fromHandlers(handleData: (phone, sink) {
    if (Funcs().isNumeric(phone)) {
      sink.add(phone);
    } else {
      sink.addError(StringConstant.phoneValidateMessage);
    }
  });

  final _validateSpace = StreamTransformer<String, String>.fromHandlers(
      handleData: (element, sink) {
    if (!Funcs().onlySpace(element)) {
      sink.add(element);
    } else {
      sink.addError(StringConstant.spaceValidateMessage);
    }
  });

  Future<int> login() {
    return _repository.authenticateUser(_phone.value, _name.value);
  }

  Future<int> registerUser() {
    return _repository.registerUser(
        _phone.value, _name.value, _area.value, _item.value);
  }

  void dispose() async {
    print('login bloc dispose');
    await _phone.drain();
    _phone.close();
    await _name.drain();
    _name.close();
    await _item.drain();
    _item.close();
    await _area.drain();
    _area.close();
    await _isSignedIn.drain();
    _isSignedIn.close();
    await _isChange.drain();
    _isChange.close();
  }
}
