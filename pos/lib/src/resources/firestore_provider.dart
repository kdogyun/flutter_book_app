// https://firebase.flutter.dev/docs/firestore/usage
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> checkVersion() async {
    final QuerySnapshot result = await _firestore.collection("VERSION").get();
    return result.docs[0].data();
  }
}
