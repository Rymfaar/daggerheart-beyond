//? Intl texts

//* AUTHENTICATION EXCEPTIONS

class ErrorCode {
  static const String invalidEmail = 'invalid-email';
  static const String userDisabled = 'user-disabled';
  static const String emailAlreadyInUse = 'email-already-in-use';
  static const String operationNotAllowed = 'operation-not-allowed';
  static const String weakPassword = 'weak-password';
  static const String userNotFound = 'user-not-found';
  static const String wrongPassword = 'wrong-password';
}

class DHBFailureSignUpWithEmailAndPassword implements Exception {
  final String message;

  const DHBFailureSignUpWithEmailAndPassword([
    this.message = 'An error occurred. Please try again later.',
  ]);

  factory DHBFailureSignUpWithEmailAndPassword.fromCode(String code) {
    switch (code) {
      case ErrorCode.invalidEmail:
        return const DHBFailureSignUpWithEmailAndPassword(
          'Email is not valid or badly formatted.',
        );
      case ErrorCode.userDisabled:
        return const DHBFailureSignUpWithEmailAndPassword(
          'This user has been disabled. Please contact support for help.',
        );
      case ErrorCode.emailAlreadyInUse:
        return const DHBFailureSignUpWithEmailAndPassword(
          'An account already exists for that email.',
        );
      case ErrorCode.operationNotAllowed:
        return const DHBFailureSignUpWithEmailAndPassword(
          'Operation is not allowed. Please contact support.',
        );
      case ErrorCode.weakPassword:
        return const DHBFailureSignUpWithEmailAndPassword(
          'Please enter a stronger password.',
        );
      default:
        return const DHBFailureSignUpWithEmailAndPassword();
    }
  }
}

class DHBFailureSignInWithEmailAndPassword implements Exception {
  final String message;

  const DHBFailureSignInWithEmailAndPassword([
    this.message = 'An error occurred. Please try again later.',
  ]);

  factory DHBFailureSignInWithEmailAndPassword.fromCode(String code) {
    switch (code) {
      case ErrorCode.invalidEmail:
        return const DHBFailureSignInWithEmailAndPassword(
          'Email is not valid or badly formatted.',
        );
      case ErrorCode.userDisabled:
        return const DHBFailureSignInWithEmailAndPassword(
          'This user has been disabled. Please contact support for help.',
        );
      case ErrorCode.userNotFound:
        return const DHBFailureSignInWithEmailAndPassword(
          'Email is not found, please create an account.',
        );
      case ErrorCode.wrongPassword:
        return const DHBFailureSignInWithEmailAndPassword(
          'Incorrect password, please try again.',
        );
      default:
        return const DHBFailureSignInWithEmailAndPassword();
    }
  }
}

class DHBFailureLogOut implements Exception {}

