-- =============================================================================
-- Seed Data: supabase/seed.sql
-- Description: Seed data containing Bhagavad Gita Chapter 1 (Verses 1 to 5)
-- Scripts: Sanskrit Devanagari, IAST Transliteration, Bengali & English Translation
-- =============================================================================

-- 1. Create Default Admin Profile (Sample system user UUID)
DO $$
DECLARE
    v_admin_id UUID := 'a0000000-0000-0000-0000-000000000001';
    v_book_id  UUID := 'b0000000-0000-0000-0000-000000000001';
    v_chap1_id UUID := 'c0000000-0000-0000-0000-000000000001';
BEGIN
    -- 1.1 Insert Admin Profile (Bypasses auth.users check if running in standalone seed)
    INSERT INTO public.profiles (id, full_name, avatar_url, role, contribution_count)
    VALUES (
        v_admin_id,
        'শ্রীল ব্যাসদেব সেবা পরিষদ (Admin)',
        'https://images.unsplash.com/photo-1544717305-2782549b5136',
        'admin',
        1
    )
    ON CONFLICT (id) DO UPDATE SET
        full_name = EXCLUDED.full_name,
        role = EXCLUDED.role;

    -- 1.2 Insert Srimad Bhagavad Gita Book
    INSERT INTO public.books (
        id,
        title,
        subtitle,
        author_rishi,
        category,
        language,
        format_type,
        file_url,
        cover_url,
        status,
        contributor_id
    ) VALUES (
        v_book_id,
        'শ্রীমদ্ভগবদ্গীতা যথার্থরূপ (Srimad Bhagavad Gita As It Is)',
        'গীতোপনিষদ — পরমেশ্বর ভগবান শ্রীকৃষ্ণের মুখনিঃসৃত পরম তত্ত্বজ্ঞান',
        'শ্রীকৃষ্ণদ্বৈপায়ন বেদব্যাস (অনুবাদ ও তাৎপর্য: শ্রীল এ. সি. ভক্তিবেদান্ত স্বামী প্রভুপাদ)',
        'Gita',
        'Sanskrit / Bengali / English',
        'structured',
        NULL,
        'https://images.unsplash.com/photo-1607604276583-eef5d076aa5f',
        'approved',
        v_admin_id
    )
    ON CONFLICT (id) DO UPDATE SET
        title = EXCLUDED.title,
        status = EXCLUDED.status;

    -- 1.3 Insert Chapter 1
    INSERT INTO public.chapters (
        id,
        book_id,
        chapter_number,
        title,
        audio_url,
        duration_seconds
    ) VALUES (
        v_chap1_id,
        v_book_id,
        1,
        'অধ্যায় ১: কুরুক্ষেত্র যুদ্ধক্ষেত্রে সৈন্য নিরীক্ষণ (Observing the Armies on the Battlefield of Kurukshetra)',
        'https://archive.org/download/gita-audio-bengali/chapter-01.mp3',
        1850
    )
    ON CONFLICT (id) DO UPDATE SET
        title = EXCLUDED.title,
        audio_url = EXCLUDED.audio_url;

    -- 1.4 Insert First 5 Verses of Chapter 1
    -- Verse 1.1
    INSERT INTO public.verses (
        chapter_id,
        verse_number,
        original_script,
        transliteration,
        translation,
        commentary,
        audio_start_ms,
        audio_end_ms
    ) VALUES (
        v_chap1_id,
        1,
        'धृतराष्ट्र उवाच
धर्मक्षेत्रे कুরুক্ষেত্ৰে সমবেতা যুযুত্সবঃ।
মামকাঃ পাণ্ডবাশ্চৈব কিমকুর্বত সঞ্জয়॥ ১.১॥',
        'dhṛtarāṣṭra uvāca
dharma-kṣetre kuru-kṣetre samavetā yuyutsavaḥ
māmakāḥ pāṇḍavāś caiva kim akurvata sañjaya',
        'ধৃতরাষ্ট্র বললেন: হে সঞ্জয়, ধর্মক্ষেত্র কুরুক্ষেত্রে যুদ্ধাভিলাষী হয়ে সমবেত আমার ছেলেরা এবং পাণ্ডুর ছেলেরা শেষ পর্যন্ত কি করল?
(Dhritarashtra said: O Sanjaya, after my sons and the sons of Pandu assembled in the place of pilgrimage at Kurukshetra, desiring to fight, what did they do?)',
        'শব্দার্থ: ধর্ম-ক্ষেত্রে—পুণ্যতীর্থ কুরুক্ষেত্রে; কুরু-ক্ষেত্রে—কুরুক্ষেত্র নামক স্থানে; সমবেতাঃ—সমবেত হয়ে; যুযুত্সবঃ—যুদ্ধাভিলাষী; মামকাঃ—আমার পক্ষের সন্তানেরা; পাণ্ডবাঃ—পাণ্ডুর সন্তানেরা; চ—এবং; এব—নিশ্চয়ই; কিম্—কি; অকুর্বত—করল; সঞ্জয়—হে সঞ্জয়।
তাৎপর্য: ভগবদ্গীতা হল সমগ্র বিশ্বের সর্বাধিক পঠিত প্রামাণিক আস্তিক বিজ্ঞানগ্রন্থ। ধৃতরাষ্ট্র ও পাণ্ডুর বংশধরদের ধর্মক্ষেত্রের এই মহাসমর প্রকৃতপক্ষে আসুরিক ও দৈবী শক্তির শাশ্বত দ্বন্দ্বের প্রতীক।',
        0,
        32000
    )
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        original_script = EXCLUDED.original_script,
        translation = EXCLUDED.translation;

    -- Verse 1.2
    INSERT INTO public.verses (
        chapter_id,
        verse_number,
        original_script,
        transliteration,
        translation,
        commentary,
        audio_start_ms,
        audio_end_ms
    ) VALUES (
        v_chap1_id,
        2,
        'सञ्जय उवाच
दृष्ट्वा तु पाण्डवानीकं व्यूढं दुर्योधनस्तदा।
आचार्यमुपसङ्गम्य राजा वचनमब्रवीत्॥ ১.২॥',
        'sañjaya uvāca
dṛṣṭvā tu pāṇḍavānīkaṁ vyūḍhaṁ duryodhanas tadā
ācāryam upasaṅgamya rājā vacanam abravīt',
        'সঞ্জয় বললেন: হে মহারাজ, পাণ্ডুপুত্রদের সৈন্য সমাবেশ প্রত্যক্ষ করে রাজা দুর্যোধন দ্রোণাচার্যের কাছে গমন করলেন এবং বললেন।
(Sanjaya said: O King, after looking over the army arranged in military formation by the sons of Pandu, King Duryodhana went to his teacher and spoke the following words.)',
        'শব্দার্থ: দৃষ্ট্বা—দর্শন করে; তু—কিন্তু; পাণ্ডব-অনীকম্—পাণ্ডব সৈন্যদের; ব্যূঢ়ম্—ব্যূহ রচনায় সন্নিবিষ্ট; দুর্যোধনঃ—রাজা দুর্যোধন; তদা—তখন; আচার্যম্—শিক্ষাগুরু দ্রোণাচার্যের কাছে; উপসঙ্গম্য—নিকটে গিয়ে; রাজা—রাজা দুর্যোধন; বচনম্—বাণী; অব্রবীত্—বললেন।',
        32500,
        58000
    )
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        original_script = EXCLUDED.original_script,
        translation = EXCLUDED.translation;

    -- Verse 1.3
    INSERT INTO public.verses (
        chapter_id,
        verse_number,
        original_script,
        transliteration,
        translation,
        commentary,
        audio_start_ms,
        audio_end_ms
    ) VALUES (
        v_chap1_id,
        3,
        'पश्यैतां पाण्डुपुत्राणामाचार्य महतीं चमूम्।
व्यूढां द्रुपदपुत्रेण तव शिष्येण धीमता॥ ১.৩॥',
        'paśyaitāṁ pāṇḍu-putrāṇām ācārya mahatīṁ camūm
vyūḍhāṁ drupada-putreṇa tava śiṣyeṇa dhīmatā',
        'হে আচার্য! আপনার প্রতিভাবান শিষ্য দ্রুপদপুত্রের দ্বারা সুবিন্যস্ত পাণ্ডবদের এই বিশাল সৈন্যবাহিনীর সৈন্যসজ্জা দেখুন।
(O my teacher, behold the great army of the sons of Pandu, so expertly arranged by your intelligent disciple the son of Drupada.)',
        'শব্দার্থ: পশ্য—দেখুন; এতাম্—এই; পাণ্ডু-পুত্রাণাম্—পাণ্ডুর পুত্রদের; আচার্য—হে শিক্ষক; মহতীম্—বিশাল; চমূম্—সেনাবাহিনীকে; ব্যূঢ়াম্—ব্যূহাকারে রচিত; দ্রুপদ-পুত্রেণ—দ্রুপদপুত্র ধৃষ্টদ্যুম্নের দ্বারা; তব—আপনার; শিষ্যেণ—শিষ্যের দ্বারা; ধীমতা—পরম বুদ্ধিমানের দ্বারা।',
        58500,
        84000
    )
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        original_script = EXCLUDED.original_script,
        translation = EXCLUDED.translation;

    -- Verse 1.4
    INSERT INTO public.verses (
        chapter_id,
        verse_number,
        original_script,
        transliteration,
        translation,
        commentary,
        audio_start_ms,
        audio_end_ms
    ) VALUES (
        v_chap1_id,
        4,
        'अत्र शूरा महेष्वासा भीमार्जुनसमा युधि।
युयुधानो विराटश्च द्रुपदश्च महारथः॥ ১.৪॥',
        'atra śūrā maheṣv-āsā bhīmārjuna-samā yudhi
yuyudhāno virāṭaś ca drupadaś ca mahā-rathaḥ',
        'এই সৈন্যবাহিনীতে ভীম ও অর্জুনের সমকক্ষ বহু বীর ধনুর্ধর রয়েছেন; যেমন যুযুধান, বিরাট এবং মহারথী দ্রুপদ।
(Here in this army are many heroic bowmen equal in fighting to Bhima and Arjuna: great fighters like Yuyudhana, Virata and Drupada.)',
        'শব্দার্থ: অত্র—এখানে; শূরাঃ—বীরগণ; মহা-ইষু-আসাঃ—মহা ধনুর্ধরগণ; ভীম-অর্জুন-সমাঃ—ভীম ও অর্জুনের সমকক্ষ; যুধি—যুদ্ধে; যুযুধানঃ—সাত্যকি; বিরাটঃ—মহারাজ বিরাট; চ—এবং; দ্রুপদঃ—মহারাজ দ্রুপদ; চ—এবং; মহা-রথঃ—মহারথী যোদ্ধা।',
        84500,
        110000
    )
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        original_script = EXCLUDED.original_script,
        translation = EXCLUDED.translation;

    -- Verse 1.5
    INSERT INTO public.verses (
        chapter_id,
        verse_number,
        original_script,
        transliteration,
        translation,
        commentary,
        audio_start_ms,
        audio_end_ms
    ) VALUES (
        v_chap1_id,
        5,
        'धृष्टकेतुश्चेकितानः काशिराजश्च वीर्यवान्।
पुरुजित्कुन्तिभोजश्च शैब्यश्च नरपुङ्गवः॥ ১.৫॥',
        'dhṛṣṭaketuś cekitānaḥ kāśirājaś ca vīryavān
purujit kuntibhojaś ca śaibyaś ca nara-puṅgavaḥ',
        'এছাড়াও রয়েছেন ধৃষ্টকেতু, চেকিতান, কাশীরাজার মতো পরাক্রমশালী বীর এবং পুরুজিৎ, কুন্তীভোজ ও নরশ্রেষ্ঠ শৈব্য।
(There are also great heroic, powerful fighters like Dhrishtaketu, Chekitana, Kasiraja, Purujit, Kuntibhoja and Saibya.)',
        'শব্দার্থ: ধৃষ্টকেতুঃ—ধৃষ্টকেতু; চেকিতানঃ—চেকিতান; কাশিরাজঃ—কাশীর রাজা; চ—এবং; বীর্য-বান্—পরম বলবান; পুরুজিৎ—পুরুজিৎ; কুন্তিভোজঃ—কুন্তীভোজ; চ—এবং; শৈব্যঃ—শৈব্য; চ—এবং; নর-পুঙ্গবঃ—মানবশ্রেষ্ঠ।',
        110500,
        138000
    )
    ON CONFLICT (chapter_id, verse_number) DO UPDATE SET
        original_script = EXCLUDED.original_script,
        translation = EXCLUDED.translation;
END $$;
