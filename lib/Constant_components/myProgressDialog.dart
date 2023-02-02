import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../constants.dart';

class BottomSheetLoader extends StatelessWidget {
  const BottomSheetLoader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 50, top: 50),
      child: SpinKitChasingDots(
        color: kPrimaryColor,
        duration: const Duration(seconds: 1),
        size: 30,
      ),
    );
  }
}

class pageProgress extends StatelessWidget {
  double size;

  pageProgress({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitFadingCircle(
      color: kPrimaryColor,
      duration: const Duration(milliseconds: 500),
      size: size,
    );
  }
}
