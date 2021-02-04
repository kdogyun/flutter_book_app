import 'package:inject/inject.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../blocs/bloc_base.dart';
import '../resources/repository.dart';
import '../resources/firestore_provider.dart';

@module
class BlocModule {
  @provide
  @singleton
  FirebaseFirestore firestore() => FirebaseFirestore.instance;

  @provide
  @singleton
  FirestoreProvider firestoreProvider(FirebaseFirestore firestore) =>
      FirestoreProvider(firestore);

  @provide
  @singleton
  Repository repository(FirestoreProvider firestoreProvider) =>
      Repository(firestoreProvider);

  @provide
  BlocBase LoginBloc(Repository repository) => LoginBloc(repository);
}
