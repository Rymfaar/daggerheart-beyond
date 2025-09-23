import 'package:daggerheart_beyond/domain/entities/user_entity.dart';
import 'package:daggerheart_beyond/domain/repositories/auth_repository.dart';
import 'package:daggerheart_beyond/domain/repositories/user_repository.dart';

class AuthUseCase {
  final IUserRepository _userRepository;
  final IAuthRepository _authRepository;

  AuthUseCase(this._userRepository, this._authRepository);

  Future<UserEntity> logIn(String email, String password) async {
    final UserEntity user = await _authRepository.logIn(email, password);
    return user;
  }

  Future<UserEntity> signUp(
    String username,
    String email,
    String password,
  ) async {
    var createdUser = await _authRepository.signUp(email, password);
    createdUser = createdUser.copyWith(username: username);
    return await _userRepository.createUser(createdUser);
  }

  Future<void> logOut() async {
    await _authRepository.logOut();
  }
}
