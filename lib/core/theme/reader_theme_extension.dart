import 'package:flutter/material.dart';

/// Extension on ThemeData to handle specialized scriptural reading styles
/// including verse, transliteration, commentary, and audio highlight colors.
class ReaderThemeExtension extends ThemeExtension<ReaderThemeExtension> {
  final Color verseTextColor;
  final Color transliterationColor;
  final Color translationColor;
  final Color commentaryColor;
  final Color activeAudioHighlightColor;
  final Color cardBorderColor;
  final Color ornamentalDividerColor;
  final Color svaraAccentColor;

  const ReaderThemeExtension({
    required this.verseTextColor,
    required this.transliterationColor,
    required this.translationColor,
    required this.commentaryColor,
    required this.activeAudioHighlightColor,
    required this.cardBorderColor,
    required this.ornamentalDividerColor,
    required this.svaraAccentColor,
  });

  @override
  ThemeExtension<ReaderThemeExtension> copyWith({
    Color? verseTextColor,
    Color? transliterationColor,
    Color? translationColor,
    Color? commentaryColor,
    Color? activeAudioHighlightColor,
    Color? cardBorderColor,
    Color? ornamentalDividerColor,
    Color? svaraAccentColor,
  }) {
    return ReaderThemeExtension(
      verseTextColor: verseTextColor ?? this.verseTextColor,
      transliterationColor: transliterationColor ?? this.transliterationColor,
      translationColor: translationColor ?? this.translationColor,
      commentaryColor: commentaryColor ?? this.commentaryColor,
      activeAudioHighlightColor:
          activeAudioHighlightColor ?? this.activeAudioHighlightColor,
      cardBorderColor: cardBorderColor ?? this.cardBorderColor,
      ornamentalDividerColor:
          ornamentalDividerColor ?? this.ornamentalDividerColor,
      svaraAccentColor: svaraAccentColor ?? this.svaraAccentColor,
    );
  }

  @override
  ThemeExtension<ReaderThemeExtension> lerp(
    covariant ThemeExtension<ReaderThemeExtension>? other,
    double t,
  ) {
    if (other is! ReaderThemeExtension) return this;
    return ReaderThemeExtension(
      verseTextColor: Color.lerp(verseTextColor, other.verseTextColor, t)!,
      transliterationColor:
          Color.lerp(transliterationColor, other.transliterationColor, t)!,
      translationColor:
          Color.lerp(translationColor, other.translationColor, t)!,
      commentaryColor: Color.lerp(commentaryColor, other.commentaryColor, t)!,
      activeAudioHighlightColor: Color.lerp(
          activeAudioHighlightColor, other.activeAudioHighlightColor, t)!,
      cardBorderColor: Color.lerp(cardBorderColor, other.cardBorderColor, t)!,
      ornamentalDividerColor:
          Color.lerp(ornamentalDividerColor, other.ornamentalDividerColor, t)!,
      svaraAccentColor:
          Color.lerp(svaraAccentColor, other.svaraAccentColor, t)!,
    );
  }
}
