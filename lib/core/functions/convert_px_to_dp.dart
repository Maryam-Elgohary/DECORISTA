import 'package:flutter/material.dart';

double pxToSp(BuildContext context, double px) {
  return TextScaler.noScaling.scale(px);
}
