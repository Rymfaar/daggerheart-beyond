// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get language => 'English';

  @override
  String get auth => 'AUTHENTICATION';

  @override
  String get auth_signIn => 'Sign in';

  @override
  String get auth_logIn => 'Log in';

  @override
  String get auth_email => 'Email';

  @override
  String get auth_password => 'Password';

  @override
  String get auth_confirmPassword => 'Confirm password';

  @override
  String get auth_noEmailError => 'Please enter your email';

  @override
  String get auth_invalidEmailError => 'Please enter a valid email';

  @override
  String get auth_noPasswordError => 'Please enter your password';

  @override
  String get auth_shortPasswordError =>
      'Password must be at least 6 characters';
}
