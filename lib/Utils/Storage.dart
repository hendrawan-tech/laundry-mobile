import 'package:flutter_secure_storage/flutter_secure_storage.dart';

IOSOptions _getIOSOptions() => const IOSOptions(
      accountName: 'KAI_secure_storage_service',
    );

AndroidOptions _getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );

class Storage {
  static save(key, value) async {
    const _storage = FlutterSecureStorage();

    return await _storage.write(
      key: key,
      value: value,
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
  }

  static get(key) async {
    const storageFunc = FlutterSecureStorage();

    var data = await storageFunc.read(
      key: key,
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
    return data;
  }
  static remove(key) async {
    const storageFuncDel = FlutterSecureStorage();

    var data = await storageFuncDel.delete(
      key: key,
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
    return data;
  }
}
