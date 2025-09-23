import 'package:daggerheart_beyond/domain/entities/user_entity.dart';

abstract class IUserRepository {
  Future<UserEntity> createUser(UserEntity user);
  Future<UserEntity> getUserById(String id);
  Future<UserEntity> updateUser(UserEntity user);
}
