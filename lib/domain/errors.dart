//? Intl texts

//* AUTHENTICATION EXCEPTIONS

class FirebaseAuthError {
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
      case FirebaseAuthError.invalidEmail:
        return const DHBFailureSignUpWithEmailAndPassword(
          'Email is not valid or badly formatted.',
        );
      case FirebaseAuthError.userDisabled:
        return const DHBFailureSignUpWithEmailAndPassword(
          'This user has been disabled. Please contact support for help.',
        );
      case FirebaseAuthError.emailAlreadyInUse:
        return const DHBFailureSignUpWithEmailAndPassword(
          'An account already exists for that email.',
        );
      case FirebaseAuthError.operationNotAllowed:
        return const DHBFailureSignUpWithEmailAndPassword(
          'Operation is not allowed. Please contact support.',
        );
      case FirebaseAuthError.weakPassword:
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
      case FirebaseAuthError.invalidEmail:
        return const DHBFailureSignInWithEmailAndPassword(
          'Email is not valid or badly formatted.',
        );
      case FirebaseAuthError.userDisabled:
        return const DHBFailureSignInWithEmailAndPassword(
          'This user has been disabled. Please contact support for help.',
        );
      case FirebaseAuthError.userNotFound:
        return const DHBFailureSignInWithEmailAndPassword(
          'Email is not found, please create an account.',
        );
      case FirebaseAuthError.wrongPassword:
        return const DHBFailureSignInWithEmailAndPassword(
          'Incorrect password, please try again.',
        );
      default:
        return const DHBFailureSignInWithEmailAndPassword();
    }
  }
}

//! USER ERRORS

enum FirebaseFirestore {
  unknown,
  failedToCreateDocuement,
  noDocumentAfterCreation,
}

class DHBFailureUserData implements Exception {
  final String message;

  const DHBFailureUserData([
    this.message = 'An error occurred. Please try again later.',
  ]);

  factory DHBFailureUserData.fromCode(FirebaseFirestore code) {
    switch (code) {
      case FirebaseFirestore.noDocumentAfterCreation:
        return const DHBFailureUserData(
          'User document does not exist after creation.',
        );
      case FirebaseFirestore.failedToCreateDocuement:
        return const DHBFailureUserData('Failed to create user.');
      case FirebaseFirestore.unknown:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }
}
