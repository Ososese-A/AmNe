import 'dart:convert';
import 'dart:typed_data';
import 'package:pointycastle/export.dart';

final String key = '108afFbB90cC34e6';
final String iv = 'abcdefghijklmnop';

String encrypt(String data) {
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

  final Uint8List encryptedBytes = cipher.process(dataBytes);
  return base64.encode(encryptedBytes);
}

String decrypt(String encrypted) {
  final Uint8List encryptedBytes = base64.decode(encrypted);
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

  final Uint8List decryptedBytes = cipher.process(encryptedBytes);
  return utf8.decode(decryptedBytes);
}
