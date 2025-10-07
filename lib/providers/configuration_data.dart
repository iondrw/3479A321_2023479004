import 'package:flutter/material.dart';

class ConfigurationData extends ChangeNotifier {
  int _size = 10;
  int get size => _size;
  Color _paletteColor = Colors.red; // Color inicial
  String _palette = 'Retro';

  // Lista de colores para el Dropdown
  List<Color> availableColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
    Colors.black,
  ];

  Color get paletteColor => _paletteColor;
  String get palette => _palette;

  void setSize(int newSize) {
    _size = newSize;
    notifyListeners(); // Notifica a los oyentes cuando el tamaño cambia
  }

  void setPaletteColor(Color newColor) {
    _paletteColor = newColor;
    notifyListeners(); // Notifica a los oyentes cuando el color cambia
  }

  void setPalette(String newPalette) {
    _palette = newPalette;
    notifyListeners();
  }
}
