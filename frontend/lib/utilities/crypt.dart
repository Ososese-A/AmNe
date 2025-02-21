import 'dart:convert';
import 'dart:typed_data';
import 'package:pointycastle/export.dart';
// import 'package:pointycastle/api.dart' as api;


Uint8List encrypt(String data, String key, String iv) {
  final Uint8List dataBytes = utf8.encode(data);
  final Uint8List keyBytes = utf8.encode(key);
  final Uint8List ivBytes = utf8.encode(iv);

  final cipher = PaddedBlockCipher('AES/CBC/PKCS7');
  cipher.init(
    true,
    PaddedBlockCipherParameters(
      ParametersWithIV<KeyParameter>(KeyParameter(keyBytes), ivBytes),
      null,
    ),
  );

  return cipher.process(dataBytes);
}

String decrypt(Uint8List encrypted, String key, String iv) {
  final Uint8List keyBytes = utf8.encode(key);
  final Uint8List ivBytes = utf8.encode(iv);

  final cipher = PaddedBlockCipher('AES/CBC/PKCS7');
  cipher.init(
    false,
    PaddedBlockCipherParameters(
      ParametersWithIV<KeyParameter>(KeyParameter(keyBytes), ivBytes),
      null,
    ),
  );

  final Uint8List decryptedBytes = cipher.process(encrypted);
  return utf8.decode(decryptedBytes);
}