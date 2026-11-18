# Sanatan Granth (सनातन ग्रन्थ) 🕉️

A high-performance, open-source Hindu Scriptural Reader, Audiobooks, and Digital Archive application built with **Flutter**, following strict **Clean Architecture** principles and **BLoC** pattern.

---

## 🏛️ Architecture Overview

The codebase is organized into layered feature modules following Clean Architecture:

```
lib/
├── core/
│   ├── constants/             # App-wide constants, canonical categories, Supabase table keys
│   ├── di/                    # GetIt dependency injection container (injection_container.dart)
│   ├── error/                 # Domain Failures & Data Exceptions (Server, Cache, Network, Auth)
│   ├── network/               # Network connectivity checkers
│   ├── theme/                 # Palettes (Warm Sepia, Light, AMOLED Dark), typography & ThemeCubit
│   └── utils/                 # Multilingual script detector (Devanagari, Bengali, English)
├── features/
│   ├── auth/                  # Authentication & Profile management (Supabase Auth)
│   │   ├── data/              # AuthRemoteDataSource, UserModel, AuthRepositoryImpl
│   │   ├── domain/            # UserEntity, AuthRepository, Sign In / Sign Up / Sign Out use cases
│   │   └── presentation/      # AuthBloc, LoginPage, RegisterPage, ProfilePage
│   ├── library/               # Discovery catalog, Search, Category filters, Book details
│   │   ├── data/              # LibraryRemoteDataSource, BookModel, CategoryModel, LibraryRepositoryImpl
│   │   ├── domain/            # BookEntity, CategoryEntity, LibraryRepository, Use Cases
│   │   └── presentation/      # LibraryBloc, HomePage, SearchPage, BookDetailsPage, BookCard
│   ├── reader/                # Structured verse reader, PDF reader & Audio/TTS sync player
│   │   ├── data/              # ReaderRemoteDataSource, VerseModel, ReaderRepositoryImpl
│   │   ├── domain/            # VerseEntity, ReaderRepository, GetStructuredVersesUseCase
│   │   ├── presentation/      # StructuredReaderBloc, StructuredVerseReaderPage, PdfDocumentReaderPage
│   │   └── services/          # TtsService (flutter_tts), SanatanAudioHandler (just_audio + audio_service)
│   ├── contribute/            # Community Seva portal (PDF/EPUB & Verse CSV/JSON uploader)
│   │   ├── data/              # ContributeRemoteDataSource, ContributionModel, ContributeRepositoryImpl
│   │   ├── domain/            # ContributionEntity, ContributeRepository, SubmitContributionUseCase
│   │   └── presentation/      # ContributeBloc, ContributeDashboardPage, UploadDocumentPage, UploadCsvVersesPage, StatusTracker
│   └── offline/               # Local Drift SQLite vault & background download manager
│       ├── data/              # Drift AppDatabase (CachedBooks, CachedVerses, DownloadTasks, Bookmarks)
│       ├── domain/            # DownloadTaskEntity, OfflineRepository
│       └── presentation/      # OfflineBloc, DownloadManagerPage, DownloadProgressCard
├── routes/
│   └── app_router.dart        # GoRouter configuration with ShellRoute NavigationBar & deep linking
└── main.dart                  # Application entry point with MultiBlocProvider & dynamic theming
```

---

## 🎨 Theme & Typography System

### Three Reading Palettes:
1. **Warm Sepia (Vedic Palm-leaf / Bhojpatra)**: Gentle `#F7F1E5` parchment surface with `#382923` deep charcoal typography and sacred saffron highlights for zero-glare scriptural contemplation.
2. **Pure Light**: Modern high-contrast `#FAFAFB` background with obsidian `#1C1917` text and vibrant `#FF7A00` saffron accents.
3. **AMOLED Dark**: True black `#000000` 0-nit OLED display mode with luminous golden amber `#D4AF37` and saffron ember active verse highlighting to eliminate eye strain during night sadhana.

### Multilingual Typography (`google_fonts`):
- **Devanagari** (Sanskrit slokas, Hindi purports): `Noto Serif Devanagari`, `Martel`, `Rozha One`
- **Bengali** (Gita, Chaitanya Charitamrita): `Noto Serif Bengali`, `Tiro Bangla`, `Galada`
- **English / Latin** (Translations & Headings): `Cinzel`, `Lora`, `Inter`

---

## 📦 Key Dependencies

| Dependency | Purpose |
|---|---|
| `flutter_bloc` | Unidirectional reactive state management |
| `get_it` | Dependency injection & service locator |
| `go_router` | Declarative routing, shell navigation & deep links |
| `supabase_flutter` | Authentication, PostgreSQL database & cloud storage |
| `drift` + `sqlite3_flutter_libs` | Local SQLite caching & offline scriptural storage |
| `pdfrx` | High-fidelity hardware-accelerated PDF rendering |
| `just_audio` + `audio_service` | Background audiobook streaming & lockscreen notification controls |
| `flutter_tts` | Offline multilingual text-to-speech for sloka pronunciation |
| `google_fonts` | Devanagari, Bengali, and English script typography |
| `file_picker` + `csv` | Community PDF/EPUB and structured verse bulk uploader |
| `dartz` | Functional error handling (`Either<Failure, Success>`) |

---

## 🚀 Getting Started

1. **Get Dependencies**:
   ```bash
   flutter pub get
   ```

2. **Generate Drift SQLite Code (optional if modifying database schema)**:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

3. **Run the App**:
   ```bash
   flutter run
   ```

4. **Run Unit Tests**:
   ```bash
   flutter test
   ```
