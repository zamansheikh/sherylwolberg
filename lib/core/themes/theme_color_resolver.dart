import 'theme_controller.dart';
import 'color_constants.dart';
import 'theme_color_constants.dart';

class ThemeColorResolver {
  static ColorConstants getColorConstants() {
    final themeController = ThemeController.to;
    switch (themeController.currentTheme.value) {
      case ThemeType.dark:
        return DarkColorConstants();
      case ThemeType.eco:
        return EcoColorConstants();
      case ThemeType.light:
        return LightColorConstants();
    }
  }
}
