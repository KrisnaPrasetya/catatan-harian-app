import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorageService {
  static final _storage = FlutterSecureStorage();

  static Future<void> init() async {
    // Logika inisialisasi jika diperlukan
  }

  static Future<void> saveData(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  static Future<String?> getData(String key) async {
    return await _storage.read(key: key);
  }

  static Future<void> deleteData(String key) async {
    await _storage.delete(key: key);
  }
}
