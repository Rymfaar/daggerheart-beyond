import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String username;
  final String email;

  const UserEntity({
    required this.id,
    required this.username,
    required this.email,
  });

  static const UserEntity empty = UserEntity(id: '', username: '', email: '');

  get isEmpty => this == UserEntity.empty;

  @override
  List<Object?> get props => [id, username, email];
}
