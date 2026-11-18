import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/constants/app_constants.dart';
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
    } catch (e) {
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
            'श्रीभगवानुवाच\nअशोच्यानन्वशोचस्त्वं प्रज्ञावादांश्च भाषसे।\nगतासूनगतासूंश्च नानुशोचन्ति पण्डिताः॥',
        scriptType: 'devanagari',
        transliteration:
            'śrī-bhagavān uvāca\naśocyān anvaśocas tvaṁ prajñā-vādāṁś ca bhāṣase\ngatāsūn agatāsūṁś ca nānuśocanti paṇḍitāḥ',
        wordMeanings:
            'śrī-bhagavān uvāca—the Supreme Personality of Godhead said; aśocyān—not worthy of lamentation; anvaśocaḥ—you are lamenting; tvam—you; prajñā-vādān—learned talks; ca—also; bhāṣase—speaking; gata—lost; asūn—life; agata—not passed; asūn—life; ca—also; na—never; anuśocanti—lament; paṇḍitāḥ—the learned.',
        translation:
            'The Supreme Personality of Godhead said: While speaking learned words, you are mourning for what is not worthy of grief. Those who are wise lament neither for the living nor for the dead.',
        commentary:
            'The Lord immediately assumed the position of the teacher and chastised the student, calling him, indirectly, a fool. The Lord said, "You are talking like a learned man, but you do not know that one who is learned—one who knows what is body and what is soul—does not lament for any condition of the body."',
        audioTimestampStartMs: 0,
        audioTimestampEndMs: 14000,
      ),
      const VerseModel(
        id: 'gita-2-12',
        bookId: 'gita-as-it-is',
        chapterNumber: 2,
        verseNumber: 12,
        originalScriptText:
            'न त्वेवाहं जातु नासं न त्वं नेमे जनाधिपाः।\nन चैव न भविष्यामः सर्वे वयमतः परम्॥',
        scriptType: 'devanagari',
        transliteration:
            'na tv evāhaṁ jātu nāsaṁ na tvaṁ neme janādhipāḥ\nna caiva na bhaviṣyāmaḥ sarve vayam ataḥ param',
        wordMeanings:
            'na—never; tu—but; eva—certainly; aham—I; jātu—at any time; na—did not; āsam—exist; na—not; tvam—you; na—not; ime—all these; jana-adhipāḥ—kings; na—never; ca—also; eva—certainly; na—not; bhaviṣyāmaḥ—shall exist; sarve vayam—all of us; ataḥ param—hereafter.',
        translation:
            'Never was there a time when I did not exist, nor you, nor all these kings; nor in the future shall any of us cease to be.',
        commentary:
            'In the Vedas—in the Katha Upanishad as well as in the Svetasvatara Upanishad—it is said that the Supreme Personality of Godhead is the maintainer of innumerable living entities. The individuality of the soul and the Lord is eternal truth.',
        audioTimestampStartMs: 14000,
        audioTimestampEndMs: 29000,
      ),
      const VerseModel(
        id: 'gita-2-13',
        bookId: 'gita-as-it-is',
        chapterNumber: 2,
        verseNumber: 13,
        originalScriptText:
            'देहिनोऽस्मिन्यथा देहे कौमारं यौवनं जरा।\nतथा देहान्तरप्राप्तिर्धीरस्तत्र न मुह्यति॥',
        scriptType: 'devanagari',
        transliteration:
            'dehino \'smin yathā dehe kaumāraṁ yauvanaṁ jarā\ntathā dehāntara-prāptir dhīras tatra na muhyati',
        wordMeanings:
            'dehinaḥ—of the embodied; asmin—in this; yathā—as; dehe—in the body; kaumāram—boyhood; yauvanam—youth; jarā—old age; tathā—similarly; deha-antara—transmigration of the body; prāptiḥ—achievement; dhīraḥ—the sober; tatra—thereupon; na—never; muhyati—is deluded.',
        translation:
            'As the embodied soul continuously passes, in this body, from boyhood to youth to old age, the soul similarly passes into another body at death. A sober person is not bewildered by such a change.',
        commentary:
            'Every living entity is an individual soul, and the soul changes its body every moment, manifesting sometimes as a child, sometimes as a youth, and sometimes as an old man. Yet the same spirit soul is there and does not undergo any change.',
        audioTimestampStartMs: 29000,
        audioTimestampEndMs: 45000,
      ),
      const VerseModel(
        id: 'gita-2-47',
        bookId: 'gita-as-it-is',
        chapterNumber: 2,
        verseNumber: 47,
        originalScriptText:
            'कर्मण्येवाधिकारस्ते मा फलेषु कदाचन।\nमा कर्मफलहेतुर्भूर्मा ते सङ्गोऽस्त्वकर्मणि॥',
        scriptType: 'devanagari',
        transliteration:
            'karmaṇy evādhikāras te mā phaleṣu kadācana\nmā karma-phala-hetur bhūr mā te saṅgo \'stv akarmaṇi',
        wordMeanings:
            'karmaṇi—in prescribed duties; eva—certainly; adhikāraḥ—right; te—of you; mā—never; phaleṣu—in the fruits; kadācana—at any time; mā—never; karma-phala—in the result of work; hetuḥ—cause; bhūḥ—become; mā—never; te—of you; saṅgaḥ—attachment; astu—there should be; akarmaṇi—in not doing prescribed duties.',
        translation:
            'You have a right to perform your prescribed duty, but you are not entitled to the fruits of action. Never consider yourself the cause of the results of your activities, and never be attached to not doing your duty.',
        commentary:
            'Three considerations are prescribed: karma (prescribed duties), vikarma (forbidden actions), and akarma (inaction). The Lord advises Arjuna to act in Nishkama Karma Yoga without claiming proprietary ownership over the fruits.',
        audioTimestampStartMs: 45000,
        audioTimestampEndMs: 65000,
      ),
    ];
  }
}
