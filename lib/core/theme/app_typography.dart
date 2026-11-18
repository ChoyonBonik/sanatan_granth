import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Multilingual typography system supporting:
/// 1. Devanagari (Sanskrit slokas, Hindi commentaries)
/// 2. Bengali (Gita, Chaitanya Charitamrita, Upanishads in Bengali)
/// 3. English (Latin translations, philosophical purports, UI)
class AppTypography {
  AppTypography._();

  // ---------------------------------------------------------------------------
  // English / Universal Fonts
  // ---------------------------------------------------------------------------
  static TextStyle get englishTitle => GoogleFonts.cinzel(
        fontWeight: FontWeight.w700,
        letterSpacing: 0.8,
      );

  static TextStyle get englishBody => GoogleFonts.lora(
        fontSize: 16.0,
        height: 1.6,
      );

  static TextStyle get englishUi => GoogleFonts.inter(
        fontSize: 14.0,
        letterSpacing: 0.1,
      );

  // ---------------------------------------------------------------------------
  // Devanagari (Sanskrit / Hindi)
  // ---------------------------------------------------------------------------
  static TextStyle devanagariVerse({
    double fontSize = 22.0,
    FontWeight fontWeight = FontWeight.w600,
    Color? color,
  }) {
    return GoogleFonts.notoSerifDevanagari(
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: 1.8,
      letterSpacing: 0.5,
      color: color,
    );
  }

  static TextStyle devanagariDisplay({
    double fontSize = 26.0,
    Color? color,
  }) {
    return GoogleFonts.martel(
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
      color: color,
    );
  }

  // ---------------------------------------------------------------------------
  // Bengali Script
  // ---------------------------------------------------------------------------
  static TextStyle bengaliVerse({
    double fontSize = 20.0,
    FontWeight fontWeight = FontWeight.w600,
    Color? color,
  }) {
    return GoogleFonts.notoSerifBengali(
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: 1.75,
      letterSpacing: 0.3,
      color: color,
    );
  }

  static TextStyle bengaliBody({
    double fontSize = 16.0,
    FontWeight fontWeight = FontWeight.w400,
    Color? color,
  }) {
    return GoogleFonts.tiroBangla(
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: 1.6,
      color: color,
    );
  }

  // ---------------------------------------------------------------------------
  // Dynamic Script Resolution
  // ---------------------------------------------------------------------------
  /// Detects script and returns appropriate typography
  static TextStyle forText(
    String text, {
    double fontSize = 16.0,
    FontWeight fontWeight = FontWeight.w400,
    Color? color,
    double? height,
  }) {
    final bool hasDevanagari = RegExp(r'[\u0900-\u097F]').hasMatch(text);
    final bool hasBengali = RegExp(r'[\u0980-\u09FF]').hasMatch(text);

    if (hasDevanagari) {
      return GoogleFonts.notoSerifDevanagari(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height ?? 1.8,
      );
    } else if (hasBengali) {
      return GoogleFonts.notoSerifBengali(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height ?? 1.7,
      );
    }

    return GoogleFonts.lora(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height ?? 1.6,
    );
  }
}
