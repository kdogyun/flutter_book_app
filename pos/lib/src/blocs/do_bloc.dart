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
  final orders = <Content>[];
  final _order = BehaviorSubject<List<Content>>();

  // stream
  Stream<DocumentSnapshot> getUser(String phone) => _repository.getUser(phone);
  Stream<QuerySnapshot> getReceipt(String phone) =>
      _repository.getReceipt(phone);

  get order => _order.stream;
  get changeOrder => _order.sink.add(orders);

  @override
  void dispose() async {
    await _user.drain();
    _user.close();
    await _receipt.drain();
    _receipt.close();
  }
}
