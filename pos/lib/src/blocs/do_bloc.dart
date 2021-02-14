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
  final _total = BehaviorSubject<int>();

  // stream
  Stream<DocumentSnapshot> getUser(String phone) => _repository.getUser(phone);
  Stream<QuerySnapshot> getReceipt(String phone) =>
      _repository.getReceipt(phone);

  get order => _order.stream;
  get changeOrder => _changeOrder();
  get total => _total.stream;

  get getTotal => _total.stream.value;

  void _changeOrder() {
    _order.sink.add(orders);
    var a = 0;
    orders.forEach((element) {
      a += element.sum;
    });
    _total.sink.add(a);
  }

  void setUser(User _user) {
    return _repository.setUser(_user);
  }

  void setReceipt(Receipt _receipt) {
    return _repository.setReceipt(_receipt);
  }

  void updateReceipt(Receipt _receipt) {
    return _repository.updateReceipt(_receipt);
  }

  @override
  void dispose() async {
    print('do bloc 디스포즈');
    await _order.drain();
    _order.close();
    await _total.drain();
    _total.close();
    await _user.drain();
    _user.close();
    await _receipt.drain();
    _receipt.close();
  }
}
