// https://firebase.flutter.dev/docs/firestore/usage
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:pos/src/models/receipt.dart';

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
  Future<int> authenticateUser(String phone, String name) async {
    final DocumentSnapshot result =
        await _firestore.collection("USER").doc(phone).get();
    if (result == null || !result.exists)
      return 0;
    else {
      if (result.data()['bName'] == name)
        return 1;
      else
        return -1;
    }
  }

// 회원가입
// 정상가입 1, 폰번호 중복 -1
  Future<int> registerUser(
      String phone, String bName, String bArea, String bItem) async {
    final DocumentSnapshot result = await _firestore
        .collection("USER")
        // .where("phone", isEqualTo: phone)
        .doc(phone)
        .get();
    if (result.data() != null || result.exists) return -1;
    await _firestore
        .collection("USER")
        .doc(phone)
        .set({'phone': phone, 'bName': bName, 'bArea': bArea, 'bItem': bItem});
    return 1;
  }

// 회원 정보 가져오기
  Stream<DocumentSnapshot> getUser(String phone) {
    return _firestore.collection("USER").doc(phone).snapshots();
  }

// 영수증 정보 가져오기
  Stream<QuerySnapshot> getReceipt(String phone) {
    // '2019-03-13 16:49:42.044'
    print(new DateFormat('yyyy-MM-dd 00:00:00.000').format(new DateTime.now()));
    final startAtTimestamp = Timestamp.fromMillisecondsSinceEpoch(
        DateTime.parse(new DateFormat('yyyy-MM-dd 00:00:00.000')
                .format(new DateTime.now()))
            .millisecondsSinceEpoch);
    final endAtTimestamp = Timestamp.fromMillisecondsSinceEpoch(
        DateTime.parse(new DateFormat('yyyy-MM-dd').format(new DateTime.now()))
            .millisecondsSinceEpoch);
    return _firestore
        .collection("RECEIPT")
        .where("phone", isEqualTo: phone)
        .orderBy('createdAt', descending: true)
        .startAt([startAtTimestamp]).endAt([endAtTimestamp]).snapshots();
  }
}
