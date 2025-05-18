// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get homeTitle => 'Inicio';

  @override
  String get welcomeMessage => '¡Bienvenido a WorkflowX!';

  @override
  String count(String value) {
    return 'Contador: $value';
  }

  @override
  String get increment => 'Incrementar';

  @override
  String get changeLanguage => 'Cambiar a español';

  @override
  String get darkMode => 'Modo oscuro';

  @override
  String get lightMode => 'Modo claro';

  @override
  String get ecomode => 'Modo ecológico';

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
