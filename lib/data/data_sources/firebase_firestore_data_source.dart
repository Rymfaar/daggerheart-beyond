import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreCollections {
  static const String users = 'users';
  static const String characters = 'characters';
}

class FirebaseFirestoreDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createDocument({
    required String collection,
    String? documentId,
    required Map<String, dynamic> data,
  }) async {
    if (documentId == null) {
      await _firestore.collection(collection).add(data);
    } else {
      await _firestore.collection(collection).doc(documentId).set(data);
    }
  }

  Future<void> updateDocumentById({
    required String collection,
    required String documentId,
    required Map<String, dynamic> data,
  }) async {
    await _firestore.collection(collection).doc(documentId).update(data);
  }

  Future<DocumentSnapshot> getDocumentById({
    required String collection,
    required String documentId,
  }) async {
    return _firestore.collection(collection).doc(documentId).get();
  }

  Future<void> deleteDocumentById({
    required String collection,
    required String documentId,
  }) async {
    await _firestore.collection(collection).doc(documentId).delete();
  }
}
