import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/mockito.dart';

class MockUserData {
  static const id = '42';
  static const email = 'tav@example.com';
  static const password = "s3cur3p@ssw0rd";
  static const username = 'tav';
}

class MockUser extends Mock implements User {
  @override
  String get uid => MockUserData.id;

  @override
  String? get email => MockUserData.email;

  @override
  String? get displayName => MockUserData.username;
}

class MockUserCredential extends Mock implements UserCredential {
  @override
  User? get user => MockUser();
}
