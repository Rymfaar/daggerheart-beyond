import 'package:daggerheart_beyond/data/data_sources/firebase_firestore_data_source.dart';
import 'package:daggerheart_beyond/data/data_sources/firestore_mapper.dart';
import 'package:daggerheart_beyond/domain/entities/user_entity.dart';
import 'package:daggerheart_beyond/domain/errors.dart';
import 'package:daggerheart_beyond/domain/repositories/user_repository.dart';

class UserRepository implements IUserRepository {
  final FirebaseFirestoreDataSource _dataSource;
  final FirestoreMapper mapper = FirestoreMapper();

  UserRepository(this._dataSource);

  @override
  Future<UserEntity> createUser(UserEntity user) async {
    try {
      await _dataSource.createDocument(
        collection: FirestoreCollections.users,
        documentId: user.id,
        data: mapper.toJson(user),
      );
      final doc = await _dataSource.getDocumentById(
        collection: FirestoreCollections.users,
        documentId: user.id,
      );
      if (doc.exists) {
        return mapper.toUserEntity(doc.data() as Map<String, dynamic>);
      } else {
        throw DHBFailureUserData.fromCode(
          FirebaseFirestore.noDocumentAfterCreation,
        );
      }
    } catch (e) {
      throw DHBFailureUserData.fromCode(
        FirebaseFirestore.failedToCreateDocuement,
      );
    }
  }

  @override
  Future<UserEntity> getUserById(String id) async {
    final data = await _dataSource.getDocumentById(
      collection: FirestoreCollections.users,
      documentId: id,
    );
    return mapper.toUserEntity(data.data() as Map<String, dynamic>);
  }

  @override
  Future<UserEntity> updateUser(UserEntity user) async {
    _dataSource.updateDocumentById(
      collection: FirestoreCollections.users,
      documentId: user.id,
      data: mapper.toJson(user),
    );
    final doc = await _dataSource.getDocumentById(
      collection: FirestoreCollections.users,
      documentId: user.id,
    );
    return mapper.toUserEntity(doc.data() as Map<String, dynamic>);
  }
}
