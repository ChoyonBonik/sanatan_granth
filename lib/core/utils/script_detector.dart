import 'package:flutter/material.dart';
import '../theme/app_typography.dart';

enum DetectedScript {
  devanagari,
  bengali,
  englishOrLatin,
}

class ScriptDetector {
  ScriptDetector._();

  static final RegExp _devanagariRegex = RegExp(r'[\u0900-\u097F]');
  static final RegExp _bengaliRegex = RegExp(r'[\u0980-\u09FF]');

  static DetectedScript detect(String text) {
    if (_devanagariRegex.hasMatch(text)) {
      return DetectedScript.devanagari;
    } else if (_bengaliRegex.hasMatch(text)) {
      return DetectedScript.bengali;
    }
    return DetectedScript.englishOrLatin;
  }

  static TextStyle getTextStyle(
    String text, {
    double fontSize = 16.0,
    FontWeight fontWeight = FontWeight.w400,
    Color? color,
    double? height,
  }) {
    return AppTypography.forText(
      text,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
    );
  }
}
