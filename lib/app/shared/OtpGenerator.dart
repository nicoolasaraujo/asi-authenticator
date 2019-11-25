import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:base32/base32.dart';

class OtpGenerator {
  int intervalRefresh;
  int codeDigits;

  OtpGenerator({this.intervalRefresh = 30, this.codeDigits = 6});

  String getTOTP(String secret, int time) {
    int timeEpochSeconds = time ~/ 1000.round();
    var input = (timeEpochSeconds / intervalRefresh).floor();
    print('Input time: $input');
    return this.getHOTP(secret, input);
  }

  String getHOTP(String key, int intervalo) {
    // while (intervalo.length < 16 ) intervalo = "0" + intervalo;

    var originalKey = base32.decode(key);
    print('Secret $originalKey');
    // print('Decode key: $originalKey');

    var hmacHash = Hmac(sha1, originalKey);

    // var test = utf8.encode(intervalo);
    var test = _int2bytes(intervalo);
    print('Time as bytes $test');

    var digest = hmacHash.convert(test).bytes;
    print('digest: $digest');

    // print(digest);
    // print(digest[digest.length - 1]);

    int offset = digest[digest.length - 1] & 0xf;
    print('Offset: $offset');

    int binary = ((digest[offset] & 0x7f) << 24) |
        ((digest[offset + 1] & 0xff) << 16) |
        ((digest[offset + 2] & 0xff) << 8) |
        (digest[offset + 3] & 0xff);
    print('Binary: $binary');

    var result = (binary % pow(10, this.codeDigits)).toString();
    print('Result: $result');

    result = result.padLeft(this.codeDigits, "0");
    return result;
  }

  static Uint8List _int2bytes(int long) {
    // we want to represent the input as a 8-bytes array
    var byteArray = Uint8List(8);
    for (var index = byteArray.length - 1; index >= 0; index--) {
      var byte = long & 0xff;
      byteArray[index] = byte;
      long = (long - byte) ~/ 256;
    }
    return byteArray;
  }
}
