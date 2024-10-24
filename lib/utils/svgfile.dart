import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

Widget buildSvgIcon(String assetName) {
  return SvgPicture.asset(
    assetName,
    width: 24,
    height: 24,
  );
}
