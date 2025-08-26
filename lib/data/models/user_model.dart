import 'package:daggerheart_beyond/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String username;
  final String email;
  // final [String] charactersRefs;

  const UserModel({
    required this.id,
    required this.username,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
    );
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      username: entity.username,
      email: entity.email,
    );
  }

  Map<String, dynamic> toJson() { // DTO
    return {
      'id': id,
      'username': username,
      'email': email,
    };
  }

  factory UserModel.empty() {
    return UserModel(
      id: '',
      username: '',
      email: '',
    );
  }

  UserModel copyWith({
    String? id,
    String? username,
    String? email,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
    );
  }

  bool get isEmpty => this == UserModel.empty();
  bool get isNotEmpty => this != UserModel.empty();
  
  @override
  List<Object?> get props => [id, username, email];
}
