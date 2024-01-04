import 'package:flutter/material.dart';
import 'package:races/utils/theme/widget_themes/appbar_theme.dart';
import 'package:races/utils/theme/widget_themes/bottom_sheet_theme.dart';
import 'package:races/utils/theme/widget_themes/checkbox_theme.dart';
import 'package:races/utils/theme/widget_themes/chip_theme.dart';
import 'package:races/utils/theme/widget_themes/elevated_button_theme.dart';
import 'package:races/utils/theme/widget_themes/outlined_button_theme.dart';
import 'package:races/utils/theme/widget_themes/text_form_field_theme.dart';
import 'package:races/utils/theme/widget_themes/text_theme.dart';

class SAppTheme {
  SAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.teal,
    textTheme: STextTheme.lightTextTheme,
    chipTheme: SChipTheme.lightChipTheme,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: SAppBarTheme.lightAppBarTheme,
    checkboxTheme: SCheckBoxTheme.lightCheckBoxTheme,
    bottomSheetTheme: SBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: SElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: SOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: STextFormFieldTheme.lightInputDecorationTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.grey,
    textTheme: STextTheme.darkTextTheme,
    chipTheme: SChipTheme.darkChipTheme,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: SAppBarTheme.darkAppBarTheme,
    checkboxTheme: SCheckBoxTheme.darkCheckBoxTheme,
    bottomSheetTheme: SBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: SElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: SOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: STextFormFieldTheme.darkInputDecorationTheme,
  );
}
