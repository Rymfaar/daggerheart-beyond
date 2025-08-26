import 'package:daggerheart_beyond/data/data_sources/firebase_auth_service.dart';
import 'package:daggerheart_beyond/domain/entities/user_entity.dart';
import 'package:daggerheart_beyond/domain/errors.dart';
import 'package:daggerheart_beyond/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository implements IAuthRepository {
  final FirebaseAuthService _service;

  AuthRepository(this._service);

  @override
  Future<UserEntity> signUp(
    String username,
    String email,
    String password,
  ) async {
    try {
      final userCredential = await _service.createAccount(
        email: email,
        password: password,
        username: username,
      );
      // TODO: Add username to created user
      // TODO: Map UserCredential to UserEntity
      return UserEntity(
        id: userCredential.user!.uid, // TODO: Ensure user is not null
        email: email,
        username: username,
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
      final userCredential = await _service.signIn(
        email: email,
        password: password,
      );
      return UserEntity(
        id: userCredential.user!.uid, // TODO: Ensure user is not null
        email: email,
        username:
            userCredential.user!.displayName ??
            '', // TODO: Handle displayName properly
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
      await _service.signOut();
    } catch (e) {
      throw Exception('Failed to sign out: ${e.toString()}');
    }
  }
}
