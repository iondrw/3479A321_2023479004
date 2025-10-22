import 'package:flutter/material.dart';
import 'package:flutter_application_lab2/pages/list_art.dart';
import 'package:logger/logger.dart';
import 'package:flutter_application_lab2/services/shared_preferences_service.dart';

class ConfigurationData extends ChangeNotifier {
  int _size = 10;
  int get size => _size;

  Color _paletteColor = Colors.red;
  String _palette = 'Retro';
  final SharedPreferencesService _prefsService;
  bool _isResetEnabled = false;
  List<String> _creations = [];
  String _lastCreation = '';

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
  bool get isResetEnabled => _isResetEnabled;
  List<String> get getCreations => _creations;
  String get getLastCreation => _lastCreation;

  ConfigurationData(this._prefsService) {
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final data = await _prefsService.loadPreferences();
    _size = data['selectedSize'] ?? 16;
    _isResetEnabled = data['isResetEnabled'] ?? false;
    _creations = data['creations'] ?? [];
    _lastCreation = data['lastCreation'] ?? '';
    notifyListeners();
    var logger = Logger();
    logger.d(
      'ConfigurationData loaded - size: $_size, isResetEnabled: $_isResetEnabled, creations: $_creations, lastCreation: $_lastCreation',
    );
  }

  void addCreation(String filePath) {
    _creations.add(filePath);
    _prefsService.saveCreations(_creations);
    notifyListeners();
  }

  void setLastCreation(String filePath) {
    _lastCreation = filePath;
    _prefsService.saveLastCreation(filePath);
    notifyListeners();
  }

  void setSize(int newSize) {
    if (_size != newSize) {
      _size = newSize;
      _prefsService.saveBoardSize(newSize);
      notifyListeners();
    }
  }

  void setResetEnabled(bool isEnabled) {
    if (_isResetEnabled != isEnabled) {
      _isResetEnabled = isEnabled;
      _prefsService.saveResetEnabled(isEnabled);
      notifyListeners();
    }
  }

  void setPaletteColor(Color newColor) {
    if (_paletteColor != newColor) {
      _paletteColor = newColor;
      notifyListeners();
    }
  }

  void setPalette(String newPalette) {
    if (_palette != newPalette) {
      _palette = newPalette;
      notifyListeners();
    }
  }
}
