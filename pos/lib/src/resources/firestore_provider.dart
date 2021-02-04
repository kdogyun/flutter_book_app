// https://firebase.flutter.dev/docs/firestore/usage
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

class FirestoreProvider {
  final FirebaseFirestore firestore;

  @provide
  FirestoreProvider(this.firestore);

  Future<Map<String, dynamic>> checkVersion() async {
    final QuerySnapshot result = await firestore.collection("VERSION").get();
    return result.docs[0].data();
  }
}
