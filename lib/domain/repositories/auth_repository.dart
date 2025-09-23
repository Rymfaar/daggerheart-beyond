import 'package:daggerheart_beyond/domain/entities/user_entity.dart';

abstract class IAuthRepository {
  Future<UserEntity> signUp(String email, String password);
  Future<UserEntity> logIn(String email, String password);
  Future<void> logOut();
}
