import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app_theme.dart';

enum ThemeType { light, dark, eco }

class ThemeController extends GetxController {
  static ThemeController get to => Get.find();
  final storage = GetStorage();
  Rx<ThemeType> currentTheme = ThemeType.light.obs;

  @override
  void onInit() {
    super.onInit();
    // Load saved theme or default to light
    String? savedTheme = storage.read('theme');
    currentTheme.value = _stringToThemeType(savedTheme) ?? ThemeType.light;
    applyTheme();
  }

  void switchTheme(ThemeType theme) {
    currentTheme.value = theme;
    storage.write('theme', theme.name); // Persist theme as string
    applyTheme();
  }

  void applyTheme() {
    switch (currentTheme.value) {
      case ThemeType.dark:
        Get.changeTheme(AppTheme.darkTheme);
        break;
      case ThemeType.eco:
        Get.changeTheme(AppTheme.ecoTheme);
        break;
      case ThemeType.light:
        Get.changeTheme(AppTheme.lightTheme);
        break;
    }
  }

  // Convert stored string to ThemeType
  ThemeType? _stringToThemeType(String? themeString) {
    if (themeString == null) return null;
    return ThemeType.values.firstWhere(
      (type) => type.name == themeString,
      orElse: () => ThemeType.light,
    );
  }
}
