import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class svgPlaceHolder extends StatelessWidget {
  final String svgImage, svgMessage;
  final Color textColor;
  final double height;

  const svgPlaceHolder({
    Key? key,
    required this.svgImage,
    required this.svgMessage,
    required this.textColor,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SvgPicture.asset(
            svgImage,
            height: height,
          ),
          SizedBox(height: 15),
          Text(svgMessage,
              textAlign: TextAlign.center, style: TextStyle(color: textColor))
        ],
      ),
    );
  }
}
