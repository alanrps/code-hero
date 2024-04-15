import 'dart:convert';
import 'package:crypto/crypto.dart' as crypto;

String publicKey = "c4199fe6da3200a76218ba54a8bb20f6";
String privateKey = "7fe3040c47248090bd9be6eb54512bfef5571441";

int timestamp = DateTime.now().millisecondsSinceEpoch;

String hashValue = generateMd5Hash(timestamp.toString() + privateKey + publicKey);

void main() {
  print(hashValue);
  print(timestamp);
}

String generateMd5Hash(String data) {
  var message = utf8.encode(data);
  var digest = crypto.md5.convert(message);
  return digest.toString();
}