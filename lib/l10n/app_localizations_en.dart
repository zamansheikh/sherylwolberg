// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get homeTitle => 'Home';

  @override
  String get welcomeMessage => 'Welcome to WorkflowX!';

  @override
  String count(String value) {
    return 'Counter: $value';
  }

  @override
  String get increment => 'Increment';

  @override
  String get changeLanguage => 'Switch to Spanish';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get lightMode => 'Light Mode';

  @override
  String get ecomode => 'Eco Mode';

  @override
  String get projects => 'Projects';

  @override
  String get refresh => 'Refresh';

  @override
  String get retry => 'Retry';

  @override
  String get noProjectsFound => 'No projects found';

  @override
  String get onGoinProjects => 'On goin Projects';

  @override
  String get allProjects => 'All Projects';
}
