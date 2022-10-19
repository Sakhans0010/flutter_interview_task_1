import 'package:flutter/material.dart';

SizedBox verticalSpacer(int height) {
  // final value = height / 812;
  return SizedBox(
    height: height.toDouble(),
  );
}

SizedBox horizontalSpacer(int width) {
  // final value = width / 375;
  return SizedBox(
    width: width.toDouble(),
  );
}
