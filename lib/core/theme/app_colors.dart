import 'package:flutter/material.dart';

/// Centralized color definitions for Sanatan Granth.
/// Features Sacred Saffron, Vedic Gold, Warm Sepia parchment, and AMOLED pure black.
class AppColors {
  AppColors._();

  // Sacred Sanatan Accents
  static const Color saffronPrimary = Color(0xFFFF7A00); // Radiant Saffron
  static const Color saffronDeep = Color(0xFFD35400); // Deep Ochre
  static const Color saffronLight = Color(0xFFFFB067);
  static const Color vedicGold = Color(0xFFD4AF37); // Classic Temple Gold
  static const Color rudrakshaMaroon = Color(0xFF8B2500); // Terracotta / Maroon
  static const Color tulsiGreen = Color(0xFF2E7D32); // Sacred Basil
  static const Color gangaCyan = Color(0xFF00838F); // Holy River Blue

  // -------------------------------------------------------------
  // 1. WARM SEPIA PALETTE (Vedic Palm-leaf / Bhojpatra Parchment)
  // -------------------------------------------------------------
  static const Color sepiaBackground = Color(0xFFF7F1E5); // Gentle aged parchment
  static const Color sepiaSurface = Color(0xFFEFE6D5); // Card surface
  static const Color sepiaSurfaceElevated = Color(0xFFE8DDCA);
  static const Color sepiaTextPrimary = Color(0xFF382923); // Deep charcoal bark
  static const Color sepiaTextSecondary = Color(0xFF6B584E); // Soft umber
  static const Color sepiaTextTertiary = Color(0xFF948175);
  static const Color sepiaBorder = Color(0xFFDFD4C0);
  static const Color sepiaActiveAudioHighlight = Color(0xFFFFE6A7); // Sandalwood halo

  // -------------------------------------------------------------
  // 2. CRISP LIGHT PALETTE (Clean modern reading environment)
  // -------------------------------------------------------------
  static const Color lightBackground = Color(0xFFFAFAFB);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceElevated = Color(0xFFF4F4F6);
  static const Color lightTextPrimary = Color(0xFF1C1917); // Obsidian black
  static const Color lightTextSecondary = Color(0xFF57534E);
  static const Color lightTextTertiary = Color(0xFF8C857E);
  static const Color lightBorder = Color(0xFFE7E5E4);
  static const Color lightActiveAudioHighlight = Color(0xFFFFEDD5); // Soft peach amber

  // -------------------------------------------------------------
  // 3. AMOLED DARK PALETTE (True Black zero-power OLED night mode)
  // -------------------------------------------------------------
  static const Color amoledBackground = Color(0xFF000000); // Pure 100% black
  static const Color amoledSurface = Color(0xFF0F0F10); // Subtle OLED gray
  static const Color amoledSurfaceElevated = Color(0xFF18181B);
  static const Color amoledTextPrimary = Color(0xFFF5F5F7); // Warm milk white
  static const Color amoledTextSecondary = Color(0xFFA1A1AA); // Zinc grey
  static const Color amoledTextTertiary = Color(0xFF71717A);
  static const Color amoledBorder = Color(0xFF27272A);
  static const Color amoledActiveAudioHighlight = Color(0xFF451A03); // Deep saffron ember
}
