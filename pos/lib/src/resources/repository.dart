import 'package:cloud_firestore/cloud_firestore.dart';
import 'firestore_provider.dart';
import 'package:inject/inject.dart';

class Repository {
  final FirestoreProvider firestoreProvider;

  @provide
  Repository(this.firestoreProvider);

  Future<Map<String, dynamic>> checkVersion() =>
      firestoreProvider.checkVersion();
}
