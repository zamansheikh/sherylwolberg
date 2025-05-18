import 'package:flutter/material.dart';
import 'color_constants.dart';

class LightColorConstants implements ColorConstants {
  @override
  Color get primaryTextColor => Colors.black87;

  @override
  Color get accentColor => Colors.blue;

  @override
  Color get backgroundColor => Colors.white;

  @override
  Color get appBarBackgroundColor => Colors.blue;

  @override
  Color get buttonBackgroundColor => Colors.blue;
  
  @override
  Color get greyColor => Colors.grey[300]!;

  @override
  Color get secondaryTextColor => Colors.grey[600]!;

  @override
  Color get borderColor => Colors.grey[400]!;

  @override
  Color get primaryColor => Colors.blue;
}

class DarkColorConstants implements ColorConstants {
  @override
  Color get primaryTextColor => Colors.white70;

  @override
  Color get accentColor => Colors.blueGrey;

  @override
  Color get backgroundColor => Colors.grey[900]!;

  @override
  Color get appBarBackgroundColor => Colors.blueGrey;

  @override
  Color get buttonBackgroundColor => Colors.blueGrey;
  
  @override
  Color get greyColor => Colors.grey[700]!;

  @override
  Color get secondaryTextColor => Colors.grey[600]!;

  @override
  Color get borderColor => Colors.grey[400]!;

  @override
  Color get primaryColor => Colors.blue;
}

class EcoColorConstants implements ColorConstants {
  @override
  Color get primaryTextColor => Colors.green;

  @override
  Color get accentColor => Colors.green[700]!;

  @override
  Color get backgroundColor => Colors.green[50]!;

  @override
  Color get appBarBackgroundColor => Colors.green;

  @override
  Color get buttonBackgroundColor => Colors.green[700]!;
  
  @override
  Color get greyColor => Colors.green[300]!;

  @override
  Color get secondaryTextColor => Colors.grey[600]!;

  @override
  Color get borderColor => Colors.grey[400]!;

  @override
  Color get primaryColor => Colors.blue;
}
