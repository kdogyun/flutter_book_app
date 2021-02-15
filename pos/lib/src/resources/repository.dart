import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pos/src/models/receipt.dart';
import 'package:pos/src/models/user.dart';

import 'firestore_provider.dart';

class Repository {
  final _firestoreProvider = FirestoreProvider();

  // 버전 체크
  Future<Map<String, dynamic>> checkVersion() =>
      _firestoreProvider.checkVersion();

  // 로그인
  Future<int> authenticateUser(String _phone, String _bName) =>
      _firestoreProvider.authenticateUser(_phone, _bName);

  // 회원가입
  Future<int> registerUser(
          String _phone, String _bName, String _bArea, String _bItem) =>
      _firestoreProvider.registerUser(_phone, _bName, _bArea, _bItem);

  // 메인화면
  // 유저 정보 가져오기
  Stream<DocumentSnapshot> getUser(String _phone) =>
      _firestoreProvider.getUser(_phone);
  // 영수증 정보 가져오기
  Stream<QuerySnapshot> getReceipt(
          String _phone, DateTime start, DateTime end) =>
      _firestoreProvider.getReceipt(_phone, start, end);
  // 유저 정보 저장
  void setUser(User _user) => _firestoreProvider.setUser(_user);
  // 영수증 정보 저장
  void setReceipt(Receipt _receipt) => _firestoreProvider.setReceipt(_receipt);
  // 영수증 정보 수정
  void updateReceipt(Receipt _receipt) =>
      _firestoreProvider.updateReceipt(_receipt);
}
