import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';

class SharedPreferencesService {
  var logger = Logger();

  static const String _resetKey = 'isResetEnabled';
  static const String _sizeKey = 'selectedSize';

  Future<Map<String, dynamic>> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final isResetEnabled = prefs.getBool(_resetKey) ?? false;
    final boardSize = prefs.getInt(_sizeKey) ?? 16;
    return {'isResetEnabled': isResetEnabled, 'selectedSize': boardSize};
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

  share1dPreferencesService() {}
}
