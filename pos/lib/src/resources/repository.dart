import 'package:cloud_firestore/cloud_firestore.dart';
import 'firestore_provider.dart';

class Repository {
  final _firestoreProvider = FirestoreProvider();

  Future<Map<String, dynamic>> checkVersion() =>
      _firestoreProvider.checkVersion();
}
