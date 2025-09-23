import 'package:daggerheart_beyond/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMapper {
  UserEntity toUserEntity(User data) {
    return UserEntity(
      id: data.uid,
      username: data.displayName ?? '',
      email: data.email ?? '',
    );
  }
}
