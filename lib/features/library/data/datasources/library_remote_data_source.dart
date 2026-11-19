import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sanatan_granth/core/constants/app_constants.dart';
import 'package:sanatan_granth/core/error/exceptions.dart';
import 'package:sanatan_granth/features/library/domain/entities/book_entity.dart';
import '../models/book_model.dart';
import '../models/category_model.dart';
import '../models/chapter_model.dart';
import '../models/reading_progress_model.dart';

abstract class LibraryRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
  Future<List<BookModel>> getBooks({String? category, int limit = 20, int offset = 0});
  Future<List<BookModel>> getFeaturedBooks();
  Future<List<BookModel>> searchBooks(String query, {String? language, BookFormatType? format});
  Future<BookModel> getBookDetails(String id);
  Future<List<ChapterModel>> getChapters(String bookId);
  Future<ReadingProgressModel?> getReadingProgress(String userId);
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
    } catch (_) {
      return _fallbackCategories;
    }
  }

  @override
  Future<List<BookModel>> getBooks({String? category, int limit = 20, int offset = 0}) async {
    try {
      if (_supabaseClient != null) {
        var query = _supabaseClient.from(AppConstants.booksTable).select();
        if (category != null && category != 'সকল গ্রন্থ' && category != 'All') {
          query = query.or('category.eq.$category,category_type.eq.${category.toLowerCase()}');
        }
        final List<Map<String, dynamic>> response =
            await query.range(offset, offset + limit - 1);
        if (response.isNotEmpty) {
          return response.map(BookModel.fromJson).toList();
        }
      }
      return _filterBooksByCategory(_canonicalBooks, category);
    } catch (_) {
      return _filterBooksByCategory(_canonicalBooks, category);
    }
  }

  List<BookModel> _filterBooksByCategory(List<BookModel> books, String? category) {
    if (category == null || category == 'All' || category == 'সকল গ্রন্থ') {
      return books;
    }
    final String catLower = category.toLowerCase().trim();
    return books.where((BookModel b) {
      final String bCat = b.category.toLowerCase().trim();
      final String bType = b.categoryType.value.toLowerCase().trim();
      return bCat.contains(catLower) || catLower.contains(bCat) || bType.contains(catLower);
    }).toList();
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
    } catch (_) {
      return _canonicalBooks.where((BookModel b) => b.isFeatured).toList();
    }
  }

  @override
  Future<List<BookModel>> searchBooks(
    String query, {
    String? language,
    BookFormatType? format,
  }) async {
    final String q = query.toLowerCase().trim();
    try {
      List<BookModel> results = _canonicalBooks;
      if (_supabaseClient != null && q.isNotEmpty) {
        final List<Map<String, dynamic>> response = await _supabaseClient
            .from(AppConstants.booksTable)
            .select()
            .ilike('title', '%$q%');
        if (response.isNotEmpty) {
          results = response.map(BookModel.fromJson).toList();
        }
      }

      if (q.isNotEmpty) {
        results = results.where((BookModel b) {
          final bool matchMeta = b.title.toLowerCase().contains(q) ||
              (b.sanskritTitle?.toLowerCase().contains(q) ?? false) ||
              b.author.toLowerCase().contains(q) ||
              b.category.toLowerCase().contains(q) ||
              b.description.toLowerCase().contains(q);
          
          // Also check verse keywords
          final bool matchVerse = _sampleVerseTextMatches(b.id, q);
          return matchMeta || matchVerse;
        }).toList();
      }

      // Language filter
      if (language != null && language != 'All' && language.isNotEmpty) {
        final String langLower = language.toLowerCase();
        results = results.where((BookModel b) {
          return b.language.toLowerCase().contains(langLower);
        }).toList();
      }

      // Format filter
      if (format != null) {
        results = results.where((BookModel b) => b.format == format).toList();
      }

      return results;
    } catch (_) {
      List<BookModel> results = _canonicalBooks;
      if (q.isNotEmpty) {
        results = results.where((BookModel b) {
          return b.title.toLowerCase().contains(q) ||
              (b.sanskritTitle?.toLowerCase().contains(q) ?? false) ||
              b.author.toLowerCase().contains(q) ||
              _sampleVerseTextMatches(b.id, q);
        }).toList();
      }
      if (format != null) {
        results = results.where((BookModel b) => b.format == format).toList();
      }
      return results;
    }
  }

  bool _sampleVerseTextMatches(String bookId, String query) {
    final String q = query.toLowerCase();
    // Keywords from Bhagavad Gita / scriptures
    if (bookId == 'gita-as-it-is') {
      const List<String> gitaKeywords = <String>[
        'ধর্মক্ষেত্রে', 'কুরুক্ষেত্রে', 'সমবেতা', 'মামকাঃ', 'পাণ্ডবাশ্চৈব',
        'কর্মণ্যেবাধিকারস্তে', 'মা ফলেষু', 'সাংখ্য', 'অর্জুন', 'শ্রীকৃষ্ণ',
        'duty', 'soul', 'karma', 'krishna', 'arjuna', 'yoga'
      ];
      return gitaKeywords.any((String k) => k.contains(q) || q.contains(k));
    }
    if (bookId == 'isha-upanishad') {
      const List<String> ishaKeywords = <String>[
        'ঈশা বাস্যমিদং', 'সর্বং', 'জগৎ', 'ত্যাগময়', 'উপনিষদ', 'ঈশ্বর'
      ];
      return ishaKeywords.any((String k) => k.contains(q) || q.contains(k));
    }
    return false;
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
      throw const ServerException(message: 'Scripture book not found.');
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

  @override
  Future<List<ChapterModel>> getChapters(String bookId) async {
    try {
      if (_supabaseClient != null) {
        final List<Map<String, dynamic>> response = await _supabaseClient
            .from('chapters')
            .select()
            .eq('book_id', bookId)
            .order('chapter_number');
        if (response.isNotEmpty) {
          return response.map(ChapterModel.fromJson).toList();
        }
      }
      return _canonicalChapters[bookId] ?? _defaultGitaChapters;
    } catch (_) {
      return _canonicalChapters[bookId] ?? _defaultGitaChapters;
    }
  }

  @override
  Future<ReadingProgressModel?> getReadingProgress(String userId) async {
    try {
      if (_supabaseClient != null) {
        final Map<String, dynamic>? response = await _supabaseClient
            .from('reading_progress')
            .select()
            .eq('user_id', userId)
            .order('updated_at', ascending: false)
            .limit(1)
            .maybeSingle();
        if (response != null) {
          return ReadingProgressModel.fromJson(response);
        }
      }
      return _defaultReadingProgress;
    } catch (_) {
      return _defaultReadingProgress;
    }
  }

  static final ReadingProgressModel _defaultReadingProgress = ReadingProgressModel(
    id: 'prog-gita-default',
    userId: 'default_user',
    bookId: 'gita-as-it-is',
    chapterId: 'gita-ch-1',
    lastVerseOrPage: 5,
    audioPositionMs: 145000,
    updatedAt: DateTime.now(),
  );

  // Canonical scripture books in Bengali
  static final List<BookModel> _canonicalBooks = <BookModel>[
    const BookModel(
      id: 'gita-as-it-is',
      title: 'শ্রীমদ্ভগবদ্গীতা যথার্থরূপ',
      sanskritTitle: 'শ্রীমদ্ভগবদ্গীতা',
      author: 'শ্রীকৃষ্ণদ্বৈপায়ন বেদব্যাস',
      category: 'Gita',
      categoryType: BookCategory.gita,
      description:
          'কুরুক্ষেত্রের পুণ্য ধর্মক্ষেত্রে পরমেশ্বর ভগবান শ্রীকৃষ্ণের মুখপদ্ম থেকে অর্জুনের প্রতি উচ্চারিত পরম তত্ত্ববাণী। এতে ১৮টি অধ্যায় ও ৭০০টি শ্লোকের মাধ্যমে কর্মযোগ, জ্ঞানযোগ ও পরম ভক্তিযোগের সারকথা প্রাঞ্জলভাবে বর্ণিত হয়েছে।',
      language: 'Sanskrit & Bengali',
      totalVerses: 700,
      format: BookFormat.structured,
      isFeatured: true,
      rating: 5.0,
      viewsCount: 18500,
      contributorId: 'Sanatan Dharma Seva Academy',
    ),
    const BookModel(
      id: 'isha-upanishad',
      title: 'শ্রী ঈশোপনিষদ',
      sanskritTitle: 'ঈশোপনিষদ্',
      author: 'মহর্ষি যাজ্ঞবল্ক্য ও বৈদিক ঋষিবৃন্দ',
      category: 'Upanishads',
      categoryType: BookCategory.upanishad,
      description:
          'শুক্ল যজুর্বেদের অন্তর্গত ১০৮টি উপনিষদের মধ্যমণি। এই উপনিষদে ঈশ্বরের সর্বব্যাপক সত্য, ত্যাগের মাধ্যমে ভোগ এবং পরমাত্মার অনুভূতি অত্যন্ত প্রজ্ঞার সাথে তুলে ধরা হয়েছে।',
      language: 'Sanskrit & Bengali',
      totalVerses: 18,
      format: BookFormat.structured,
      isFeatured: true,
      rating: 4.9,
      viewsCount: 9200,
      contributorId: 'Vedic Research Foundation',
    ),
    const BookModel(
      id: 'katha-upanishad',
      title: 'কঠোপনিষদ',
      sanskritTitle: 'কঠোপনিষদ্',
      author: 'বৈদিক ঋষিবৃন্দ',
      category: 'Upanishads',
      categoryType: BookCategory.upanishad,
      description:
          'ধর্মরাজ যম এবং বালক নচিকেতার মধ্যবর্তী পরম অমরত্ব, জন্ম-মৃত্যু রহস্য এবং অবিনশ্বর আত্মার স্বরূপ বিষয়ক গভীর আধ্যাত্মিক কথোপকথন।',
      language: 'Sanskrit & Bengali',
      totalVerses: 119,
      format: BookFormat.structured,
      isFeatured: true,
      rating: 4.9,
      viewsCount: 7400,
      contributorId: 'Sanatan Dharma Seva Academy',
    ),
    const BookModel(
      id: 'rigveda-samhita',
      title: 'ঋগ্বেদ সংহিতা — সূক্তমালা',
      sanskritTitle: 'ऋग्वेदसंहिता',
      author: 'মহর্ষি ব্যাসদেব ও সপ্তর্ষিবৃন্দ',
      category: 'Vedas',
      categoryType: BookCategory.veda,
      description:
          'মানব সভ্যতার প্রাচীনতম পরম জ্ঞানালোক। অগ্নি, ইন্দ্র, বরুণ প্রমুখ দেবতাদের প্রতি ঋষিগণের পুণ্য স্তোত্র, গায়ত্রী ছন্দ ও পরম ব্রহ্মদর্শন।',
      language: 'Sanskrit & Bengali',
      totalVerses: 10552,
      format: BookFormat.pdf,
      isFeatured: true,
      rating: 5.0,
      viewsCount: 14200,
      contributorId: 'Vedic Heritage Trust',
    ),
    const BookModel(
      id: 'srimad-bhagavatam',
      title: 'শ্রীমদ্ভাগবতম্ (ভাগবত পুরাণ)',
      sanskritTitle: 'শ্রীমদ্ভাগবতম্',
      author: 'শ্রীল বেদব্যাস ও শুকদেব গোস্বামী',
      category: 'Puranas',
      categoryType: BookCategory.purana,
      description:
          'অমল পুরাণ নামে খ্যাত বৈদিক সাহিত্যের অন্যতম শ্রেষ্ঠ চূড়ামণি। দ্বাদশ স্কন্ধে বিভক্ত এই মহাপুরাণে ভগবান শ্রীকৃষ্ণের লীলামৃত ও ভক্তিবেদান্ত তত্ত্ব পরিবেশিত হয়েছে।',
      language: 'Sanskrit & Bengali',
      totalVerses: 18000,
      format: BookFormat.structured,
      isFeatured: true,
      rating: 5.0,
      viewsCount: 25000,
      contributorId: 'Gaudiya Vedavyasa Mandir',
    ),
    const BookModel(
      id: 'valmiki-ramayana',
      title: 'বাল্মীকি রামায়ণ — আদিকাণ্ড',
      sanskritTitle: 'বাল্মীকি রামায়ণ',
      author: 'আদিকবি মহর্ষি বাল্মীকি',
      category: 'Itihasa',
      categoryType: BookCategory.itihasa,
      description:
          'আদিকবি মহর্ষি বাল্মীকি প্রণীত আদি মহাকাব্য। মর্যাদা পুরুষোত্তম ভগবান শ্রীরামচন্দ্রের ধর্মনিষ্ঠ জীবন, সীতার পাতিব্রত্য ও লক্ষ্মণ-ভরতের আদর্শ ভ্রাতৃপ্রেমের কাহিনী।',
      language: 'Sanskrit & Bengali',
      totalVerses: 2250,
      format: BookFormat.pdf,
      isFeatured: false,
      rating: 4.8,
      viewsCount: 11200,
      contributorId: 'Sanatan Dharma Seva Academy',
    ),
    const BookModel(
      id: 'sri-vishnu-sahasranama',
      title: 'শ্রীবিষ্ণুসহস্রনাম স্তোত্রম্',
      sanskritTitle: 'শ্রীবিষ্ণুসহস্রনাম',
      author: 'পিতামহ ভীষ্ম ও মহর্ষি কৃষ্ণদ্বৈপায়ন ব্যাস',
      category: 'Stotras',
      categoryType: BookCategory.stotra,
      description:
          'মহাভারতের অনুশাসনপর্বের অন্তর্গত পরম পরিত্রাণকারী স্তোত্র। শরশয্যাশায়ী পিতামহ ভীষ্মের মুখনিঃসৃত পরমেশ্বর নারায়ণের দিব্য এক সহস্র মঙ্গলময় নাম।',
      language: 'Sanskrit & Bengali',
      totalVerses: 108,
      format: BookFormat.structured,
      isFeatured: true,
      rating: 5.0,
      viewsCount: 15300,
      contributorId: 'Sanatan Devotees Union',
    ),
  ];

  static final List<CategoryModel> _fallbackCategories = <CategoryModel>[
    const CategoryModel(
      id: 'all',
      name: 'All',
      sanskritName: 'সর্বশাস্ত্র',
      description: 'Complete repository of sacred scriptures',
      bookCount: 65,
    ),
    const CategoryModel(
      id: 'gita',
      name: 'Gita',
      sanskritName: 'গীতোপনিষদ',
      description: 'Divine teachings of Lord Krishna',
      bookCount: 18,
    ),
    const CategoryModel(
      id: 'upanishads',
      name: 'Upanishads',
      sanskritName: 'উপনিষদাবলী',
      description: 'Philosophical essence of the Vedas',
      bookCount: 108,
    ),
    const CategoryModel(
      id: 'vedas',
      name: 'Vedas',
      sanskritName: 'চতুর্বেদ ও সংহিতা',
      description: 'Rig, Sama, Yajur, and Atharva Veda',
      bookCount: 24,
    ),
    const CategoryModel(
      id: 'puranas',
      name: 'Puranas',
      sanskritName: 'মহাপুরাণ',
      description: 'The 18 Great Mahapuranas and Upapuranas',
      bookCount: 18,
    ),
    const CategoryModel(
      id: 'itihasa',
      name: 'Itihasa',
      sanskritName: 'ইতিহাস — রামায়ণ ও মহাভারত',
      description: 'The great historical epics of Sanatan Dharma',
      bookCount: 12,
    ),
    const CategoryModel(
      id: 'stotras',
      name: 'Stotras',
      sanskritName: 'স্তোত্র ও স্তুতি',
      description: 'Sacred hymns, mantras, and invocations',
      bookCount: 42,
    ),
  ];

  static final List<ChapterModel> _defaultGitaChapters = <ChapterModel>[
    const ChapterModel(
      id: 'gita-ch-1',
      bookId: 'gita-as-it-is',
      chapterNumber: 1,
      title: 'প্রথম অধ্যায় — অর্জুনবিষাদ যোগ',
      durationSeconds: 1620,
    ),
    const ChapterModel(
      id: 'gita-ch-2',
      bookId: 'gita-as-it-is',
      chapterNumber: 2,
      title: 'দ্বিতীয় অধ্যায় — সাংখ্য যোগ',
      durationSeconds: 2400,
    ),
    const ChapterModel(
      id: 'gita-ch-3',
      bookId: 'gita-as-it-is',
      chapterNumber: 3,
      title: 'তৃতীয় অধ্যায় — কর্ম যোগ',
      durationSeconds: 1560,
    ),
    const ChapterModel(
      id: 'gita-ch-4',
      bookId: 'gita-as-it-is',
      chapterNumber: 4,
      title: 'চতুর্থ অধ্যায় — জ্ঞান যোগ',
      durationSeconds: 1500,
    ),
    const ChapterModel(
      id: 'gita-ch-5',
      bookId: 'gita-as-it-is',
      chapterNumber: 5,
      title: 'পঞ্চম অধ্যায় — কর্মসন্ন্যাস যোগ',
      durationSeconds: 1140,
    ),
    const ChapterModel(
      id: 'gita-ch-6',
      bookId: 'gita-as-it-is',
      chapterNumber: 6,
      title: 'ষষ্ঠ অধ্যায় — ধ্যান যোগ',
      durationSeconds: 1680,
    ),
    const ChapterModel(
      id: 'gita-ch-7',
      bookId: 'gita-as-it-is',
      chapterNumber: 7,
      title: 'সপ্তম অধ্যায় — জ্ঞানবিজ্ঞান যোগ',
      durationSeconds: 1260,
    ),
    const ChapterModel(
      id: 'gita-ch-8',
      bookId: 'gita-as-it-is',
      chapterNumber: 8,
      title: 'অষ্টম অধ্যায় — অক্ষরব্রহ্ম যোগ',
      durationSeconds: 1200,
    ),
    const ChapterModel(
      id: 'gita-ch-9',
      bookId: 'gita-as-it-is',
      chapterNumber: 9,
      title: 'নবম অধ্যায় — রাজগুহ্য যোগ',
      durationSeconds: 1380,
    ),
    const ChapterModel(
      id: 'gita-ch-10',
      bookId: 'gita-as-it-is',
      chapterNumber: 10,
      title: 'দশম অধ্যায় — বিভূতি যোগ',
      durationSeconds: 1620,
    ),
    const ChapterModel(
      id: 'gita-ch-11',
      bookId: 'gita-as-it-is',
      chapterNumber: 11,
      title: 'একাদশ অধ্যায় — বিশ্বরূপদর্শন যোগ',
      durationSeconds: 2100,
    ),
    const ChapterModel(
      id: 'gita-ch-12',
      bookId: 'gita-as-it-is',
      chapterNumber: 12,
      title: 'দ্বাদশ অধ্যায় — ভক্তি যোগ',
      durationSeconds: 840,
    ),
    const ChapterModel(
      id: 'gita-ch-13',
      bookId: 'gita-as-it-is',
      chapterNumber: 13,
      title: 'ত্রয়োদশ অধ্যায় — ক্ষেত্র-ক্ষেত্রজ্ঞ বিভাগ যোগ',
      durationSeconds: 1320,
    ),
    const ChapterModel(
      id: 'gita-ch-14',
      bookId: 'gita-as-it-is',
      chapterNumber: 14,
      title: 'চতুর্দশ অধ্যায় — গুণত্রয়বিভাগ যোগ',
      durationSeconds: 1140,
    ),
    const ChapterModel(
      id: 'gita-ch-15',
      bookId: 'gita-as-it-is',
      chapterNumber: 15,
      title: 'পঞ্চদশ অধ্যায় — পুরুষোত্তম যোগ',
      durationSeconds: 900,
    ),
    const ChapterModel(
      id: 'gita-ch-16',
      bookId: 'gita-as-it-is',
      chapterNumber: 16,
      title: 'ষোড়শ অধ্যায় — দৈবাসুরসম্পদ্বিভাগ যোগ',
      durationSeconds: 960,
    ),
    const ChapterModel(
      id: 'gita-ch-17',
      bookId: 'gita-as-it-is',
      chapterNumber: 17,
      title: 'সপ্তদশ অধ্যায় — শ্রদ্ধাত্রয়বিভাগ যোগ',
      durationSeconds: 1080,
    ),
    const ChapterModel(
      id: 'gita-ch-18',
      bookId: 'gita-as-it-is',
      chapterNumber: 18,
      title: 'অষ্টাদশ অধ্যায় — মোক্ষসন্ন্যাস যোগ',
      durationSeconds: 2880,
    ),
  ];

  static final Map<String, List<ChapterModel>> _canonicalChapters = <String, List<ChapterModel>>{
    'gita-as-it-is': _defaultGitaChapters,
    'isha-upanishad': const <ChapterModel>[
      ChapterModel(
        id: 'isha-ch-1',
        bookId: 'isha-upanishad',
        chapterNumber: 1,
        title: 'শ্রী ঈশোপনিষদ — পূর্ণমদঃ ও ১৮টি মূল মন্ত্র',
        durationSeconds: 900,
      ),
    ],
    'katha-upanishad': const <ChapterModel>[
      ChapterModel(
        id: 'katha-ch-1',
        bookId: 'katha-upanishad',
        chapterNumber: 1,
        title: 'প্রথম বল্লী — নচিকেতা ও যমরাজ সংবাদ',
        durationSeconds: 1200,
      ),
      ChapterModel(
        id: 'katha-ch-2',
        bookId: 'katha-upanishad',
        chapterNumber: 2,
        title: 'দ্বিতীয় বল্লী — পরব্রহ্ম ও অমর আত্মার স্বরূপ',
        durationSeconds: 1350,
      ),
    ],
    'rigveda-samhita': const <ChapterModel>[
      ChapterModel(
        id: 'rig-ch-1',
        bookId: 'rigveda-samhita',
        chapterNumber: 1,
        title: 'প্রথম মণ্ডল — অগ্নিমীলে পুরোহিতং (অগ্নি সূক্ত)',
        durationSeconds: 1800,
      ),
      ChapterModel(
        id: 'rig-ch-2',
        bookId: 'rigveda-samhita',
        chapterNumber: 2,
        title: 'দশম মণ্ডল — নাসদীয় সূক্ত ও পুরুষ সূক্ত',
        durationSeconds: 2100,
      ),
    ],
    'srimad-bhagavatam': const <ChapterModel>[
      ChapterModel(
        id: 'sb-c1',
        bookId: 'srimad-bhagavatam',
        chapterNumber: 1,
        title: 'প্রথম স্কন্ধ — সৃষ্টি রহস্য ও নৈমিষারণ্যে ঋষি সম্মেলন',
        durationSeconds: 3200,
      ),
      ChapterModel(
        id: 'sb-c2',
        bookId: 'srimad-bhagavatam',
        chapterNumber: 2,
        title: 'দ্বিতীয় স্কন্ধ — মহাপুরুষের বিরাট রূপ ও ধ্যান',
        durationSeconds: 2800,
      ),
    ],
    'valmiki-ramayana': const <ChapterModel>[
      ChapterModel(
        id: 'ram-c1',
        bookId: 'valmiki-ramayana',
        chapterNumber: 1,
        title: 'বালকাণ্ড — শ্রীরামের জন্ম ও তারকাবধ',
        durationSeconds: 2400,
      ),
      ChapterModel(
        id: 'ram-c2',
        bookId: 'valmiki-ramayana',
        chapterNumber: 2,
        title: 'অযোধ্যাকাণ্ড — রামের পিতৃসত্য পালন ও বনগমন',
        durationSeconds: 2700,
      ),
    ],
    'sri-vishnu-sahasranama': const <ChapterModel>[
      ChapterModel(
        id: 'vsn-c1',
        bookId: 'sri-vishnu-sahasranama',
        chapterNumber: 1,
        title: 'পূর্বপীঠিকা — যুধিষ্ঠির ভীষ্ম সংবাদ ও ধ্যানম্',
        durationSeconds: 600,
      ),
      ChapterModel(
        id: 'vsn-c2',
        bookId: 'sri-vishnu-sahasranama',
        chapterNumber: 2,
        title: 'মূল স্তোত্রম্ — পরমেশ্বর নারায়ণের এক সহস্র নাম',
        durationSeconds: 2100,
      ),
      ChapterModel(
        id: 'vsn-c3',
        bookId: 'sri-vishnu-sahasranama',
        chapterNumber: 3,
        title: 'উত্তরপীঠিকা — ফলশ্রুতি ও মঙ্গল শ্লোক',
        durationSeconds: 720,
      ),
    ],
  };
}
