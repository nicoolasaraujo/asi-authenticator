import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:base32/base32.dart';

class OtpGenerator {
  int intervalRefresh;
  int codeDigits;

  OtpGenerator({this.intervalRefresh = 30, this.codeDigits=6});

  String getTOTP(String secret, int time) {
    var input = (DateTime.now().millisecondsSinceEpoch / intervalRefresh).round().toString();
    print('Input time: $input');
    return this.getHOTP(secret, input);
  }

  String getHOTP(String key, String intervalo) {
    while (intervalo.length < 16 ) intervalo = "0" + intervalo;
    var originalKey = base32.decode(key);
    print('Decode key: $originalKey');

    var hmacHash = Hmac(sha1, originalKey);
    var digest = hmacHash.convert(utf8.encode(intervalo)).bytes;

    print(digest);
    print(digest[digest.length - 1]);

    int offset = digest[digest.length - 1] & 0xf;
    print('Offset: $offset');

    int binary = ((digest[offset] & 0x7f) << 24) |
        ((digest[offset + 1] & 0xff) << 16) |
        ((digest[offset + 2] & 0xff) << 8) |
        (digest[offset + 3] & 0xff);

    var result = (binary % pow(10, 6)).toString();
    while (result.length < this.codeDigits ) result = "0" + result;

    return result;
  }
}
