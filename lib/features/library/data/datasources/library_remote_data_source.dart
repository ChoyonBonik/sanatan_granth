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
          query = query.eq('category', category);
        }
        final List<Map<String, dynamic>> response =
            await query.range(offset, offset + limit - 1);
        if (response.isNotEmpty) {
          return response.map(BookModel.fromJson).toList();
        }
      }
      if (category != null && category != 'সকল গ্রন্থ' && category != 'All') {
        return _canonicalBooks.where((BookModel b) => b.category == category).toList();
      }
      return _canonicalBooks;
    } catch (_) {
      if (category != null && category != 'সকল গ্রন্থ' && category != 'All') {
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
    } catch (_) {
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
    } catch (_) {
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
      throw const ServerException(message: 'গ্রন্থটি খুঁজে পাওয়া যায়নি।');
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

  // প্রামাণ্য শাস্ত্রীয় গ্রন্থসমূহ (বাংলায় অনূদিত ও সুবিন্যস্ত)
  static final List<BookModel> _canonicalBooks = <BookModel>[
    const BookModel(
      id: 'gita-as-it-is',
      title: 'শ্রীমদ্ভগবদ্গীতা যথার্থরূপ',
      sanskritTitle: 'শ্রীমদ্ভগবদ্গীতা',
      author: 'শ্রীকৃষ্ণদ্বৈপায়ন বেদব্যাস',
      category: 'শ্রীমদ্ভগবদ্গীতা',
      description:
          'কুরুক্ষেত্রের পুণ্য ধর্মক্ষেত্রে পরমেশ্বর ভগবান শ্রীকৃষ্ণের মুখপদ্ম থেকে অর্জুনের প্রতি উচ্চারিত পরম তত্ত্ববাণী। এতে ১৮টি অধ্যায় ও ৭০০টি শ্লোকের মাধ্যমে কর্মযোগ, জ্ঞানযোগ ও পরম ভক্তিযোগের সারকথা প্রাঞ্জলভাবে বর্ণিত হয়েছে।',
      language: 'সংস্কৃত ও বঙ্গানুবাদ',
      totalVerses: 700,
      format: BookFormat.structured,
      isFeatured: true,
      rating: 5.0,
      viewsCount: 18500,
    ),
    const BookModel(
      id: 'isha-upanishad',
      title: 'শ্রী ঈশোপনিষদ',
      sanskritTitle: 'ঈশোপনিষদ্',
      author: 'বৈদিক ঋষিবৃন্দ',
      category: 'উপনিষদ',
      description:
          'শুক্ল যজুর্বেদের অন্তর্গত ১০৮টি উপনিষদের মধ্যমণি। এই উপনিষদে ঈশ্বরের সর্বব্যাপক সত্য, ত্যাগের মাধ্যমে ভোগ এবং পরমাত্মার অনুভূতি অত্যন্ত প্রজ্ঞার সাথে তুলে ধরা হয়েছে।',
      language: 'সংস্কৃত ও বঙ্গানুবাদ',
      totalVerses: 18,
      format: BookFormat.structured,
      isFeatured: true,
      rating: 4.9,
      viewsCount: 9200,
    ),
    const BookModel(
      id: 'katha-upanishad',
      title: 'কঠোপনিষদ',
      sanskritTitle: 'কঠোপনিষদ্',
      author: 'বৈদিক ঋষিবৃন্দ',
      category: 'উপনিষদ',
      description:
          'ধর্মরাজ যম এবং বালক নচিকেতার মধ্যবর্তী পরম অমরত্ব, জন্ম-মৃত্যু রহস্য এবং অবিনশ্বর আত্মার স্বরূপ বিষয়ক গভীর আধ্যাত্মিক কথোপকথন।',
      language: 'সংস্কৃত ও বঙ্গানুবাদ',
      totalVerses: 119,
      format: BookFormat.structured,
      isFeatured: true,
      rating: 4.9,
      viewsCount: 7400,
    ),
    const BookModel(
      id: 'srimad-bhagavatam',
      title: 'শ্রীমদ্ভাগবতম্ (ভাগবত পুরাণ)',
      sanskritTitle: 'শ্রীমদ্ভাগবতম্',
      author: 'শ্রীল বেদব্যাস ও শুকদেব গোস্বামী',
      category: 'শ্রীমদ্ভাগবতম্',
      description:
          'অমল পুরাণ নামে খ্যাত বৈদিক সাহিত্যের অন্যতম শ্রেষ্ঠ চূড়ামণি। দ্বাদশ স্কন্ধে বিভক্ত এই মহাপুরাণে ভগবান শ্রীকৃষ্ণের লীলামৃত ও ভক্তিবেদান্ত তত্ত্ব পরিবেশিত হয়েছে।',
      language: 'সংস্কৃত ও বঙ্গানুবাদ',
      totalVerses: 18000,
      format: BookFormat.structured,
      isFeatured: true,
      rating: 5.0,
      viewsCount: 25000,
    ),
    const BookModel(
      id: 'chaitanya-charitamrita',
      title: 'শ্রীচৈতন্যচরিতামৃত',
      sanskritTitle: 'শ্রীচৈতন্যচরিতামৃত',
      author: 'শ্রীল কৃষ্ণদাস কবিরাজ গোস্বামী',
      category: 'শ্রীচৈতন্যচরিতামৃত',
      description:
          'কলিযুগপাবনাবতার পরম করুণাময় শ্রীকৃষ্ণচৈতন্য মহাপ্রভুর পুণ্য দিব্যলীলা, গৌড়ীয় বৈষ্ণব দর্শন ও রাধাকৃষ্ণ প্রেমতত্ত্বের অমৃতময় অমূল্য আকরগ্রন্থ।',
      language: 'বাংলা পয়ার ও ত্রিপদী',
      totalVerses: 11500,
      format: BookFormat.structured,
      isFeatured: true,
      rating: 5.0,
      viewsCount: 16800,
    ),
    const BookModel(
      id: 'valmiki-ramayana',
      title: 'বাল্মীকি রামায়ণ — আদিকাণ্ড',
      sanskritTitle: 'বাল্মীকি রামায়ণ',
      author: 'মহর্ষি বাল্মীকি',
      category: 'রামায়ণ',
      description:
          'আদিকবি মহর্ষি বাল্মীকি প্রণীত আদি মহাকাব্য। মর্যাদা পুরুষোত্তম ভগবান শ্রীরামচন্দ্রের ধর্মনিষ্ঠ জীবন, সীতার পাতিব্রত্য ও লক্ষ্মণ-ভরতের আদর্শ ভ্রাতৃপ্রেমের কাহিনী।',
      language: 'সংস্কৃত ও বঙ্গানুবাদ',
      totalVerses: 2250,
      format: BookFormat.pdf,
      isFeatured: false,
      rating: 4.8,
      viewsCount: 11200,
    ),
  ];

  static final List<CategoryModel> _fallbackCategories = <CategoryModel>[
    const CategoryModel(
      id: 'all',
      name: 'সকল গ্রন্থ',
      sanskritName: 'সর্বশাস্ত্র',
      description: 'গ্রন্থাগারের সমস্ত পবিত্র শাস্ত্রাবলী',
      bookCount: 65,
    ),
    const CategoryModel(
      id: 'gita',
      name: 'শ্রীমদ্ভগবদ্গীতা',
      sanskritName: 'গীতোপনিষদ',
      description: 'ভগবান শ্রীকৃষ্ণের মুখনিঃসৃত অমৃতবাণী',
      bookCount: 15,
    ),
    const CategoryModel(
      id: 'upanishads',
      name: 'উপনিষদ',
      sanskritName: 'উপনিষদাবলী',
      description: 'বেদের জ্ঞানকাণ্ড ও বেদান্ত দর্শন',
      bookCount: 108,
    ),
    const CategoryModel(
      id: 'bhagavatam',
      name: 'শ্রীমদ্ভাগবতম্',
      sanskritName: 'ভাগবত পুরাণ',
      description: 'প্রেমভক্তির পরম শাস্ত্র',
      bookCount: 12,
    ),
    const CategoryModel(
      id: 'vedas',
      name: 'বেদ ও সংহিতা',
      sanskritName: 'চতুর্বেদ',
      description: 'ঋক, সাম, যজুঃ ও অথর্ববেদ সংহিতা',
      bookCount: 24,
    ),
    const CategoryModel(
      id: 'puranas',
      name: 'পুরাণ ও ইতিহাস',
      sanskritName: 'পুরাণেতিহাস',
      description: '১৮টি মহাপুরাণ ও ইতিহাস গ্রন্থাবলী',
      bookCount: 36,
    ),
  ];
}
