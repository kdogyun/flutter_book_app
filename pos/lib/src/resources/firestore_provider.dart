// https://firebase.flutter.dev/docs/firestore/usage
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:pos/src/models/receipt.dart';
import 'package:pos/src/models/user.dart';

class FirestoreProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Content> order = [];

  // 버전 체크
  Future<Map<String, dynamic>> checkVersion() {
    return _firestore.collection("VERSION").limit(1).get().then((value) {
      return value.docs[0].data();
    });
  }

// 정상 로그인 1, 아이디 없음 0, 비번(상호명) 틀림 -1
  Future<int> authenticateUser(String _phone, String _name) async {
    final DocumentSnapshot result =
        await _firestore.collection("USER").doc(_phone).get();
    if (result == null || !result.exists)
      return 0;
    else {
      if (result.data()['bName'] == _name)
        return 1;
      else
        return -1;
    }
  }

// 회원가입
// 정상가입 1, 폰번호 중복 -1
  Future<int> registerUser(
      String _phone, String _bName, String _bArea, String _bItem) async {
    final DocumentSnapshot result = await _firestore
        .collection("USER")
        // .where("phone", isEqualTo: phone)
        .doc(_phone)
        .get();
    if (result.data() != null || result.exists) return -1;
    await _firestore
        .collection("USER")
        .doc(_phone)
        .set(new User.four(_phone, _bName, _bItem, _bArea).toJson());
    return 1;
  }

// 회원 정보 가져오기
  Stream<DocumentSnapshot> getUser(String _phone) {
    return _firestore.collection("USER").doc(_phone).snapshots();
  }

// 회원 정보 저장
  void setUser(User _user) async {
    print(_user.toJson());
    return await _firestore
        .collection("USER")
        // .where("phone", isEqualTo: phone)
        .doc(_user.phone)
        .set(_user.toJson());
  }

// 영수증 정보 가져오기
  Stream<QuerySnapshot> getReceipt(
      String _phone, DateTime start, DateTime end) {
    // '2019-03-13 16:49:42.044'
    final startAt =
        DateTime.parse(new DateFormat('yyyy-MM-dd 00:00:00.000').format(start))
            .millisecondsSinceEpoch;
    final endAt =
        DateTime.parse(new DateFormat('yyyy-MM-dd 23:59:59.999').format(end))
            .millisecondsSinceEpoch;
    return _firestore
        .collection("RECEIPT")
        .where("phone", isEqualTo: _phone)
        .where('createdAt', isGreaterThanOrEqualTo: startAt)
        .where('createdAt', isLessThanOrEqualTo: endAt)
        .orderBy('createdAt', descending: true)
        .snapshots();
    // .startAt([startAtTimestamp]).endAt([endAtTimestamp]).snapshots();
    // startAt, endAt은 페이징...
    // https://firebase.google.com/docs/firestore/query-data/query-cursors?hl=ko
  }

// 영수증 정보 저장하기
  void setReceipt(Receipt _receipt) async {
    // '2019-03-13 16:49:42.044'
    return await _firestore
        .collection("RECEIPT")
        .doc('${_receipt.phone}${_receipt.createdAt.millisecondsSinceEpoch}')
        .set(_receipt.toJson());
  }

// 영수증 정보 업데이트하기
  void updateReceipt(Receipt _receipt) async {
    return await _firestore
        .collection("RECEIPT")
        .doc('${_receipt.phone}${_receipt.createdAt.millisecondsSinceEpoch}')
        .update(_receipt.toJson());
  }

// 영수증 정보 삭제하기
  void deleteReceipt(Receipt _receipt) async {
    return await _firestore
        .collection("RECEIPT")
        .doc('${_receipt.phone}${_receipt.createdAt.millisecondsSinceEpoch}')
        .delete();
  }
}
