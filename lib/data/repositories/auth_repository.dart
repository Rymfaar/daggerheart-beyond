import 'package:daggerheart_beyond/data/data_sources/firebase_auth_data_source.dart';
import 'package:daggerheart_beyond/domain/entities/user_entity.dart';
import 'package:daggerheart_beyond/domain/errors.dart';
import 'package:daggerheart_beyond/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository implements IAuthRepository {
  final FirebaseAuthDataSource _dataSource;

  AuthRepository(this._dataSource);

  @override
  Future<UserEntity> signUp(
    String username,
    String email,
    String password,
  ) async {
    try {
      final userCredential = await _dataSource.createAccount(
        email: email,
        password: password,
        username: username,
      );
      return UserEntity(
        id: userCredential.user!.uid,
        email: userCredential.user!.email ?? '',
        username: userCredential.user!.displayName ?? '',
      );
    } on FirebaseException catch (e) {
      throw DHBFailureSignUpWithEmailAndPassword.fromCode(e.code);
    } catch (_) {
      throw const DHBFailureSignUpWithEmailAndPassword();
    }
  }

  @override
  Future<UserEntity> signIn(String email, String password) async {
    try {
      final userCredential = await _dataSource.signIn(
        email: email,
        password: password,
      );
      return UserEntity(
        id: userCredential.user!.uid,
        email: userCredential.user!.email ?? '',
        username: userCredential.user!.displayName ?? '',
      );
    } on FirebaseException catch (e) {
      throw DHBFailureSignInWithEmailAndPassword.fromCode(e.code);
    } catch (_) {
      throw const DHBFailureSignUpWithEmailAndPassword();
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _dataSource.signOut();
    } catch (e) {
      throw Exception('Failed to sign out: ${e.toString()}');
    }
  }
}
