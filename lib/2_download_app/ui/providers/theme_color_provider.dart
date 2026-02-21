import 'package:flutter/material.dart';

enum ThemeColor {
  blue(color: Color.fromARGB(255, 34, 118, 229)),
  pink(color: Color.fromARGB(255, 229, 158, 221)),
  green(color: Color.fromARGB(255, 156, 202, 8));

  const ThemeColor({required this.color});

  final Color color;
  Color get backgroundColor => color.withAlpha(100);
}

// ThemeColor currentThemeColor = ThemeColor.pink;

class ThemeColorNotifier extends ChangeNotifier {
  ThemeColor _theme = ThemeColor.blue;

  ThemeColor get currentTheme => _theme;

  void onChange(ThemeColor newColor) {
    _theme = newColor;
    notifyListeners();
  }
}

ThemeColorNotifier currentThemeColor = ThemeColorNotifier();
