// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get language => 'Français';

  @override
  String get auth => 'AUTHENTIFICATION';

  @override
  String get auth_signIn => 'S\'inscrire';

  @override
  String get auth_logIn => 'Se connecter';

  @override
  String get auth_email => 'Email';

  @override
  String get auth_password => 'Mot de passe';

  @override
  String get auth_confirmPassword => 'Confirmer mot de passe';

  @override
  String get auth_noEmailError => 'Veuillez entrer votre email';

  @override
  String get auth_invalidEmailError => 'Veuillez entrer un email valide';

  @override
  String get auth_noPasswordError => 'Veuillez entrer votre mot de passe';

  @override
  String get auth_shortPasswordError =>
      'Votre mot de passe doit contenir au moins 6 caractères';
}
