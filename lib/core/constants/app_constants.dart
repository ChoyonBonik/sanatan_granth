/// Application-wide constants, Supabase configurations, and scriptural metadata.
class AppConstants {
  AppConstants._();

  static const String appName = 'Sanatan Granth';
  static const String appTagline = 'Sacred Wisdom, Eternal Truths';

  // Supabase Configuration (Placeholder - configure via environment / secrets)
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

  // Primary Canonical Categories
  static const List<String> canonicalCategories = <String>[
    'All',
    'Vedas & Samhitas',
    'Upanishads',
    'Bhagavad Gita',
    'Puranas & Itihasa',
    'Ramayana',
    'Mahabharata',
    'Darshana & Vedanta',
    'Stotras & Suktams',
    'Chaitanya Charitamrita',
  ];
}
