import 'package:flutter/services.dart';

class PlatformRepository {
  static const platform = MethodChannel('native.flutter/hover_helper');

  Future<String> startHover(
    String action,
    String? phonenumber,
    String? tillnumber,
    String? businessnumber,
    String? account,
    String? amount,
  ) async {
    late String result;

    try {
      result = await platform.invokeMethod("startHover", {
        "action": action,
        "phonenumber": phonenumber,
        "tillnumber": tillnumber,
        "businessnumber": businessnumber,
        "account": account,
        "amount": amount,
      });
    } on PlatformException catch (e) {
      print(e);
      result = "";
    }

    print('@@ RESULT -> $result');
    return result;
  }
}
