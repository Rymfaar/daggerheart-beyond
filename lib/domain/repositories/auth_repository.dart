import 'package:daggerheart_beyond/domain/entities/user_entity.dart';

abstract class IAuthRepository {
  Future<UserEntity> signUp(String username, String email, String password);
  Future<UserEntity> signIn(String email, String password);
  Future<void> signOut();
}
