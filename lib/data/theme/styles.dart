import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      primaryColor: isDarkTheme ? Colors.black : Colors.white,
      scaffoldBackgroundColor: isDarkTheme ? Colors.black : Colors.white,
      indicatorColor: isDarkTheme ? Colors.white : Colors.black,
      highlightColor: isDarkTheme ? Colors.grey.shade300 : Colors.grey.shade800,
      hoverColor: isDarkTheme ? Colors.grey.shade700 : Colors.white,
      cardColor: isDarkTheme ? Colors.grey.shade800 : Colors.white,
      shadowColor: isDarkTheme ? Colors.grey.shade900 : Colors.grey.shade400,
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
            colorScheme: isDarkTheme
                ? const ColorScheme.dark()
                : const ColorScheme.light(),
          ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: isDarkTheme ? Colors.black : Colors.white,
      ),
    );
  }
}
