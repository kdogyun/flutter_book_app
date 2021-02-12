import 'package:cloud_firestore/cloud_firestore.dart';

import 'firestore_provider.dart';

class Repository {
  final _firestoreProvider = FirestoreProvider();

  // 버전 체크
  Future<Map<String, dynamic>> checkVersion() =>
      _firestoreProvider.checkVersion();

  // 로그인
  Future<int> authenticateUser(String phone, String bName) =>
      _firestoreProvider.authenticateUser(phone, bName);

  // 회원가입
  Future<int> registerUser(
          String phone, String bName, String bArea, String bItem) =>
      _firestoreProvider.registerUser(phone, bName, bArea, bItem);

  // 메인화면
  // 유저 정보 가져오기
  Stream<DocumentSnapshot> getUser(String phone) =>
      _firestoreProvider.getUser(phone);
}
