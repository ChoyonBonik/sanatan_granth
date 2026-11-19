/// Application-wide constants, Supabase configurations, and scriptural metadata.
class AppConstants {
  AppConstants._();

  static const String appName = 'সনাতন গ্রন্থ';
  static const String appTagline = 'শাশ্বত বৈদিক জ্ঞান ও অমূল্য শাস্ত্র ভাণ্ডার';

  // Supabase Configuration (Configure via environment / secrets)
  static const String supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://placeholder-project.supabase.co',
  );
  static const String supabaseAnonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: 'placeholder-anon-key',
  );

  // Supabase Storage Buckets
  static const String booksBucket = 'books';
  static const String audioBucket = 'audiobooks';
  static const String contributionsBucket = 'contributions';

  // Database Tables
  static const String usersTable = 'profiles';
  static const String booksTable = 'books';
  static const String categoriesTable = 'categories';
  static const String versesTable = 'verses';
  static const String contributionsTable = 'contributions';

  // Primary Canonical Categories in Bengali
  static const List<String> canonicalCategories = <String>[
    'সকল গ্রন্থ',
    'শ্রীমদ্ভগবদ্গীতা',
    'উপনিষদ',
    'শ্রীমদ্ভাগবতম্',
    'বেদ ও সংহিতা',
    'পুরাণ ও ইতিহাস',
    'রামায়ণ',
    'মহাভারত',
    'দর্শন ও বেদান্ত',
    'স্তোত্র ও সূক্তাবলী',
    'শ্রীচৈতন্যচরিতামৃত',
  ];
}
