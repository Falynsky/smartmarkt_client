import 'package:flutter/material.dart';
import 'package:smartmarktclient/utilities/colors.dart';

Widget gradientBackground() {
  final gradientColorsStops = [0.1, 0.4, 0.7, 0.9];
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: backgroundGradient,
        stops: gradientColorsStops,
      ),
    ),
  );
}
