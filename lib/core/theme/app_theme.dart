import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import 'app_typography.dart';
import 'reader_theme_extension.dart';

enum AppThemeMode {
  light,
  sepia,
  amoledDark,
  system,
}

class AppTheme {
  AppTheme._();

  // ---------------------------------------------------------------------------
  // 1. WARM SEPIA THEME (উষ্ণ ভুর্জপত্র / প্রাচীন বৈদিক পাণ্ডুলিপি রূপ)
  // ---------------------------------------------------------------------------
  static ThemeData get sepiaTheme {
    const ColorScheme colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.saffronDeep,
      onPrimary: Colors.white,
      secondary: AppColors.vedicGold,
      onSecondary: AppColors.sepiaTextPrimary,
      error: Color(0xFFBA1A1A),
      onError: Colors.white,
      surface: AppColors.sepiaSurface,
      onSurface: AppColors.sepiaTextPrimary,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.sepiaBackground,
      colorScheme: colorScheme,
      cardColor: AppColors.sepiaSurface,
      dividerColor: AppColors.sepiaBorder,
      fontFamily: GoogleFonts.hindSiliguri().fontFamily,
      textTheme: _buildBengaliTextTheme(
        baseColor: AppColors.sepiaTextPrimary,
        secondaryColor: AppColors.sepiaTextSecondary,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.sepiaBackground,
        elevation: 0,
        scrolledUnderElevation: 1,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.sepiaTextPrimary),
        titleTextStyle: AppTypography.bengaliTitle.copyWith(
          color: AppColors.sepiaTextPrimary,
          fontSize: 21,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.sepiaSurface,
        indicatorColor: AppColors.saffronPrimary.withAlpha(50),
        labelTextStyle: WidgetStateProperty.all(
          AppTypography.bengaliUi.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.sepiaTextPrimary,
          ),
        ),
      ),
      cardTheme: CardTheme(
        color: AppColors.sepiaSurface,
        elevation: 0.5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.sepiaBorder, width: 0.8),
        ),
      ),
      extensions: const <ThemeExtension<dynamic>>[
        ReaderThemeExtension(
          verseTextColor: AppColors.rudrakshaMaroon,
          transliterationColor: AppColors.sepiaTextSecondary,
          translationColor: AppColors.sepiaTextPrimary,
          commentaryColor: AppColors.sepiaTextSecondary,
          activeAudioHighlightColor: AppColors.sepiaActiveAudioHighlight,
          cardBorderColor: AppColors.sepiaBorder,
          ornamentalDividerColor: AppColors.vedicGold,
          svaraAccentColor: AppColors.saffronDeep,
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // 2. CRISP LIGHT THEME (উজ্জ্বল দিন)
  // ---------------------------------------------------------------------------
  static ThemeData get lightTheme {
    const ColorScheme colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.saffronPrimary,
      onPrimary: Colors.white,
      secondary: AppColors.saffronDeep,
      onSecondary: Colors.white,
      error: Color(0xFFBA1A1A),
      onError: Colors.white,
      surface: AppColors.lightSurface,
      onSurface: AppColors.lightTextPrimary,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBackground,
      colorScheme: colorScheme,
      cardColor: AppColors.lightSurface,
      dividerColor: AppColors.lightBorder,
      fontFamily: GoogleFonts.hindSiliguri().fontFamily,
      textTheme: _buildBengaliTextTheme(
        baseColor: AppColors.lightTextPrimary,
        secondaryColor: AppColors.lightTextSecondary,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.lightBackground,
        elevation: 0,
        scrolledUnderElevation: 1,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.lightTextPrimary),
        titleTextStyle: AppTypography.bengaliTitle.copyWith(
          color: AppColors.lightTextPrimary,
          fontSize: 21,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.lightSurface,
        indicatorColor: AppColors.saffronPrimary.withAlpha(40),
        labelTextStyle: WidgetStateProperty.all(
          AppTypography.bengaliUi.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.lightTextPrimary,
          ),
        ),
      ),
      cardTheme: CardTheme(
        color: AppColors.lightSurface,
        elevation: 0.5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.lightBorder, width: 0.8),
        ),
      ),
      extensions: const <ThemeExtension<dynamic>>[
        ReaderThemeExtension(
          verseTextColor: AppColors.saffronDeep,
          transliterationColor: AppColors.lightTextSecondary,
          translationColor: AppColors.lightTextPrimary,
          commentaryColor: AppColors.lightTextSecondary,
          activeAudioHighlightColor: AppColors.lightActiveAudioHighlight,
          cardBorderColor: AppColors.lightBorder,
          ornamentalDividerColor: AppColors.saffronLight,
          svaraAccentColor: AppColors.saffronPrimary,
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // 3. AMOLED DARK THEME (অ্যামোলেড ডার্ক / নিখুঁত কালো)
  // ---------------------------------------------------------------------------
  static ThemeData get amoledDarkTheme {
    const ColorScheme colorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.saffronPrimary,
      onPrimary: Colors.black,
      secondary: AppColors.vedicGold,
      onSecondary: Colors.black,
      error: Color(0xFFFFB4AB),
      onError: Color(0xFF690005),
      surface: AppColors.amoledSurface,
      onSurface: AppColors.amoledTextPrimary,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.amoledBackground,
      colorScheme: colorScheme,
      cardColor: AppColors.amoledSurface,
      dividerColor: AppColors.amoledBorder,
      fontFamily: GoogleFonts.hindSiliguri().fontFamily,
      textTheme: _buildBengaliTextTheme(
        baseColor: AppColors.amoledTextPrimary,
        secondaryColor: AppColors.amoledTextSecondary,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.amoledBackground,
        elevation: 0,
        scrolledUnderElevation: 1,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.amoledTextPrimary),
        titleTextStyle: AppTypography.bengaliTitle.copyWith(
          color: AppColors.amoledTextPrimary,
          fontSize: 21,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.amoledSurface,
        indicatorColor: AppColors.saffronPrimary.withAlpha(60),
        labelTextStyle: WidgetStateProperty.all(
          AppTypography.bengaliUi.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.amoledTextPrimary,
          ),
        ),
      ),
      cardTheme: CardTheme(
        color: AppColors.amoledSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.amoledBorder, width: 0.8),
        ),
      ),
      extensions: const <ThemeExtension<dynamic>>[
        ReaderThemeExtension(
          verseTextColor: AppColors.saffronLight,
          transliterationColor: AppColors.amoledTextSecondary,
          translationColor: AppColors.amoledTextPrimary,
          commentaryColor: AppColors.amoledTextSecondary,
          activeAudioHighlightColor: AppColors.amoledActiveAudioHighlight,
          cardBorderColor: AppColors.amoledBorder,
          ornamentalDividerColor: AppColors.vedicGold,
          svaraAccentColor: AppColors.saffronPrimary,
        ),
      ],
    );
  }

  static TextTheme _buildBengaliTextTheme({
    required Color baseColor,
    required Color secondaryColor,
  }) {
    return TextTheme(
      headlineLarge: GoogleFonts.notoSerifBengali(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: baseColor,
      ),
      headlineMedium: GoogleFonts.notoSerifBengali(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: baseColor,
      ),
      headlineSmall: GoogleFonts.notoSerifBengali(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: baseColor,
      ),
      titleLarge: GoogleFonts.hindSiliguri(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: baseColor,
      ),
      titleMedium: GoogleFonts.hindSiliguri(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: baseColor,
      ),
      titleSmall: GoogleFonts.hindSiliguri(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: secondaryColor,
      ),
      bodyLarge: GoogleFonts.tiroBangla(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.65,
        color: baseColor,
      ),
      bodyMedium: GoogleFonts.tiroBangla(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.55,
        color: secondaryColor,
      ),
      bodySmall: GoogleFonts.hindSiliguri(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: secondaryColor,
      ),
    );
  }
}
