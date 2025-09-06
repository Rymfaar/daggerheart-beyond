import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:daggerheart_beyond/data/data_sources/firebase_auth_data_source.dart';
import 'package:daggerheart_beyond/data/repositories/auth_repository.dart';
import 'package:daggerheart_beyond/domain/entities/user_entity.dart';
import 'package:daggerheart_beyond/domain/errors.dart';
import '../mocks/user_credentials_mocks.dart';

// Generate a MockUserDataSource class
@GenerateMocks([FirebaseAuthDataSource])
import 'auth_repository_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockUserCredential mockUserCredential;
  late MockFirebaseAuthDataSource mockFirebaseAuthDataSource;
  late AuthRepository authRepository;

  setUp(() {
    mockUserCredential = MockUserCredential();
    mockFirebaseAuthDataSource = MockFirebaseAuthDataSource();
    authRepository = AuthRepository(mockFirebaseAuthDataSource);
  });

  group("signIn", () {
    test('get user entity when data source succeeds', () async {
      final expectedUser = UserEntity(
        id: MockUserData.id,
        email: MockUserData.email,
        username: MockUserData.username,
      );

      when(
        mockFirebaseAuthDataSource.logIn(
          email: MockUserData.email,
          password: MockUserData.password,
        ),
      ).thenAnswer((_) async => mockUserCredential);

      final result = await authRepository.logIn(
        MockUserData.email,
        MockUserData.password,
      );

      verify(
        mockFirebaseAuthDataSource.logIn(
          email: MockUserData.email,
          password: MockUserData.password,
        ),
      ).called(1);
      verifyNoMoreInteractions(mockFirebaseAuthDataSource);
      expect(result, isNotNull);
      expect(result, isA<UserEntity>());
      expect(result, expectedUser);
    });

    test('throws when data source fails', () {
      final result = authRepository.logIn(
        MockUserData.email,
        MockUserData.password,
      );

      when(
        mockFirebaseAuthDataSource.logIn(
          email: MockUserData.email,
          password: MockUserData.password,
        ),
      ).thenThrow(FirebaseAuthException(code: 'some-code'));

      expect(result, throwsA(isA<DHBFailureSignUpWithEmailAndPassword>()));
    });
  });

  group("logIn", () {});
}
