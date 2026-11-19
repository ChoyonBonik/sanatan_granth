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

  // Canonical scripture books in Bengali (uploaded / curated books)
  static final List<BookModel> _canonicalBooks = <BookModel>[
    const BookModel(
      id: 'gita-as-it-is',
      title: 'শ্রীমদ্ভগবদ্গীতা যথার্থরূপ',
      sanskritTitle: 'শ্রীমদ্ভগবদ্গীতা',
      author: 'শ্রীকৃষ্ণদ্বৈপায়ন বেদব্যাস',
      category: 'Bhagavad Gita',
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
      category: 'Upanishads',
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
      category: 'Upanishads',
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
      category: 'Srimad Bhagavatam',
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
      category: 'Chaitanya Charitamrita',
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
      category: 'Ramayana',
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
      name: 'All',
      sanskritName: 'সর্বশাস্ত্র',
      description: 'Complete repository of sacred scriptures',
      bookCount: 65,
    ),
    const CategoryModel(
      id: 'gita',
      name: 'Bhagavad Gita',
      sanskritName: 'গীতোপনিষদ',
      description: 'Divine teachings of Lord Krishna',
      bookCount: 15,
    ),
    const CategoryModel(
      id: 'upanishads',
      name: 'Upanishads',
      sanskritName: 'উপনিষদাবলী',
      description: 'Philosophical essence of the Vedas',
      bookCount: 108,
    ),
    const CategoryModel(
      id: 'bhagavatam',
      name: 'Srimad Bhagavatam',
      sanskritName: 'ভাগবত পুরাণ',
      description: 'The immaculate scripture of pure devotion',
      bookCount: 12,
    ),
    const CategoryModel(
      id: 'vedas',
      name: 'Vedas & Samhitas',
      sanskritName: 'চতুর্বেদ',
      description: 'Rig, Sama, Yajur, and Atharva Veda',
      bookCount: 24,
    ),
    const CategoryModel(
      id: 'puranas',
      name: 'Puranas & Itihasas',
      sanskritName: 'পুরাণেতিহাস',
      description: 'Historical epics and ancient wisdom',
      bookCount: 36,
    ),
  ];
}
