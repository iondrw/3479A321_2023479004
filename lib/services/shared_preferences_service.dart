import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class SharedPreferencesService {
  var logger = Logger();

  static const String _resetKey = 'isResetEnabled';
  static const String _sizeKey = 'selectedSize';
  static const String _creationsKey = 'creations';
  static const String _lastCreationKey = 'lastCreation';

  Future<Map<String, dynamic>> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final isResetEnabled = prefs.getBool(_resetKey) ?? false;
    final boardSize = prefs.getInt(_sizeKey) ?? 16;
    final creations = prefs.getStringList(_creationsKey) ?? [];
    final lastCreation = prefs.getString(_lastCreationKey) ?? '';

    return {
      'isResetEnabled': isResetEnabled,
      'selectedSize': boardSize,
      'creations': creations,
      'lastCreation': lastCreation,
    };
  }

  Future<void> saveResetEnabled(bool isEnabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_resetKey, isEnabled);
    logger.d('DEBUG: isResetEnabled guardado: $isEnabled');
  }

  Future<void> saveBoardSize(int size) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_sizeKey, size);
    logger.d('DEBUG: boardSize guardado: $size');
  }

  Future<void> saveCreations(List<String> creations) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_creationsKey, creations);
    logger.d('DEBUG: Creations guardadas: $creations');
  }

  Future<void> saveLastCreation(String filePath) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastCreation', filePath);
    logger.d('DEBUG: Last creation guardada: $filePath');
  }

  share1dPreferencesService() {}
}

//para traer imagen

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/pixel_art_list.txt');
}

Future<File> writeData(String data) async {
  final file = await _localFile;
  return file.writeAsString(data);
}

Future<int> readData() async {
  try {
    final file = await _localFile;
    String contents = await file.readAsString();
    return int.parse(contents);
  } catch (e) {
    return 0;
  }
}
