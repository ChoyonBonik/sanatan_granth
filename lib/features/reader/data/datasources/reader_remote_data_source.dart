import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sanatan_granth/core/constants/app_constants.dart';
import '../models/verse_model.dart';

abstract class ReaderRemoteDataSource {
  Future<List<VerseModel>> getVerses(String bookId, int chapter);
  Future<String?> getChapterAudioUrl(String bookId, int chapter);
}

class ReaderRemoteDataSourceImpl implements ReaderRemoteDataSource {
  final SupabaseClient? _supabaseClient;

  ReaderRemoteDataSourceImpl({SupabaseClient? supabaseClient})
      : _supabaseClient = supabaseClient;

  @override
  Future<List<VerseModel>> getVerses(String bookId, int chapter) async {
    try {
      if (_supabaseClient != null) {
        final List<Map<String, dynamic>> response = await _supabaseClient
            .from(AppConstants.versesTable)
            .select()
            .eq('book_id', bookId)
            .eq('chapter_number', chapter)
            .order('verse_number');
        if (response.isNotEmpty) {
          return response.map(VerseModel.fromJson).toList();
        }
      }
      return _getCanonicalVerses(bookId, chapter);
    } catch (_) {
      return _getCanonicalVerses(bookId, chapter);
    }
  }

  @override
  Future<String?> getChapterAudioUrl(String bookId, int chapter) async {
    return 'https://actions.google.com/sounds/v1/ambiences/temple_bell.ogg';
  }

