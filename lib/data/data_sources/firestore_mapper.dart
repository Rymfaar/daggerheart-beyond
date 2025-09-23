import 'package:daggerheart_beyond/domain/entities/user_entity.dart';

class FirestoreMapper  {
  UserEntity toUserEntity(Map<String, dynamic> data) {
    return UserEntity(
      id: data['id'] as String,
      username: data['username'] as String,
      email: data['email'] as String,
    );
  }

  Map<String, dynamic> toJson(UserEntity user) {
    return {
      'id': user.id,
      'username': user.username,
      'email': user.email,
    };
  }
}
