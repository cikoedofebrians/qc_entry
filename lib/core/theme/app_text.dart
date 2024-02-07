import 'package:flutter/material.dart';

/// There is an extension available to set the [fontWeight] like
/// `setRegular()`, `setMedium()`, `setSemiBold()` and `setBold()`

class AppTextStyle {
  // ===== HEADING =====
  /// fontSize 44px
  static const TextStyle heading1 = TextStyle(
    fontSize: 44.0,
    height: 54 / 44,
  );

  /// fontSize 36px
  static const TextStyle heading2 = TextStyle(
    fontSize: 36.0,
    height: 46 / 36,
  );

  /// fontSize 28px
  static const TextStyle heading3 = TextStyle(
    fontSize: 28.0,
    height: 38 / 28,
  );

  /// fontSize 24px
  static const TextStyle heading4 = TextStyle(
    fontSize: 24.0,
    height: 34 / 24,
  );

  /// fontSize 20px
  static const TextStyle heading5 = TextStyle(
    fontSize: 20.0,
    height: 26 / 20,
  );

  // ===== BODY =====
  /// fontSize 18px
  static const TextStyle body1 = TextStyle(
    fontSize: 18.0,
    height: 27 / 18,
  );

  /// fontSize 16px
  static const TextStyle body2 = TextStyle(
    fontSize: 16.0,
    height: 24 / 16,
  );

  /// fontSize 14px
  static const TextStyle body3 = TextStyle(
    fontSize: 14.0,
    height: 20 / 14,
  );

  /// fontSize 12px
  static const TextStyle body4 = TextStyle(
    fontSize: 12.0,
    height: 18 / 12,
  );

  /// fontSize 10px
  static const TextStyle body5 = TextStyle(
    fontSize: 10.0,
    height: 18 / 10,
  );

  /// fontSize 6px
  static const TextStyle body6 = TextStyle(
    fontSize: 6.0,
    height: 18 / 8,
  );
}
