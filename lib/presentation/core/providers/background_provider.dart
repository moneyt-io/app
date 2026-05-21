import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BackgroundProvider extends ChangeNotifier {
  final SharedPreferences _prefs;
  static const String _bgKey = 'app_custom_background_path';

  String? _backgroundPath;

  BackgroundProvider(this._prefs) {
    _loadBackground();
  }

  String? get backgroundPath => _backgroundPath;

  bool get hasCustomBackground => _backgroundPath != null && _backgroundPath!.isNotEmpty;

  void _loadBackground() {
    _backgroundPath = _prefs.getString(_bgKey);
    notifyListeners();
  }

  Future<void> setBackground(String path) async {
    _backgroundPath = path;
    await _prefs.setString(_bgKey, path);
    notifyListeners();
  }

  Future<void> clearBackground() async {
    _backgroundPath = null;
    await _prefs.remove(_bgKey);
    notifyListeners();
  }
}
