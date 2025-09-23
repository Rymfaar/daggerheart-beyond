import 'package:daggerheart_beyond/data/data_sources/auth_mapper.dart';
import 'package:daggerheart_beyond/data/data_sources/firebase_auth_data_source.dart';
import 'package:daggerheart_beyond/domain/entities/user_entity.dart';
import 'package:daggerheart_beyond/domain/errors.dart';
import 'package:daggerheart_beyond/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository implements IAuthRepository {
  final FirebaseAuthDataSource _dataSource;
  final AuthMapper mapper = AuthMapper();

  AuthRepository(this._dataSource);

  @override
  Future<UserEntity> signUp(String email, String password) async {
    try {
      final userCredential = await _dataSource.createAccount(
        email: email,
        password: password,
      );
      return mapper.toUserEntity(userCredential.user!);
    } on FirebaseException catch (e) {
      throw DHBFailureSignUpWithEmailAndPassword.fromCode(e.code);
    } catch (_) {
      throw const DHBFailureSignUpWithEmailAndPassword();
    }
  }

  @override
  Future<UserEntity> logIn(String email, String password) async {
    try {
      final userCredential = await _dataSource.logIn(
        email: email,
        password: password,
      );
      return mapper.toUserEntity(userCredential.user!);
    } on FirebaseException catch (e) {
      throw DHBFailureSignInWithEmailAndPassword.fromCode(e.code);
    } catch (_) {
      throw const DHBFailureSignUpWithEmailAndPassword();
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await _dataSource.signOut();
    } catch (e) {
      throw Exception('Failed to log out: ${e.toString()}');
    }
  }
}
