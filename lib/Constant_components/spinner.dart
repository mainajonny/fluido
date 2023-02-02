import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../constants.dart';

class Spinner {
  Spinner() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 10000)
      ..indicatorType = EasyLoadingIndicatorType.wanderingCubes
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 70.0
      ..radius = 10.0
      ..userInteractions = false
      ..dismissOnTap = false
      ..progressColor = kPrimaryColor
      ..backgroundColor = Colors.transparent
      ..indicatorColor = kPrimaryColor
      ..textColor = Colors.white;
  }

  Future<void> showLoading() async {
    await EasyLoading.show(maskType: EasyLoadingMaskType.black);
  }

  void dismissLoading() {
    EasyLoading.dismiss();
  }
}
