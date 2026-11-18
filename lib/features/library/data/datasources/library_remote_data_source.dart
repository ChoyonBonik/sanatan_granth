import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sanatan_granth/core/constants/app_constants.dart';
import 'package:sanatan_granth/core/error/exceptions.dart';
import 'package:sanatan_granth/features/library/domain/entities/book_entity.dart';
import '../models/book_model.dart';
import '../models/category_model.dart';

abstract class LibraryRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
  Future<List<BookModel>> getBooks({String? category, int limit = 20, int offset = 0});
  Future<List<BookModel>> getFeaturedBooks();
  Future<List<BookModel>> searchBooks(String query);
  Future<BookModel> getBookDetails(String id);
}

class LibraryRemoteDataSourceImpl implements LibraryRemoteDataSource {
  final SupabaseClient? _supabaseClient;

  LibraryRemoteDataSourceImpl({SupabaseClient? supabaseClient})
      : _supabaseClient = supabaseClient;

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      if (_supabaseClient != null) {
        final List<Map<String, dynamic>> response = await _supabaseClient
            .from(AppConstants.categoriesTable)
            .select()
            .order('name');
        if (response.isNotEmpty) {
          return response.map(CategoryModel.fromJson).toList();
        }
      }
      return _fallbackCategories;
    } catch (e) {
      // Fallback for offline or unconfigured Supabase
      return _fallbackCategories;
    }
  }

  @override
  Future<List<BookModel>> getBooks({String? category, int limit = 20, int offset = 0}) async {
    try {
      if (_supabaseClient != null) {
        var query = _supabaseClient.from(AppConstants.booksTable).select();
        if (category != null && category != 'All') {
          query = query.eq('category', category);
        }
        final List<Map<String, dynamic>> response =
            await query.range(offset, offset + limit - 1);
        if (response.isNotEmpty) {
          return response.map(BookModel.fromJson).toList();
        }
      }
      if (category != null && category != 'All') {
        return _canonicalBooks.where((BookModel b) => b.category == category).toList();
      }
      return _canonicalBooks;
    } catch (e) {
      if (category != null && category != 'All') {
        return _canonicalBooks.where((BookModel b) => b.category == category).toList();
      }
      return _canonicalBooks;
    }
  }

  @override
  Future<List<BookModel>> getFeaturedBooks() async {
    try {
      if (_supabaseClient != null) {
        final List<Map<String, dynamic>> response = await _supabaseClient
            .from(AppConstants.booksTable)
            .select()
            .eq('is_featured', true)
            .limit(10);
        if (response.isNotEmpty) {
          return response.map(BookModel.fromJson).toList();
        }
      }
      return _canonicalBooks.where((BookModel b) => b.isFeatured).toList();
    } catch (e) {
      return _canonicalBooks.where((BookModel b) => b.isFeatured).toList();
    }
  }

  @override
  Future<List<BookModel>> searchBooks(String query) async {
    final String q = query.toLowerCase().trim();
    if (q.isEmpty) return <BookModel>[];

    try {
      if (_supabaseClient != null) {
        final List<Map<String, dynamic>> response = await _supabaseClient
            .from(AppConstants.booksTable)
            .select()
            .ilike('title', '%$q%');
        if (response.isNotEmpty) {
          return response.map(BookModel.fromJson).toList();
        }
      }
      return _canonicalBooks.where((BookModel b) {
        return b.title.toLowerCase().contains(q) ||
            (b.sanskritTitle?.toLowerCase().contains(q) ?? false) ||
            b.author.toLowerCase().contains(q) ||
            b.category.toLowerCase().contains(q);
      }).toList();
    } catch (e) {
      return _canonicalBooks.where((BookModel b) {
        return b.title.toLowerCase().contains(q) ||
            (b.sanskritTitle?.toLowerCase().contains(q) ?? false) ||
            b.author.toLowerCase().contains(q);
      }).toList();
    }
  }

  @override
  Future<BookModel> getBookDetails(String id) async {
    try {
      if (_supabaseClient != null) {
        final Map<String, dynamic>? response = await _supabaseClient
            .from(AppConstants.booksTable)
            .select()
            .eq('id', id)
            .maybeSingle();
        if (response != null) {
          return BookModel.fromJson(response);
        }
      }
      final BookModel? found =
          _canonicalBooks.cast<BookModel?>().firstWhere(
                (BookModel? b) => b?.id == id,
                orElse: () => null,
              );
      if (found != null) return found;
      throw const ServerException(message: 'Book not found.');
    } catch (e) {
      final BookModel? found =
          _canonicalBooks.cast<BookModel?>().firstWhere(
                (BookModel? b) => b?.id == id,
                orElse: () => null,
              );
      if (found != null) return found;
      throw ServerException(message: e.toString());
    }
  }

  // Pre-loaded canonical Hindu scriptural books
  static final List<BookModel> _canonicalBooks = <BookModel>[
    const BookModel(
      id: 'gita-as-it-is',
      title: 'Srimad Bhagavad Gita',
      sanskritTitle: 'श्रीमद्भगवद्गीता',
      author: 'Sri Krishna Dvaipayana Vyasa',
      category: 'Bhagavad Gita',
      description:
          'The divine song spoken by Lord Sri Krishna to Arjuna on the battlefield of Kurukshetra. Contains 18 chapters and 700 verses expounding Karma, Jnana, and Bhakti Yoga.',
      language: 'Sanskrit / English / Bengali',
      totalVerses: 700,
      format: BookFormat.structured,
      isFeatured: true,
      rating: 5.0,
      viewsCount: 14500,
    ),
    const BookModel(
      id: 'isha-upanishad',
      title: 'Sri Isha Upanishad',
      sanskritTitle: 'ईशोपनिषद्',
      author: 'Vedic Rishis',
      category: 'Upanishads',
      description:
          'One of the foremost Mukhya Upanishads belonging to the Shukla Yajurveda. Deals with divine omnipresence, renunciation, and self-realization.',
      language: 'Sanskrit / English',
      totalVerses: 18,
      format: BookFormat.structured,
      isFeatured: true,
      rating: 4.9,
      viewsCount: 8200,
    ),
    const BookModel(
      id: 'katha-upanishad',
      title: 'Katha Upanishad',
      sanskritTitle: 'कठोपनिषद्',
      author: 'Vedic Rishis',
      category: 'Upanishads',
      description:
          'The legendary dialogue between Nachiketa and Yama Raja on the secrets of immortality, the soul (Atman), and the Supreme Reality.',
      language: 'Sanskrit / English',
      totalVerses: 119,
      format: BookFormat.structured,
      isFeatured: true,
      rating: 4.9,
      viewsCount: 6300,
    ),
    const BookModel(
      id: 'srimad-bhagavatam',
      title: 'Srimad Bhagavatam (Bhagavata Purana)',
      sanskritTitle: 'श्रीमद्भागवतम्',
      author: 'Srila Vyasadeva / Sukadeva Gosvami',
      category: 'Puranas & Itihasa',
      description:
          'The immaculate Purana (Amala Purana) celebrating the transcendental lilas and avatars of Sri Vishnu and Bhagavan Krishna.',
      language: 'Sanskrit / Bengali / English',
      totalVerses: 18000,
      format: BookFormat.structured,
      isFeatured: true,
      rating: 5.0,
      viewsCount: 22000,
    ),
    const BookModel(
      id: 'valmiki-ramayana',
      title: 'Valmiki Ramayana - Bala Kanda',
      sanskritTitle: 'वाल्मीकि रामायणम्',
      author: 'Maharshi Valmiki',
      category: 'Ramayana',
      description:
          'The Adi Kavya detailing the noble life, righteousness (Dharma), and virtues of Maryada Purushottama Sri Ramachandra.',
      language: 'Sanskrit / English',
      totalVerses: 2250,
      format: BookFormat.pdf,
      isFeatured: false,
      rating: 4.8,
      viewsCount: 9100,
    ),
  ];

  static final List<CategoryModel> _fallbackCategories = <CategoryModel>[
    const CategoryModel(
      id: 'all',
      name: 'All',
      sanskritName: 'सर्व',
      description: 'Entire library catalog',
      bookCount: 50,
    ),
    const CategoryModel(
      id: 'gita',
      name: 'Bhagavad Gita',
      sanskritName: 'श्रीमद्भगवद्गीता',
      description: 'Song of the Supreme Godhead',
      bookCount: 12,
    ),
    const CategoryModel(
      id: 'upanishads',
      name: 'Upanishads',
      sanskritName: 'उपनिषदः',
      description: 'Philosophical essence of the Vedas (Vedanta)',
      bookCount: 108,
    ),
    const CategoryModel(
      id: 'vedas',
      name: 'Vedas & Samhitas',
      sanskritName: 'वेदाः',
      description: 'Rig, Sama, Yajur, and Atharva Samhitas',
      bookCount: 24,
    ),
    const CategoryModel(
      id: 'puranas',
      name: 'Puranas & Itihasa',
      sanskritName: 'पुराणेतिहास',
      description: '18 Maha Puranas, Upa Puranas, and chronicles',
      bookCount: 36,
    ),
  ];
}
