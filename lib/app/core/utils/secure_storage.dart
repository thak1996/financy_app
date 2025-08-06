import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../interfaces/secure_storage.interface.dart';

class SecureStorage extends ISecureStorage {
  static final FlutterSecureStorage _storage = const FlutterSecureStorage();

  @override
  Future<void> write({required String key, required String value}) async {
    await _storage.write(key: key, value: value);
  }

  @override
  Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }

  @override
  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  @override
  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }
}