  List<VerseModel> _getCanonicalVerses(String bookId, int chapter) {
    return <VerseModel>[
      const VerseModel(
        id: 'gita-2-11',
        bookId: 'gita-as-it-is',
        chapterNumber: 2,
        verseNumber: 11,
        originalScriptText:
            'শ্রীভগবানুবাচ\nঅশোচ্যানন্বশোচস্ত্বং প্রজ্ঞাবাদাংশ্চ ভাষসে।\nগতাসূনগতাসূংশ্চ নানুশোচন্তি পণ্ডিতাঃ॥',
        scriptType: 'bengali',
        transliteration:
            'শ্রীভগবান্ উবাচ — অশোচ্যান্ অন্বশোচঃ ত্বং প্রজ্ঞাবাদান্ চ ভাষসে। গতাসূন্ অগতাসূন্ চ ন অনুশোচন্তি পণ্ডিতাঃ॥',
        wordMeanings:
            'শ্রীভগবান্ উবাচ—পরমেশ্বর ভগবান বলিলেন; অশোচ্যান্—শোকের অযোগ্য বিষয়ে; অন্বশোচঃ—শোক করিতেছ; ত্বম্—তুমি; প্রজ্ঞাবাদান্—পাণ্ডিত্যপূর্ণ কথা; চ—ও; ভাষসে—বলিতেছ; গতাসূন্—যাহাদের প্রাণবায়ু চলিয়া গিয়াছে (মৃতদেহ); অগতাসূন্—যাহাদের প্রাণ রহিয়াছে (জীবিতদেহ); চ—ও; ন—কখনও না; অনুশোচন্তি—শোক করেন; পণ্ডিতাঃ—পণ্ডিত বা আত্মজ্ঞানী ব্যক্তিগণ।',
        translation:
            'পরমেশ্বর ভগবান বলিলেন: হে অর্জুন! তুমি প্রজ্ঞাবানের ন্যায় বাক্য বলিতেছ, অথচ যে বিষয়ে শোক করা উচিত নয়, তাহারই জন্য শোক করিতেছ। যাঁহারা তত্ত্বজ্ঞানী পণ্ডিত, তাঁহারা জীবিত বা মৃত কাহারও জন্যই কখনো শোক করেন না।',
        commentary:
            'ভগবান শ্রীকৃষ্ণ এই শ্লোকে সদ্‌গুরুর ভূমিকা গ্রহণ করিয়া অর্জুনকে প্রথম আত্মতত্ত্বের উপদেশ প্রদান করিলেন। দেহ অনিত্য এবং অবিনশ্বর আত্মাই চিরন্তন সত্য। যে দেহ জড় পদার্থের সংমিশ্রণে সৃষ্ট, তার জন্য শোক করা অজ্ঞানতার লক্ষণ। আত্মজ্ঞানসম্পন্ন পণ্ডিতেরা জানেন যে আত্মা অবিনশ্বর, তাই দেহের বিনাশে আত্মার কখনো বিনাশ হয় না।',
        audioTimestampStartMs: 0,
        audioTimestampEndMs: 14000,
      ),
      const VerseModel(
        id: 'gita-2-12',
        bookId: 'gita-as-it-is',
        chapterNumber: 2,
        verseNumber: 12,
        originalScriptText:
            'ন ত্বেবাহং জাতু নাসং ন ত্বং নেমে জনাধিপাঃ।\nন চৈব ন भविষ্যামঃ সর্বে বয়মতঃ পরম্॥',
        scriptType: 'bengali',
        transliteration:
            'ন তু এব অহং জাতু ন আসং ন ত্বং ন ইমে জনাধিপাঃ। ন চ এব ন ভবিষ্যমঃ সর্বে বয়ম্ অতঃ পরম্॥',
        wordMeanings:
            'ন তু এব—কখনও এমন নহে; অহম্—আমি; জাতু—কোনো কালে; ন—না; আসম্—উপস্থিত ছিলাম না; ন—না; ত্বম্—তুমি; ন—না; ইমে—এই সকল; জন-অধিপাঃ—রাজন্যবর্গ; ন—না; চ এব—নিশ্চয়ই; ন—না; ভবিষ্যমঃ—থাকিব না; সর্বে বয়ম্—আমরা সকলে; অতঃ পরম্—ভবিষ্যতে।',
        translation:
            'এমন কোনো সময় ছিল না যখন আমি, তুমি এবং এই রাজন্যবর্গ বর্তমান ছিলাম না, এবং ভবিষ্যতেও এমন কোনো সময় আসিবে না যখন আমরা আর থাকিব না।',
        commentary:
            'বেদ ও উপনিষদে (যেমন কঠোপনিষদ ও শ্বেতাশ্বতরোপনিষদ) স্পষ্ট ঘোষিত হইয়াছে যে পরমেশ্বর ভগবান এক হইয়াও অনন্ত জীবের নিত্য পালনকর্তা। ভগবান ও প্রতিটি জীবের এই সনাতন ব্যক্তি-সত্ত্বা বা ব্যক্তিস্বরূপ নিত্যসত্য—অতীতেও ছিল, বর্তমানেও আছে এবং ভবিষ্যতেও চিরকাল অব্যাহত থাকিবে।',
        audioTimestampStartMs: 14000,
        audioTimestampEndMs: 29000,
      ),
      const VerseModel(
        id: 'gita-2-13',
        bookId: 'gita-as-it-is',
        chapterNumber: 2,
        verseNumber: 13,
        originalScriptText:
            'দেহিনোঽস্মিন্যথা দেহে কৌমারং যৌবনং জরা।\nতথা দেহান্তরপ্রাপ্তির্ধীরস্তত্র ন মুহ্যতি॥',
        scriptType: 'bengali',
        transliteration:
            'দেহিনঃ অস্মিন্ যথা দেহে কৌমারং যৌবনং জরা। তথা দেহান্তর-প্রাপ্তিঃ ধীরঃ তত্র ন মুহ্যতি॥',
        wordMeanings:
            'দেহিনঃ—দেহধারী আত্মার; অস্মিন্—এই; যথা—যেমন; দেহে—দেহের মধ্যে; কৌমারম্—বাল্যকাল; যৌবনম্—যৌবনকাল; জরা—বার্ধক্য; তথা—তেমনি; দেহ-অন্তর—অন্য দেহ; প্রাপ্তিঃ—লাভ; ধীরঃ—ধীর বা স্থিরচিত্ত ব্যক্তি; তত্র—সেই বিষয়ে; ন—কখনও না; মুহ্যতি—মোহগ্রস্ত হন।',
        translation:
            'দেহী জীবাত্মা যেমন এই বর্তমান দেহে ক্রমান্বয়ে বাল্যকাল হইতে যৌবন এবং যৌবন হইতে বার্ধক্যে উপনীত হয়, তেমনই মৃত্যুর পর আত্মা এক দেহ হইতে অন্য দেহ প্রাপ্ত হয়। স্থিরচিত্ত ধীর ব্যক্তি ইহাতে কখনো মোহগ্রস্ত বা বিভ্রান্ত হন না।',
        commentary:
            'দেহের রূপান্তরই জীবের জন্ম ও মৃত্যু। বাল্যদেহ পরিবর্তন হইয়া যেমন যৌবন ও জরা প্রাপ্ত হয়, অথচ অভ্যন্তরে অবস্থিত অবিনশ্বর আত্মা একই থাকে, তেমনই স্থূল দেহের অবসানে আত্মা কেবল নূতন পরিধেয় বস্ত্রের ন্যায় অন্য দেহ ধারণ করে। অতএব পরম সত্যজ্ঞানী ব্যক্তি দেহের বিনাশে কাতর হন না।',
        audioTimestampStartMs: 29000,
        audioTimestampEndMs: 45000,
      ),
      const VerseModel(
        id: 'gita-2-47',
        bookId: 'gita-as-it-is',
        chapterNumber: 2,
        verseNumber: 47,
        originalScriptText:
            'কর্মণ্যেবাধিকারস্তে মা ফলেষু কদাচন।\nমা কর্মফলহেতুর্ভোর্মা তে সঙ্গোঽস্ত্বকর্মণি॥',
        scriptType: 'bengali',
        transliteration:
            'কর্মণি এব অধিকারঃ তে মা ফলেষু কদাচন। মা কর্ম-ফল-হেতুঃ ভূঃ মা তে সঙ্গঃ অস্তু অকর্মণি॥',
        wordMeanings:
            'কর্মণি—বিহিত কর্ম সম্পাদনেই; এব—কেবলমাত্র; অধিকারঃ—অধিকার; তে—তোমার; মা—কখনও না; ফলেষু—কর্মের ফলে; কদাচন—কোনো কালে; মা—কখনও না; কর্ম-ফল-হেতুঃ—কর্মফলের কারণ; ভূঃ—হইও; মা—যেন না; তে—তোমার; সঙ্গঃ—আসক্তি; অস্তু—হউক; অকর্মণি—কর্মত্যাগে বা আলস্যে।',
        translation:
            'কেবল কর্ম সম্পাদনেই তোমার অধিকার রহিয়াছে, কিন্তু কর্মফলে কখনো তোমার অধিকার নাই। তুমি কখনো নিজেকে কর্মফলের কারণ মনে করিও না, এবং কর্মত্যাগেও যেন কখনো তোমার আসক্তি বা প্রবৃত্তি না হয়।',
        commentary:
            'ইহা শ্রীমদ্ভগবদ্গীতার নিষ্কাম কর্মযোগের মূল মহামন্ত্র। ফলের আশা পরিত্যাগ করিয়া পরমেশ্বরের প্রীতিবিধানের উদ্দেশ্যে নিষ্ঠাভরে স্বধর্ম পালন করাই প্রকৃত মুক্তির মার্গ। ফললাভের কামনা জীবকে সংসারের জন্ম-মৃত্যুর বন্ধনে আবদ্ধ করে, কিন্তু ঈশ্বরাপিত নিষ্কাম কর্ম চিত্তশুদ্ধি ঘটাইয়া পরম শান্তি আনয়ন করে।',
        audioTimestampStartMs: 45000,
        audioTimestampEndMs: 65000,
      ),
    ];
  }
}
