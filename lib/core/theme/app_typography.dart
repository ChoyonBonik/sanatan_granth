import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Pure Bengali and Multilingual typography system:
/// 1. Primary: Noto Serif Bengali & Tiro Bangla for scriptures, translations & purports
/// 2. Hind Siliguri for sleek modern Bengali UI elements, buttons, and navigation
/// 3. Devanagari fallback for original Sanskrit slokas if requested
class AppTypography {
  AppTypography._();

  // ---------------------------------------------------------------------------
  // Bengali Typography (Primary Application Language)
  // ---------------------------------------------------------------------------
  static TextStyle get bengaliTitle => GoogleFonts.notoSerifBengali(
        fontWeight: FontWeight.w700,
        letterSpacing: 0.3,
      );

  static TextStyle get bengaliBody => GoogleFonts.tiroBangla(
        fontSize: 16.0,
        height: 1.65,
      );

  static TextStyle get bengaliUi => GoogleFonts.hindSiliguri(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      );

  static TextStyle bengaliVerse({
    double fontSize = 21.0,
    FontWeight fontWeight = FontWeight.w600,
    Color? color,
  }) {
    return GoogleFonts.notoSerifBengali(
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: 1.85,
      letterSpacing: 0.4,
      color: color,
    );
  }

  static TextStyle bengaliDisplay({
    double fontSize = 28.0,
    FontWeight fontWeight = FontWeight.w700,
    Color? color,
  }) {
    return GoogleFonts.notoSerifBengali(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  // ---------------------------------------------------------------------------
  // Sanskrit / Devanagari (Secondary / Scriptural)
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
  // English / Latin
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
  // Dynamic Script Resolution (Prioritizing Bengali)
  // ---------------------------------------------------------------------------
  static TextStyle forText(
    String text, {
    double fontSize = 16.0,
    FontWeight fontWeight = FontWeight.w400,
    Color? color,
    double? height,
  }) {
    final bool hasBengali = RegExp(r'[\u0980-\u09FF]').hasMatch(text);
    final bool hasDevanagari = RegExp(r'[\u0900-\u097F]').hasMatch(text);

    if (hasBengali) {
      return GoogleFonts.notoSerifBengali(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height ?? 1.75,
      );
    } else if (hasDevanagari) {
      return GoogleFonts.notoSerifDevanagari(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height ?? 1.8,
      );
    }

    return GoogleFonts.tiroBangla(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height ?? 1.65,
    );
  }
}
