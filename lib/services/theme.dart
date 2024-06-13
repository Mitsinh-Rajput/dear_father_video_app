import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Color primaryColor = const Color(0xFF941f37);
Color secondaryColor = const Color(0xFF941f37).withOpacity(.47);
Color backgroundDark = const Color(0xff231F20);
Color backgroundLight = const Color(0xffffffff);

const Color textPrimary = Color(0xff000000);
const Color textSecondary = Color(0xff838383);
Map<int, Color> color = const {
  50: Color.fromRGBO(255, 244, 149, .1),
  100: Color.fromRGBO(255, 244, 149, .2),
  200: Color.fromRGBO(255, 244, 149, .3),
  300: Color.fromRGBO(255, 244, 149, .4),
  400: Color.fromRGBO(255, 244, 149, .5),
  500: Color.fromRGBO(255, 244, 149, .6),
  600: Color.fromRGBO(255, 244, 149, .7),
  700: Color.fromRGBO(255, 244, 149, .8),
  800: Color.fromRGBO(255, 244, 149, .9),
  900: Color.fromRGBO(255, 244, 149, 1),
};
MaterialColor colorCustom = MaterialColor(0XFFFFF495, color);

class CustomTheme {
  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    scaffoldBackgroundColor: backgroundLight,
    hintColor: Colors.grey[200],
    primarySwatch: colorCustom,
    canvasColor: secondaryColor,
    primaryColorLight: secondaryColor,
    splashColor: secondaryColor,
    shadowColor: Colors.grey[600],
    cardColor: const Color(0xFFFFFFFF),
    primaryColor: primaryColor,
    dividerColor: const Color(0xFF2A2A2A),
    primaryColorDark: Colors.black,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: primaryColor,
      onPrimary: primaryColor,
      secondary: secondaryColor,
      onSecondary: secondaryColor,
      error: const Color(0xFFCF6679),
      onError: const Color(0xFFCF6679),
      background: backgroundLight,
      onBackground: backgroundLight,
      surface: backgroundDark,
      onSurface: backgroundDark,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      actionsIconTheme: IconThemeData(
        color: primaryColor,
      ),
      iconTheme: IconThemeData(
        color: primaryColor,
      ),
      systemOverlayStyle: const SystemUiOverlayStyle(
        // Status bar color
        statusBarColor: Colors.white,
        // Status bar brightness (optional)
        statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        statusBarBrightness: Brightness.light, // For iOS (dark icons)
      ),
    ),
    typography: Typography.material2021(),
    textTheme: const TextTheme(
      labelLarge: TextStyle(
        fontWeight: FontWeight.w400,
        color: textSecondary,
        fontSize: 14.0,
      ),
      displayLarge: TextStyle(fontWeight: FontWeight.w400),
      displayMedium: TextStyle(fontWeight: FontWeight.w400),
      displaySmall: TextStyle(fontWeight: FontWeight.w400),
      titleLarge: TextStyle(fontWeight: FontWeight.w400),
      titleMedium: TextStyle(fontWeight: FontWeight.w400),
      titleSmall: TextStyle(fontWeight: FontWeight.w400),
      bodyLarge: TextStyle(fontWeight: FontWeight.w400),
      bodyMedium: TextStyle(fontWeight: FontWeight.w400),
      bodySmall: TextStyle(fontWeight: FontWeight.w400),
    ),
  );
}
