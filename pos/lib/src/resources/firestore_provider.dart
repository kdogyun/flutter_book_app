// https://firebase.flutter.dev/docs/firestore/usage
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreProvider {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<int> authenticateUser(String email, String password) async {
    final QuerySnapshot result = await _firestore
        .collection("users")
        .where("email", isEqualTo: email)
        .get();
    final List<DocumentSnapshot> docs = result.docs;
    if (docs.length == 0) {
      return 0;
    } else {
      return 1;
    }
  }

  Future<void> registerUser(String email, String password) async {
    return _firestore
        .collection("users")
        .doc(email)
        .set({'email': email, 'password': password, 'goalAdded': false});
  }

  Future<void> uploadGoal(String title, String documentId, String goal) async {
    DocumentSnapshot doc =
        await _firestore.collection("users").doc(documentId).get();
    Map<String, String> goals = doc.data()["goals"] != null
        ? doc.data()["goals"].cast<String, String>()
        : null;
    if (goals != null) {
      goals[title] = goal;
    } else {
      goals = Map();
      goals[title] = goal;
    }
    return _firestore
        .collection("users")
        .doc(documentId)
        .set({'goals': goals, 'goalAdded': true}, SetOptions(merge: true));
  }

  Stream<DocumentSnapshot> myGoalList(String documentId) {
    return _firestore.collection("users").doc(documentId).snapshots();
  }

  Stream<QuerySnapshot> othersGoalList() {
    return _firestore
        .collection("users")
        .where('goalAdded', isEqualTo: true)
        .snapshots();
  }

  void removeGoal(String title, String documentId) async {
    DocumentSnapshot doc =
        await _firestore.collection("users").doc(documentId).get();
    Map<String, String> goals = doc.data()["goals"].cast<String, String>();
    goals.remove(title);
    if (goals.isNotEmpty) {
      _firestore.collection("users").doc(documentId).update({"goals": goals});
    } else {
      _firestore
          .collection("users")
          .doc(documentId)
          .update({'goals': FieldValue.delete(), 'goalAdded': false});
    }
  }
}
