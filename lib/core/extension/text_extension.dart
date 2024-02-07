import 'package:flutter/material.dart';

extension SetFontWeight on TextStyle {
  /// normal
  TextStyle setRegular() => copyWith(fontWeight: FontWeight.normal);

  /// w500
  TextStyle setMedium() => copyWith(fontWeight: FontWeight.w500);

  /// w600
  TextStyle setSemiBold() => copyWith(fontWeight: FontWeight.w600);

  /// bold
  TextStyle setBold() => copyWith(fontWeight: FontWeight.bold);
}
