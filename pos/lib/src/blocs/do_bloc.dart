import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pos/src/models/receipt.dart';
import 'package:pos/src/models/user.dart';
import 'package:pos/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc_base.dart';

class DoBloc extends BlocBase {
  final Repository _repository = Repository();
  final _user = BehaviorSubject<User>();
  final _receipt = BehaviorSubject<Receipt>();

  Stream<DocumentSnapshot> getUser(String phone) {
    return _repository.getUser(phone);
  }

  @override
  void dispose() async {
    await _user.drain();
    _user.close();
    await _receipt.drain();
    _receipt.close();
  }
}
