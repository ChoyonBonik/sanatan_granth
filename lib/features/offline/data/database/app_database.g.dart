// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CachedBooksTable extends CachedBooks
    with TableInfo<$CachedBooksTable, CachedBook> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedBooksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _authorMeta = const VerificationMeta('author');
  @override
  late final GeneratedColumn<String> author = GeneratedColumn<String>(
      'author', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _languageMeta =
      const VerificationMeta('language');
  @override
  late final GeneratedColumn<String> language = GeneratedColumn<String>(
      'language', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _coverUrlMeta =
      const VerificationMeta('coverUrl');
  @override
  late final GeneratedColumn<String> coverUrl = GeneratedColumn<String>(
      'cover_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _fileUrlMeta =
      const VerificationMeta('fileUrl');
  @override
  late final GeneratedColumn<String> fileUrl = GeneratedColumn<String>(
      'file_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _localFilePathMeta =
      const VerificationMeta('localFilePath');
  @override
  late final GeneratedColumn<String> localFilePath = GeneratedColumn<String>(
      'local_file_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _formatMeta = const VerificationMeta('format');
  @override
  late final GeneratedColumn<String> format = GeneratedColumn<String>(
      'format', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('structured'));
  static const VerificationMeta _totalVersesMeta =
      const VerificationMeta('totalVerses');
  @override
  late final GeneratedColumn<int> totalVerses = GeneratedColumn<int>(
      'total_verses', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _isFavoriteMeta =
      const VerificationMeta('isFavorite');
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
      'is_favorite', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_favorite" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _cachedAtMeta =
      const VerificationMeta('cachedAt');
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
      'cached_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        author,
        category,
        language,
        description,
        coverUrl,
        fileUrl,
        localFilePath,
        format,
        totalVerses,
        isFavorite,
        cachedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_books';
  @override
  VerificationContext validateIntegrity(Insertable<CachedBook> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('author')) {
      context.handle(_authorMeta,
          author.isAcceptableOrUnknown(data['author']!, _authorMeta));
    } else if (isInserting) {
      context.missing(_authorMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('language')) {
      context.handle(_languageMeta,
          language.isAcceptableOrUnknown(data['language']!, _languageMeta));
    } else if (isInserting) {
      context.missing(_languageMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('cover_url')) {
      context.handle(_coverUrlMeta,
          coverUrl.isAcceptableOrUnknown(data['cover_url']!, _coverUrlMeta));
    }
    if (data.containsKey('file_url')) {
      context.handle(_fileUrlMeta,
          fileUrl.isAcceptableOrUnknown(data['file_url']!, _fileUrlMeta));
    }
    if (data.containsKey('local_file_path')) {
      context.handle(
          _localFilePathMeta,
          localFilePath.isAcceptableOrUnknown(
              data['local_file_path']!, _localFilePathMeta));
    }
    if (data.containsKey('format')) {
      context.handle(_formatMeta,
          format.isAcceptableOrUnknown(data['format']!, _formatMeta));
    }
    if (data.containsKey('total_verses')) {
      context.handle(
          _totalVersesMeta,
          totalVerses.isAcceptableOrUnknown(
              data['total_verses']!, _totalVersesMeta));
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
          _isFavoriteMeta,
          isFavorite.isAcceptableOrUnknown(
              data['is_favorite']!, _isFavoriteMeta));
    }
    if (data.containsKey('cached_at')) {
      context.handle(_cachedAtMeta,
          cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CachedBook map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedBook(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      author: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}author'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      language: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}language'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      coverUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cover_url']),
      fileUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}file_url']),
      localFilePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}local_file_path']),
      format: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}format'])!,
      totalVerses: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_verses'])!,
      isFavorite: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_favorite'])!,
      cachedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}cached_at'])!,
    );
  }

  @override
  $CachedBooksTable createAlias(String alias) {
    return $CachedBooksTable(attachedDatabase, alias);
  }
}

class CachedBook extends DataClass implements Insertable<CachedBook> {
  final String id;
  final String title;
  final String author;
  final String category;
  final String language;
  final String description;
  final String? coverUrl;
  final String? fileUrl;
  final String? localFilePath;
  final String format;
  final int totalVerses;
  final bool isFavorite;
  final DateTime cachedAt;
  const CachedBook(
      {required this.id,
      required this.title,
      required this.author,
      required this.category,
      required this.language,
      required this.description,
      this.coverUrl,
      this.fileUrl,
      this.localFilePath,
      required this.format,
      required this.totalVerses,
      required this.isFavorite,
      required this.cachedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['author'] = Variable<String>(author);
    map['category'] = Variable<String>(category);
    map['language'] = Variable<String>(language);
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || coverUrl != null) {
      map['cover_url'] = Variable<String>(coverUrl);
    }
    if (!nullToAbsent || fileUrl != null) {
      map['file_url'] = Variable<String>(fileUrl);
    }
    if (!nullToAbsent || localFilePath != null) {
      map['local_file_path'] = Variable<String>(localFilePath);
    }
    map['format'] = Variable<String>(format);
    map['total_verses'] = Variable<int>(totalVerses);
    map['is_favorite'] = Variable<bool>(isFavorite);
    map['cached_at'] = Variable<DateTime>(cachedAt);
    return map;
  }

  CachedBooksCompanion toCompanion(bool nullToAbsent) {
    return CachedBooksCompanion(
      id: Value(id),
      title: Value(title),
      author: Value(author),
      category: Value(category),
      language: Value(language),
      description: Value(description),
      coverUrl: coverUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(coverUrl),
      fileUrl: fileUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(fileUrl),
      localFilePath: localFilePath == null && nullToAbsent
          ? const Value.absent()
          : Value(localFilePath),
      format: Value(format),
      totalVerses: Value(totalVerses),
      isFavorite: Value(isFavorite),
      cachedAt: Value(cachedAt),
    );
  }

  factory CachedBook.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedBook(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      author: serializer.fromJson<String>(json['author']),
      category: serializer.fromJson<String>(json['category']),
      language: serializer.fromJson<String>(json['language']),
      description: serializer.fromJson<String>(json['description']),
      coverUrl: serializer.fromJson<String?>(json['coverUrl']),
      fileUrl: serializer.fromJson<String?>(json['fileUrl']),
      localFilePath: serializer.fromJson<String?>(json['localFilePath']),
      format: serializer.fromJson<String>(json['format']),
      totalVerses: serializer.fromJson<int>(json['totalVerses']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'author': serializer.toJson<String>(author),
      'category': serializer.toJson<String>(category),
      'language': serializer.toJson<String>(language),
      'description': serializer.toJson<String>(description),
      'coverUrl': serializer.toJson<String?>(coverUrl),
      'fileUrl': serializer.toJson<String?>(fileUrl),
      'localFilePath': serializer.toJson<String?>(localFilePath),
      'format': serializer.toJson<String>(format),
      'totalVerses': serializer.toJson<int>(totalVerses),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
    };
  }

  CachedBook copyWith(
          {String? id,
          String? title,
          String? author,
          String? category,
          String? language,
          String? description,
          Value<String?> coverUrl = const Value.absent(),
          Value<String?> fileUrl = const Value.absent(),
          Value<String?> localFilePath = const Value.absent(),
          String? format,
          int? totalVerses,
          bool? isFavorite,
          DateTime? cachedAt}) =>
      CachedBook(
        id: id ?? this.id,
        title: title ?? this.title,
        author: author ?? this.author,
        category: category ?? this.category,
        language: language ?? this.language,
        description: description ?? this.description,
        coverUrl: coverUrl.present ? coverUrl.value : this.coverUrl,
        fileUrl: fileUrl.present ? fileUrl.value : this.fileUrl,
        localFilePath:
            localFilePath.present ? localFilePath.value : this.localFilePath,
        format: format ?? this.format,
        totalVerses: totalVerses ?? this.totalVerses,
        isFavorite: isFavorite ?? this.isFavorite,
        cachedAt: cachedAt ?? this.cachedAt,
      );
  CachedBook copyWithCompanion(CachedBooksCompanion data) {
    return CachedBook(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      author: data.author.present ? data.author.value : this.author,
      category: data.category.present ? data.category.value : this.category,
      language: data.language.present ? data.language.value : this.language,
      description:
          data.description.present ? data.description.value : this.description,
      coverUrl: data.coverUrl.present ? data.coverUrl.value : this.coverUrl,
      fileUrl: data.fileUrl.present ? data.fileUrl.value : this.fileUrl,
      localFilePath: data.localFilePath.present
          ? data.localFilePath.value
          : this.localFilePath,
      format: data.format.present ? data.format.value : this.format,
      totalVerses:
          data.totalVerses.present ? data.totalVerses.value : this.totalVerses,
      isFavorite:
          data.isFavorite.present ? data.isFavorite.value : this.isFavorite,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedBook(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('author: $author, ')
          ..write('category: $category, ')
          ..write('language: $language, ')
          ..write('description: $description, ')
          ..write('coverUrl: $coverUrl, ')
          ..write('fileUrl: $fileUrl, ')
          ..write('localFilePath: $localFilePath, ')
          ..write('format: $format, ')
          ..write('totalVerses: $totalVerses, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      title,
      author,
      category,
      language,
      description,
      coverUrl,
      fileUrl,
      localFilePath,
      format,
      totalVerses,
      isFavorite,
      cachedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedBook &&
          other.id == this.id &&
          other.title == this.title &&
          other.author == this.author &&
          other.category == this.category &&
          other.language == this.language &&
          other.description == this.description &&
          other.coverUrl == this.coverUrl &&
          other.fileUrl == this.fileUrl &&
          other.localFilePath == this.localFilePath &&
          other.format == this.format &&
          other.totalVerses == this.totalVerses &&
          other.isFavorite == this.isFavorite &&
          other.cachedAt == this.cachedAt);
}

class CachedBooksCompanion extends UpdateCompanion<CachedBook> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> author;
  final Value<String> category;
  final Value<String> language;
  final Value<String> description;
  final Value<String?> coverUrl;
  final Value<String?> fileUrl;
  final Value<String?> localFilePath;
  final Value<String> format;
  final Value<int> totalVerses;
  final Value<bool> isFavorite;
  final Value<DateTime> cachedAt;
  final Value<int> rowid;
  const CachedBooksCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.author = const Value.absent(),
    this.category = const Value.absent(),
    this.language = const Value.absent(),
    this.description = const Value.absent(),
    this.coverUrl = const Value.absent(),
    this.fileUrl = const Value.absent(),
    this.localFilePath = const Value.absent(),
    this.format = const Value.absent(),
    this.totalVerses = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedBooksCompanion.insert({
    required String id,
    required String title,
    required String author,
    required String category,
    required String language,
    required String description,
    this.coverUrl = const Value.absent(),
    this.fileUrl = const Value.absent(),
    this.localFilePath = const Value.absent(),
    this.format = const Value.absent(),
    this.totalVerses = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        author = Value(author),
        category = Value(category),
        language = Value(language),
        description = Value(description);
  static Insertable<CachedBook> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? author,
    Expression<String>? category,
    Expression<String>? language,
    Expression<String>? description,
    Expression<String>? coverUrl,
    Expression<String>? fileUrl,
    Expression<String>? localFilePath,
    Expression<String>? format,
    Expression<int>? totalVerses,
    Expression<bool>? isFavorite,
    Expression<DateTime>? cachedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (author != null) 'author': author,
      if (category != null) 'category': category,
      if (language != null) 'language': language,
      if (description != null) 'description': description,
      if (coverUrl != null) 'cover_url': coverUrl,
      if (fileUrl != null) 'file_url': fileUrl,
      if (localFilePath != null) 'local_file_path': localFilePath,
      if (format != null) 'format': format,
      if (totalVerses != null) 'total_verses': totalVerses,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedBooksCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String>? author,
      Value<String>? category,
      Value<String>? language,
      Value<String>? description,
      Value<String?>? coverUrl,
      Value<String?>? fileUrl,
      Value<String?>? localFilePath,
      Value<String>? format,
      Value<int>? totalVerses,
      Value<bool>? isFavorite,
      Value<DateTime>? cachedAt,
      Value<int>? rowid}) {
    return CachedBooksCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      category: category ?? this.category,
      language: language ?? this.language,
      description: description ?? this.description,
      coverUrl: coverUrl ?? this.coverUrl,
      fileUrl: fileUrl ?? this.fileUrl,
      localFilePath: localFilePath ?? this.localFilePath,
      format: format ?? this.format,
      totalVerses: totalVerses ?? this.totalVerses,
      isFavorite: isFavorite ?? this.isFavorite,
      cachedAt: cachedAt ?? this.cachedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (coverUrl.present) {
      map['cover_url'] = Variable<String>(coverUrl.value);
    }
    if (fileUrl.present) {
      map['file_url'] = Variable<String>(fileUrl.value);
    }
    if (localFilePath.present) {
      map['local_file_path'] = Variable<String>(localFilePath.value);
    }
    if (format.present) {
      map['format'] = Variable<String>(format.value);
    }
    if (totalVerses.present) {
      map['total_verses'] = Variable<int>(totalVerses.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedBooksCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('author: $author, ')
          ..write('category: $category, ')
          ..write('language: $language, ')
          ..write('description: $description, ')
          ..write('coverUrl: $coverUrl, ')
          ..write('fileUrl: $fileUrl, ')
          ..write('localFilePath: $localFilePath, ')
          ..write('format: $format, ')
          ..write('totalVerses: $totalVerses, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedVersesTable extends CachedVerses
    with TableInfo<$CachedVersesTable, CachedVerse> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedVersesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<String> bookId = GeneratedColumn<String>(
      'book_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _chapterNumberMeta =
      const VerificationMeta('chapterNumber');
  @override
  late final GeneratedColumn<int> chapterNumber = GeneratedColumn<int>(
      'chapter_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _verseNumberMeta =
      const VerificationMeta('verseNumber');
  @override
  late final GeneratedColumn<int> verseNumber = GeneratedColumn<int>(
      'verse_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _originalScriptTextMeta =
      const VerificationMeta('originalScriptText');
  @override
  late final GeneratedColumn<String> originalScriptText =
      GeneratedColumn<String>('original_script_text', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _scriptTypeMeta =
      const VerificationMeta('scriptType');
  @override
  late final GeneratedColumn<String> scriptType = GeneratedColumn<String>(
      'script_type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('devanagari'));
  static const VerificationMeta _transliterationMeta =
      const VerificationMeta('transliteration');
  @override
  late final GeneratedColumn<String> transliteration = GeneratedColumn<String>(
      'transliteration', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _wordMeaningsMeta =
      const VerificationMeta('wordMeanings');
  @override
  late final GeneratedColumn<String> wordMeanings = GeneratedColumn<String>(
      'word_meanings', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _translationMeta =
      const VerificationMeta('translation');
  @override
  late final GeneratedColumn<String> translation = GeneratedColumn<String>(
      'translation', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _commentaryMeta =
      const VerificationMeta('commentary');
  @override
  late final GeneratedColumn<String> commentary = GeneratedColumn<String>(
      'commentary', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _audioTimestampStartMsMeta =
      const VerificationMeta('audioTimestampStartMs');
  @override
  late final GeneratedColumn<int> audioTimestampStartMs = GeneratedColumn<int>(
      'audio_timestamp_start_ms', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _audioTimestampEndMsMeta =
      const VerificationMeta('audioTimestampEndMs');
  @override
  late final GeneratedColumn<int> audioTimestampEndMs = GeneratedColumn<int>(
      'audio_timestamp_end_ms', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        bookId,
        chapterNumber,
        verseNumber,
        originalScriptText,
        scriptType,
        transliteration,
        wordMeanings,
        translation,
        commentary,
        audioTimestampStartMs,
        audioTimestampEndMs
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_verses';
  @override
  VerificationContext validateIntegrity(Insertable<CachedVerse> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('book_id')) {
      context.handle(_bookIdMeta,
          bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta));
    } else if (isInserting) {
      context.missing(_bookIdMeta);
    }
    if (data.containsKey('chapter_number')) {
      context.handle(
          _chapterNumberMeta,
          chapterNumber.isAcceptableOrUnknown(
              data['chapter_number']!, _chapterNumberMeta));
    } else if (isInserting) {
      context.missing(_chapterNumberMeta);
    }
    if (data.containsKey('verse_number')) {
      context.handle(
          _verseNumberMeta,
          verseNumber.isAcceptableOrUnknown(
              data['verse_number']!, _verseNumberMeta));
    } else if (isInserting) {
      context.missing(_verseNumberMeta);
    }
    if (data.containsKey('original_script_text')) {
      context.handle(
          _originalScriptTextMeta,
          originalScriptText.isAcceptableOrUnknown(
              data['original_script_text']!, _originalScriptTextMeta));
    } else if (isInserting) {
      context.missing(_originalScriptTextMeta);
    }
    if (data.containsKey('script_type')) {
      context.handle(
          _scriptTypeMeta,
          scriptType.isAcceptableOrUnknown(
              data['script_type']!, _scriptTypeMeta));
    }
    if (data.containsKey('transliteration')) {
      context.handle(
          _transliterationMeta,
          transliteration.isAcceptableOrUnknown(
              data['transliteration']!, _transliterationMeta));
    }
    if (data.containsKey('word_meanings')) {
      context.handle(
          _wordMeaningsMeta,
          wordMeanings.isAcceptableOrUnknown(
              data['word_meanings']!, _wordMeaningsMeta));
    }
    if (data.containsKey('translation')) {
      context.handle(
          _translationMeta,
          translation.isAcceptableOrUnknown(
              data['translation']!, _translationMeta));
    } else if (isInserting) {
      context.missing(_translationMeta);
    }
    if (data.containsKey('commentary')) {
      context.handle(
          _commentaryMeta,
          commentary.isAcceptableOrUnknown(
              data['commentary']!, _commentaryMeta));
    }
    if (data.containsKey('audio_timestamp_start_ms')) {
      context.handle(
          _audioTimestampStartMsMeta,
          audioTimestampStartMs.isAcceptableOrUnknown(
              data['audio_timestamp_start_ms']!, _audioTimestampStartMsMeta));
    }
    if (data.containsKey('audio_timestamp_end_ms')) {
      context.handle(
          _audioTimestampEndMsMeta,
          audioTimestampEndMs.isAcceptableOrUnknown(
              data['audio_timestamp_end_ms']!, _audioTimestampEndMsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CachedVerse map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedVerse(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      bookId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}book_id'])!,
      chapterNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}chapter_number'])!,
      verseNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}verse_number'])!,
      originalScriptText: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}original_script_text'])!,
      scriptType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}script_type'])!,
      transliteration: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}transliteration']),
      wordMeanings: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}word_meanings']),
      translation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}translation'])!,
      commentary: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}commentary']),
      audioTimestampStartMs: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}audio_timestamp_start_ms']),
      audioTimestampEndMs: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}audio_timestamp_end_ms']),
    );
  }

  @override
  $CachedVersesTable createAlias(String alias) {
    return $CachedVersesTable(attachedDatabase, alias);
  }
}

class CachedVerse extends DataClass implements Insertable<CachedVerse> {
  final String id;
  final String bookId;
  final int chapterNumber;
  final int verseNumber;
  final String originalScriptText;
  final String scriptType;
  final String? transliteration;
  final String? wordMeanings;
  final String translation;
  final String? commentary;
  final int? audioTimestampStartMs;
  final int? audioTimestampEndMs;
  const CachedVerse(
      {required this.id,
      required this.bookId,
      required this.chapterNumber,
      required this.verseNumber,
      required this.originalScriptText,
      required this.scriptType,
      this.transliteration,
      this.wordMeanings,
      required this.translation,
      this.commentary,
      this.audioTimestampStartMs,
      this.audioTimestampEndMs});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['book_id'] = Variable<String>(bookId);
    map['chapter_number'] = Variable<int>(chapterNumber);
    map['verse_number'] = Variable<int>(verseNumber);
    map['original_script_text'] = Variable<String>(originalScriptText);
    map['script_type'] = Variable<String>(scriptType);
    if (!nullToAbsent || transliteration != null) {
      map['transliteration'] = Variable<String>(transliteration);
    }
    if (!nullToAbsent || wordMeanings != null) {
      map['word_meanings'] = Variable<String>(wordMeanings);
    }
    map['translation'] = Variable<String>(translation);
    if (!nullToAbsent || commentary != null) {
      map['commentary'] = Variable<String>(commentary);
    }
    if (!nullToAbsent || audioTimestampStartMs != null) {
      map['audio_timestamp_start_ms'] = Variable<int>(audioTimestampStartMs);
    }
    if (!nullToAbsent || audioTimestampEndMs != null) {
      map['audio_timestamp_end_ms'] = Variable<int>(audioTimestampEndMs);
    }
    return map;
  }

  CachedVersesCompanion toCompanion(bool nullToAbsent) {
    return CachedVersesCompanion(
      id: Value(id),
      bookId: Value(bookId),
      chapterNumber: Value(chapterNumber),
      verseNumber: Value(verseNumber),
      originalScriptText: Value(originalScriptText),
      scriptType: Value(scriptType),
      transliteration: transliteration == null && nullToAbsent
          ? const Value.absent()
          : Value(transliteration),
      wordMeanings: wordMeanings == null && nullToAbsent
          ? const Value.absent()
          : Value(wordMeanings),
      translation: Value(translation),
      commentary: commentary == null && nullToAbsent
          ? const Value.absent()
          : Value(commentary),
      audioTimestampStartMs: audioTimestampStartMs == null && nullToAbsent
          ? const Value.absent()
          : Value(audioTimestampStartMs),
      audioTimestampEndMs: audioTimestampEndMs == null && nullToAbsent
          ? const Value.absent()
          : Value(audioTimestampEndMs),
    );
  }

  factory CachedVerse.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedVerse(
      id: serializer.fromJson<String>(json['id']),
      bookId: serializer.fromJson<String>(json['bookId']),
      chapterNumber: serializer.fromJson<int>(json['chapterNumber']),
      verseNumber: serializer.fromJson<int>(json['verseNumber']),
      originalScriptText:
          serializer.fromJson<String>(json['originalScriptText']),
      scriptType: serializer.fromJson<String>(json['scriptType']),
      transliteration: serializer.fromJson<String?>(json['transliteration']),
      wordMeanings: serializer.fromJson<String?>(json['wordMeanings']),
      translation: serializer.fromJson<String>(json['translation']),
      commentary: serializer.fromJson<String?>(json['commentary']),
      audioTimestampStartMs:
          serializer.fromJson<int?>(json['audioTimestampStartMs']),
      audioTimestampEndMs:
          serializer.fromJson<int?>(json['audioTimestampEndMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'bookId': serializer.toJson<String>(bookId),
      'chapterNumber': serializer.toJson<int>(chapterNumber),
      'verseNumber': serializer.toJson<int>(verseNumber),
      'originalScriptText': serializer.toJson<String>(originalScriptText),
      'scriptType': serializer.toJson<String>(scriptType),
      'transliteration': serializer.toJson<String?>(transliteration),
      'wordMeanings': serializer.toJson<String?>(wordMeanings),
      'translation': serializer.toJson<String>(translation),
      'commentary': serializer.toJson<String?>(commentary),
      'audioTimestampStartMs': serializer.toJson<int?>(audioTimestampStartMs),
      'audioTimestampEndMs': serializer.toJson<int?>(audioTimestampEndMs),
    };
  }

  CachedVerse copyWith(
          {String? id,
          String? bookId,
          int? chapterNumber,
          int? verseNumber,
          String? originalScriptText,
          String? scriptType,
          Value<String?> transliteration = const Value.absent(),
          Value<String?> wordMeanings = const Value.absent(),
          String? translation,
          Value<String?> commentary = const Value.absent(),
          Value<int?> audioTimestampStartMs = const Value.absent(),
          Value<int?> audioTimestampEndMs = const Value.absent()}) =>
      CachedVerse(
        id: id ?? this.id,
        bookId: bookId ?? this.bookId,
        chapterNumber: chapterNumber ?? this.chapterNumber,
        verseNumber: verseNumber ?? this.verseNumber,
        originalScriptText: originalScriptText ?? this.originalScriptText,
        scriptType: scriptType ?? this.scriptType,
        transliteration: transliteration.present
            ? transliteration.value
            : this.transliteration,
        wordMeanings:
            wordMeanings.present ? wordMeanings.value : this.wordMeanings,
        translation: translation ?? this.translation,
        commentary: commentary.present ? commentary.value : this.commentary,
        audioTimestampStartMs: audioTimestampStartMs.present
            ? audioTimestampStartMs.value
            : this.audioTimestampStartMs,
        audioTimestampEndMs: audioTimestampEndMs.present
            ? audioTimestampEndMs.value
            : this.audioTimestampEndMs,
      );
  CachedVerse copyWithCompanion(CachedVersesCompanion data) {
    return CachedVerse(
      id: data.id.present ? data.id.value : this.id,
      bookId: data.bookId.present ? data.bookId.value : this.bookId,
      chapterNumber: data.chapterNumber.present
          ? data.chapterNumber.value
          : this.chapterNumber,
      verseNumber:
          data.verseNumber.present ? data.verseNumber.value : this.verseNumber,
      originalScriptText: data.originalScriptText.present
          ? data.originalScriptText.value
          : this.originalScriptText,
      scriptType:
          data.scriptType.present ? data.scriptType.value : this.scriptType,
      transliteration: data.transliteration.present
          ? data.transliteration.value
          : this.transliteration,
      wordMeanings: data.wordMeanings.present
          ? data.wordMeanings.value
          : this.wordMeanings,
      translation:
          data.translation.present ? data.translation.value : this.translation,
      commentary:
          data.commentary.present ? data.commentary.value : this.commentary,
      audioTimestampStartMs: data.audioTimestampStartMs.present
          ? data.audioTimestampStartMs.value
          : this.audioTimestampStartMs,
      audioTimestampEndMs: data.audioTimestampEndMs.present
          ? data.audioTimestampEndMs.value
          : this.audioTimestampEndMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedVerse(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('chapterNumber: $chapterNumber, ')
          ..write('verseNumber: $verseNumber, ')
          ..write('originalScriptText: $originalScriptText, ')
          ..write('scriptType: $scriptType, ')
          ..write('transliteration: $transliteration, ')
          ..write('wordMeanings: $wordMeanings, ')
          ..write('translation: $translation, ')
          ..write('commentary: $commentary, ')
          ..write('audioTimestampStartMs: $audioTimestampStartMs, ')
          ..write('audioTimestampEndMs: $audioTimestampEndMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      bookId,
      chapterNumber,
      verseNumber,
      originalScriptText,
      scriptType,
      transliteration,
      wordMeanings,
      translation,
      commentary,
      audioTimestampStartMs,
      audioTimestampEndMs);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedVerse &&
          other.id == this.id &&
          other.bookId == this.bookId &&
          other.chapterNumber == this.chapterNumber &&
          other.verseNumber == this.verseNumber &&
          other.originalScriptText == this.originalScriptText &&
          other.scriptType == this.scriptType &&
          other.transliteration == this.transliteration &&
          other.wordMeanings == this.wordMeanings &&
          other.translation == this.translation &&
          other.commentary == this.commentary &&
          other.audioTimestampStartMs == this.audioTimestampStartMs &&
          other.audioTimestampEndMs == this.audioTimestampEndMs);
}

class CachedVersesCompanion extends UpdateCompanion<CachedVerse> {
  final Value<String> id;
  final Value<String> bookId;
  final Value<int> chapterNumber;
  final Value<int> verseNumber;
  final Value<String> originalScriptText;
  final Value<String> scriptType;
  final Value<String?> transliteration;
  final Value<String?> wordMeanings;
  final Value<String> translation;
  final Value<String?> commentary;
  final Value<int?> audioTimestampStartMs;
  final Value<int?> audioTimestampEndMs;
  final Value<int> rowid;
  const CachedVersesCompanion({
    this.id = const Value.absent(),
    this.bookId = const Value.absent(),
    this.chapterNumber = const Value.absent(),
    this.verseNumber = const Value.absent(),
    this.originalScriptText = const Value.absent(),
    this.scriptType = const Value.absent(),
    this.transliteration = const Value.absent(),
    this.wordMeanings = const Value.absent(),
    this.translation = const Value.absent(),
    this.commentary = const Value.absent(),
    this.audioTimestampStartMs = const Value.absent(),
    this.audioTimestampEndMs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedVersesCompanion.insert({
    required String id,
    required String bookId,
    required int chapterNumber,
    required int verseNumber,
    required String originalScriptText,
    this.scriptType = const Value.absent(),
    this.transliteration = const Value.absent(),
    this.wordMeanings = const Value.absent(),
    required String translation,
    this.commentary = const Value.absent(),
    this.audioTimestampStartMs = const Value.absent(),
    this.audioTimestampEndMs = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        bookId = Value(bookId),
        chapterNumber = Value(chapterNumber),
        verseNumber = Value(verseNumber),
        originalScriptText = Value(originalScriptText),
        translation = Value(translation);
  static Insertable<CachedVerse> custom({
    Expression<String>? id,
    Expression<String>? bookId,
    Expression<int>? chapterNumber,
    Expression<int>? verseNumber,
    Expression<String>? originalScriptText,
    Expression<String>? scriptType,
    Expression<String>? transliteration,
    Expression<String>? wordMeanings,
    Expression<String>? translation,
    Expression<String>? commentary,
    Expression<int>? audioTimestampStartMs,
    Expression<int>? audioTimestampEndMs,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bookId != null) 'book_id': bookId,
      if (chapterNumber != null) 'chapter_number': chapterNumber,
      if (verseNumber != null) 'verse_number': verseNumber,
      if (originalScriptText != null)
        'original_script_text': originalScriptText,
      if (scriptType != null) 'script_type': scriptType,
      if (transliteration != null) 'transliteration': transliteration,
      if (wordMeanings != null) 'word_meanings': wordMeanings,
      if (translation != null) 'translation': translation,
      if (commentary != null) 'commentary': commentary,
      if (audioTimestampStartMs != null)
        'audio_timestamp_start_ms': audioTimestampStartMs,
      if (audioTimestampEndMs != null)
        'audio_timestamp_end_ms': audioTimestampEndMs,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedVersesCompanion copyWith(
      {Value<String>? id,
      Value<String>? bookId,
      Value<int>? chapterNumber,
      Value<int>? verseNumber,
      Value<String>? originalScriptText,
      Value<String>? scriptType,
      Value<String?>? transliteration,
      Value<String?>? wordMeanings,
      Value<String>? translation,
      Value<String?>? commentary,
      Value<int?>? audioTimestampStartMs,
      Value<int?>? audioTimestampEndMs,
      Value<int>? rowid}) {
    return CachedVersesCompanion(
      id: id ?? this.id,
      bookId: bookId ?? this.bookId,
      chapterNumber: chapterNumber ?? this.chapterNumber,
      verseNumber: verseNumber ?? this.verseNumber,
      originalScriptText: originalScriptText ?? this.originalScriptText,
      scriptType: scriptType ?? this.scriptType,
      transliteration: transliteration ?? this.transliteration,
      wordMeanings: wordMeanings ?? this.wordMeanings,
      translation: translation ?? this.translation,
      commentary: commentary ?? this.commentary,
      audioTimestampStartMs:
          audioTimestampStartMs ?? this.audioTimestampStartMs,
      audioTimestampEndMs: audioTimestampEndMs ?? this.audioTimestampEndMs,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (bookId.present) {
      map['book_id'] = Variable<String>(bookId.value);
    }
    if (chapterNumber.present) {
      map['chapter_number'] = Variable<int>(chapterNumber.value);
    }
    if (verseNumber.present) {
      map['verse_number'] = Variable<int>(verseNumber.value);
    }
    if (originalScriptText.present) {
      map['original_script_text'] = Variable<String>(originalScriptText.value);
    }
    if (scriptType.present) {
      map['script_type'] = Variable<String>(scriptType.value);
    }
    if (transliteration.present) {
      map['transliteration'] = Variable<String>(transliteration.value);
    }
    if (wordMeanings.present) {
      map['word_meanings'] = Variable<String>(wordMeanings.value);
    }
    if (translation.present) {
      map['translation'] = Variable<String>(translation.value);
    }
    if (commentary.present) {
      map['commentary'] = Variable<String>(commentary.value);
    }
    if (audioTimestampStartMs.present) {
      map['audio_timestamp_start_ms'] =
          Variable<int>(audioTimestampStartMs.value);
    }
    if (audioTimestampEndMs.present) {
      map['audio_timestamp_end_ms'] = Variable<int>(audioTimestampEndMs.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedVersesCompanion(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('chapterNumber: $chapterNumber, ')
          ..write('verseNumber: $verseNumber, ')
          ..write('originalScriptText: $originalScriptText, ')
          ..write('scriptType: $scriptType, ')
          ..write('transliteration: $transliteration, ')
          ..write('wordMeanings: $wordMeanings, ')
          ..write('translation: $translation, ')
          ..write('commentary: $commentary, ')
          ..write('audioTimestampStartMs: $audioTimestampStartMs, ')
          ..write('audioTimestampEndMs: $audioTimestampEndMs, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DownloadTasksTable extends DownloadTasks
    with TableInfo<$DownloadTasksTable, DownloadTask> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DownloadTasksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<String> bookId = GeneratedColumn<String>(
      'book_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fileUrlMeta =
      const VerificationMeta('fileUrl');
  @override
  late final GeneratedColumn<String> fileUrl = GeneratedColumn<String>(
      'file_url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _localPathMeta =
      const VerificationMeta('localPath');
  @override
  late final GeneratedColumn<String> localPath = GeneratedColumn<String>(
      'local_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _progressMeta =
      const VerificationMeta('progress');
  @override
  late final GeneratedColumn<double> progress = GeneratedColumn<double>(
      'progress', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _totalBytesMeta =
      const VerificationMeta('totalBytes');
  @override
  late final GeneratedColumn<int> totalBytes = GeneratedColumn<int>(
      'total_bytes', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _downloadedBytesMeta =
      const VerificationMeta('downloadedBytes');
  @override
  late final GeneratedColumn<int> downloadedBytes = GeneratedColumn<int>(
      'downloaded_bytes', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        bookId,
        title,
        fileUrl,
        localPath,
        progress,
        status,
        totalBytes,
        downloadedBytes,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'download_tasks';
  @override
  VerificationContext validateIntegrity(Insertable<DownloadTask> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('book_id')) {
      context.handle(_bookIdMeta,
          bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta));
    } else if (isInserting) {
      context.missing(_bookIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('file_url')) {
      context.handle(_fileUrlMeta,
          fileUrl.isAcceptableOrUnknown(data['file_url']!, _fileUrlMeta));
    } else if (isInserting) {
      context.missing(_fileUrlMeta);
    }
    if (data.containsKey('local_path')) {
      context.handle(_localPathMeta,
          localPath.isAcceptableOrUnknown(data['local_path']!, _localPathMeta));
    } else if (isInserting) {
      context.missing(_localPathMeta);
    }
    if (data.containsKey('progress')) {
      context.handle(_progressMeta,
          progress.isAcceptableOrUnknown(data['progress']!, _progressMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('total_bytes')) {
      context.handle(
          _totalBytesMeta,
          totalBytes.isAcceptableOrUnknown(
              data['total_bytes']!, _totalBytesMeta));
    }
    if (data.containsKey('downloaded_bytes')) {
      context.handle(
          _downloadedBytesMeta,
          downloadedBytes.isAcceptableOrUnknown(
              data['downloaded_bytes']!, _downloadedBytesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DownloadTask map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DownloadTask(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      bookId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}book_id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      fileUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}file_url'])!,
      localPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}local_path'])!,
      progress: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}progress'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      totalBytes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_bytes'])!,
      downloadedBytes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}downloaded_bytes'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $DownloadTasksTable createAlias(String alias) {
    return $DownloadTasksTable(attachedDatabase, alias);
  }
}

class DownloadTask extends DataClass implements Insertable<DownloadTask> {
  final String id;
  final String bookId;
  final String title;
  final String fileUrl;
  final String localPath;
  final double progress;
  final String status;
  final int totalBytes;
  final int downloadedBytes;
  final DateTime createdAt;
  const DownloadTask(
      {required this.id,
      required this.bookId,
      required this.title,
      required this.fileUrl,
      required this.localPath,
      required this.progress,
      required this.status,
      required this.totalBytes,
      required this.downloadedBytes,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['book_id'] = Variable<String>(bookId);
    map['title'] = Variable<String>(title);
    map['file_url'] = Variable<String>(fileUrl);
    map['local_path'] = Variable<String>(localPath);
    map['progress'] = Variable<double>(progress);
    map['status'] = Variable<String>(status);
    map['total_bytes'] = Variable<int>(totalBytes);
    map['downloaded_bytes'] = Variable<int>(downloadedBytes);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  DownloadTasksCompanion toCompanion(bool nullToAbsent) {
    return DownloadTasksCompanion(
      id: Value(id),
      bookId: Value(bookId),
      title: Value(title),
      fileUrl: Value(fileUrl),
      localPath: Value(localPath),
      progress: Value(progress),
      status: Value(status),
      totalBytes: Value(totalBytes),
      downloadedBytes: Value(downloadedBytes),
      createdAt: Value(createdAt),
    );
  }

  factory DownloadTask.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DownloadTask(
      id: serializer.fromJson<String>(json['id']),
      bookId: serializer.fromJson<String>(json['bookId']),
      title: serializer.fromJson<String>(json['title']),
      fileUrl: serializer.fromJson<String>(json['fileUrl']),
      localPath: serializer.fromJson<String>(json['localPath']),
      progress: serializer.fromJson<double>(json['progress']),
      status: serializer.fromJson<String>(json['status']),
      totalBytes: serializer.fromJson<int>(json['totalBytes']),
      downloadedBytes: serializer.fromJson<int>(json['downloadedBytes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'bookId': serializer.toJson<String>(bookId),
      'title': serializer.toJson<String>(title),
      'fileUrl': serializer.toJson<String>(fileUrl),
      'localPath': serializer.toJson<String>(localPath),
      'progress': serializer.toJson<double>(progress),
      'status': serializer.toJson<String>(status),
      'totalBytes': serializer.toJson<int>(totalBytes),
      'downloadedBytes': serializer.toJson<int>(downloadedBytes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  DownloadTask copyWith(
          {String? id,
          String? bookId,
          String? title,
          String? fileUrl,
          String? localPath,
          double? progress,
          String? status,
          int? totalBytes,
          int? downloadedBytes,
          DateTime? createdAt}) =>
      DownloadTask(
        id: id ?? this.id,
        bookId: bookId ?? this.bookId,
        title: title ?? this.title,
        fileUrl: fileUrl ?? this.fileUrl,
        localPath: localPath ?? this.localPath,
        progress: progress ?? this.progress,
        status: status ?? this.status,
        totalBytes: totalBytes ?? this.totalBytes,
        downloadedBytes: downloadedBytes ?? this.downloadedBytes,
        createdAt: createdAt ?? this.createdAt,
      );
  DownloadTask copyWithCompanion(DownloadTasksCompanion data) {
    return DownloadTask(
      id: data.id.present ? data.id.value : this.id,
      bookId: data.bookId.present ? data.bookId.value : this.bookId,
      title: data.title.present ? data.title.value : this.title,
      fileUrl: data.fileUrl.present ? data.fileUrl.value : this.fileUrl,
      localPath: data.localPath.present ? data.localPath.value : this.localPath,
      progress: data.progress.present ? data.progress.value : this.progress,
      status: data.status.present ? data.status.value : this.status,
      totalBytes:
          data.totalBytes.present ? data.totalBytes.value : this.totalBytes,
      downloadedBytes: data.downloadedBytes.present
          ? data.downloadedBytes.value
          : this.downloadedBytes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DownloadTask(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('title: $title, ')
          ..write('fileUrl: $fileUrl, ')
          ..write('localPath: $localPath, ')
          ..write('progress: $progress, ')
          ..write('status: $status, ')
          ..write('totalBytes: $totalBytes, ')
          ..write('downloadedBytes: $downloadedBytes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, bookId, title, fileUrl, localPath,
      progress, status, totalBytes, downloadedBytes, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DownloadTask &&
          other.id == this.id &&
          other.bookId == this.bookId &&
          other.title == this.title &&
          other.fileUrl == this.fileUrl &&
          other.localPath == this.localPath &&
          other.progress == this.progress &&
          other.status == this.status &&
          other.totalBytes == this.totalBytes &&
          other.downloadedBytes == this.downloadedBytes &&
          other.createdAt == this.createdAt);
}

class DownloadTasksCompanion extends UpdateCompanion<DownloadTask> {
  final Value<String> id;
  final Value<String> bookId;
  final Value<String> title;
  final Value<String> fileUrl;
  final Value<String> localPath;
  final Value<double> progress;
  final Value<String> status;
  final Value<int> totalBytes;
  final Value<int> downloadedBytes;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const DownloadTasksCompanion({
    this.id = const Value.absent(),
    this.bookId = const Value.absent(),
    this.title = const Value.absent(),
    this.fileUrl = const Value.absent(),
    this.localPath = const Value.absent(),
    this.progress = const Value.absent(),
    this.status = const Value.absent(),
    this.totalBytes = const Value.absent(),
    this.downloadedBytes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DownloadTasksCompanion.insert({
    required String id,
    required String bookId,
    required String title,
    required String fileUrl,
    required String localPath,
    this.progress = const Value.absent(),
    this.status = const Value.absent(),
    this.totalBytes = const Value.absent(),
    this.downloadedBytes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        bookId = Value(bookId),
        title = Value(title),
        fileUrl = Value(fileUrl),
        localPath = Value(localPath);
  static Insertable<DownloadTask> custom({
    Expression<String>? id,
    Expression<String>? bookId,
    Expression<String>? title,
    Expression<String>? fileUrl,
    Expression<String>? localPath,
    Expression<double>? progress,
    Expression<String>? status,
    Expression<int>? totalBytes,
    Expression<int>? downloadedBytes,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bookId != null) 'book_id': bookId,
      if (title != null) 'title': title,
      if (fileUrl != null) 'file_url': fileUrl,
      if (localPath != null) 'local_path': localPath,
      if (progress != null) 'progress': progress,
      if (status != null) 'status': status,
      if (totalBytes != null) 'total_bytes': totalBytes,
      if (downloadedBytes != null) 'downloaded_bytes': downloadedBytes,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DownloadTasksCompanion copyWith(
      {Value<String>? id,
      Value<String>? bookId,
      Value<String>? title,
      Value<String>? fileUrl,
      Value<String>? localPath,
      Value<double>? progress,
      Value<String>? status,
      Value<int>? totalBytes,
      Value<int>? downloadedBytes,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return DownloadTasksCompanion(
      id: id ?? this.id,
      bookId: bookId ?? this.bookId,
      title: title ?? this.title,
      fileUrl: fileUrl ?? this.fileUrl,
      localPath: localPath ?? this.localPath,
      progress: progress ?? this.progress,
      status: status ?? this.status,
      totalBytes: totalBytes ?? this.totalBytes,
      downloadedBytes: downloadedBytes ?? this.downloadedBytes,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (bookId.present) {
      map['book_id'] = Variable<String>(bookId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (fileUrl.present) {
      map['file_url'] = Variable<String>(fileUrl.value);
    }
    if (localPath.present) {
      map['local_path'] = Variable<String>(localPath.value);
    }
    if (progress.present) {
      map['progress'] = Variable<double>(progress.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (totalBytes.present) {
      map['total_bytes'] = Variable<int>(totalBytes.value);
    }
    if (downloadedBytes.present) {
      map['downloaded_bytes'] = Variable<int>(downloadedBytes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DownloadTasksCompanion(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('title: $title, ')
          ..write('fileUrl: $fileUrl, ')
          ..write('localPath: $localPath, ')
          ..write('progress: $progress, ')
          ..write('status: $status, ')
          ..write('totalBytes: $totalBytes, ')
          ..write('downloadedBytes: $downloadedBytes, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BookmarksTable extends Bookmarks
    with TableInfo<$BookmarksTable, Bookmark> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BookmarksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<String> bookId = GeneratedColumn<String>(
      'book_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _chapterMeta =
      const VerificationMeta('chapter');
  @override
  late final GeneratedColumn<int> chapter = GeneratedColumn<int>(
      'chapter', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _verseMeta = const VerificationMeta('verse');
  @override
  late final GeneratedColumn<int> verse = GeneratedColumn<int>(
      'verse', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, bookId, chapter, verse, note, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bookmarks';
  @override
  VerificationContext validateIntegrity(Insertable<Bookmark> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('book_id')) {
      context.handle(_bookIdMeta,
          bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta));
    } else if (isInserting) {
      context.missing(_bookIdMeta);
    }
    if (data.containsKey('chapter')) {
      context.handle(_chapterMeta,
          chapter.isAcceptableOrUnknown(data['chapter']!, _chapterMeta));
    } else if (isInserting) {
      context.missing(_chapterMeta);
    }
    if (data.containsKey('verse')) {
      context.handle(
          _verseMeta, verse.isAcceptableOrUnknown(data['verse']!, _verseMeta));
    } else if (isInserting) {
      context.missing(_verseMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Bookmark map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Bookmark(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      bookId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}book_id'])!,
      chapter: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}chapter'])!,
      verse: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}verse'])!,
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $BookmarksTable createAlias(String alias) {
    return $BookmarksTable(attachedDatabase, alias);
  }
}

class Bookmark extends DataClass implements Insertable<Bookmark> {
  final String id;
  final String bookId;
  final int chapter;
  final int verse;
  final String? note;
  final DateTime createdAt;
  const Bookmark(
      {required this.id,
      required this.bookId,
      required this.chapter,
      required this.verse,
      this.note,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['book_id'] = Variable<String>(bookId);
    map['chapter'] = Variable<int>(chapter);
    map['verse'] = Variable<int>(verse);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  BookmarksCompanion toCompanion(bool nullToAbsent) {
    return BookmarksCompanion(
      id: Value(id),
      bookId: Value(bookId),
      chapter: Value(chapter),
      verse: Value(verse),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
    );
  }

  factory Bookmark.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Bookmark(
      id: serializer.fromJson<String>(json['id']),
      bookId: serializer.fromJson<String>(json['bookId']),
      chapter: serializer.fromJson<int>(json['chapter']),
      verse: serializer.fromJson<int>(json['verse']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'bookId': serializer.toJson<String>(bookId),
      'chapter': serializer.toJson<int>(chapter),
      'verse': serializer.toJson<int>(verse),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Bookmark copyWith(
          {String? id,
          String? bookId,
          int? chapter,
          int? verse,
          Value<String?> note = const Value.absent(),
          DateTime? createdAt}) =>
      Bookmark(
        id: id ?? this.id,
        bookId: bookId ?? this.bookId,
        chapter: chapter ?? this.chapter,
        verse: verse ?? this.verse,
        note: note.present ? note.value : this.note,
        createdAt: createdAt ?? this.createdAt,
      );
  Bookmark copyWithCompanion(BookmarksCompanion data) {
    return Bookmark(
      id: data.id.present ? data.id.value : this.id,
      bookId: data.bookId.present ? data.bookId.value : this.bookId,
      chapter: data.chapter.present ? data.chapter.value : this.chapter,
      verse: data.verse.present ? data.verse.value : this.verse,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Bookmark(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('chapter: $chapter, ')
          ..write('verse: $verse, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, bookId, chapter, verse, note, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Bookmark &&
          other.id == this.id &&
          other.bookId == this.bookId &&
          other.chapter == this.chapter &&
          other.verse == this.verse &&
          other.note == this.note &&
          other.createdAt == this.createdAt);
}

class BookmarksCompanion extends UpdateCompanion<Bookmark> {
  final Value<String> id;
  final Value<String> bookId;
  final Value<int> chapter;
  final Value<int> verse;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const BookmarksCompanion({
    this.id = const Value.absent(),
    this.bookId = const Value.absent(),
    this.chapter = const Value.absent(),
    this.verse = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BookmarksCompanion.insert({
    required String id,
    required String bookId,
    required int chapter,
    required int verse,
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        bookId = Value(bookId),
        chapter = Value(chapter),
        verse = Value(verse);
  static Insertable<Bookmark> custom({
    Expression<String>? id,
    Expression<String>? bookId,
    Expression<int>? chapter,
    Expression<int>? verse,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bookId != null) 'book_id': bookId,
      if (chapter != null) 'chapter': chapter,
      if (verse != null) 'verse': verse,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BookmarksCompanion copyWith(
      {Value<String>? id,
      Value<String>? bookId,
      Value<int>? chapter,
      Value<int>? verse,
      Value<String?>? note,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return BookmarksCompanion(
      id: id ?? this.id,
      bookId: bookId ?? this.bookId,
      chapter: chapter ?? this.chapter,
      verse: verse ?? this.verse,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (bookId.present) {
      map['book_id'] = Variable<String>(bookId.value);
    }
    if (chapter.present) {
      map['chapter'] = Variable<int>(chapter.value);
    }
    if (verse.present) {
      map['verse'] = Variable<int>(verse.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BookmarksCompanion(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('chapter: $chapter, ')
          ..write('verse: $verse, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CachedBooksTable cachedBooks = $CachedBooksTable(this);
  late final $CachedVersesTable cachedVerses = $CachedVersesTable(this);
  late final $DownloadTasksTable downloadTasks = $DownloadTasksTable(this);
  late final $BookmarksTable bookmarks = $BookmarksTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [cachedBooks, cachedVerses, downloadTasks, bookmarks];
}

typedef $$CachedBooksTableCreateCompanionBuilder = CachedBooksCompanion
    Function({
  required String id,
  required String title,
  required String author,
  required String category,
  required String language,
  required String description,
  Value<String?> coverUrl,
  Value<String?> fileUrl,
  Value<String?> localFilePath,
  Value<String> format,
  Value<int> totalVerses,
  Value<bool> isFavorite,
  Value<DateTime> cachedAt,
  Value<int> rowid,
});
typedef $$CachedBooksTableUpdateCompanionBuilder = CachedBooksCompanion
    Function({
  Value<String> id,
  Value<String> title,
  Value<String> author,
  Value<String> category,
  Value<String> language,
  Value<String> description,
  Value<String?> coverUrl,
  Value<String?> fileUrl,
  Value<String?> localFilePath,
  Value<String> format,
  Value<int> totalVerses,
  Value<bool> isFavorite,
  Value<DateTime> cachedAt,
  Value<int> rowid,
});

class $$CachedBooksTableFilterComposer
    extends Composer<_$AppDatabase, $CachedBooksTable> {
  $$CachedBooksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get author => $composableBuilder(
      column: $table.author, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get language => $composableBuilder(
      column: $table.language, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get coverUrl => $composableBuilder(
      column: $table.coverUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fileUrl => $composableBuilder(
      column: $table.fileUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get localFilePath => $composableBuilder(
      column: $table.localFilePath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get format => $composableBuilder(
      column: $table.format, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalVerses => $composableBuilder(
      column: $table.totalVerses, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isFavorite => $composableBuilder(
      column: $table.isFavorite, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
      column: $table.cachedAt, builder: (column) => ColumnFilters(column));
}

class $$CachedBooksTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedBooksTable> {
  $$CachedBooksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get author => $composableBuilder(
      column: $table.author, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get language => $composableBuilder(
      column: $table.language, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get coverUrl => $composableBuilder(
      column: $table.coverUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fileUrl => $composableBuilder(
      column: $table.fileUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get localFilePath => $composableBuilder(
      column: $table.localFilePath,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get format => $composableBuilder(
      column: $table.format, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalVerses => $composableBuilder(
      column: $table.totalVerses, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
      column: $table.isFavorite, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
      column: $table.cachedAt, builder: (column) => ColumnOrderings(column));
}

class $$CachedBooksTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedBooksTable> {
  $$CachedBooksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get author =>
      $composableBuilder(column: $table.author, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get language =>
      $composableBuilder(column: $table.language, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get coverUrl =>
      $composableBuilder(column: $table.coverUrl, builder: (column) => column);

  GeneratedColumn<String> get fileUrl =>
      $composableBuilder(column: $table.fileUrl, builder: (column) => column);

  GeneratedColumn<String> get localFilePath => $composableBuilder(
      column: $table.localFilePath, builder: (column) => column);

  GeneratedColumn<String> get format =>
      $composableBuilder(column: $table.format, builder: (column) => column);

  GeneratedColumn<int> get totalVerses => $composableBuilder(
      column: $table.totalVerses, builder: (column) => column);

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
      column: $table.isFavorite, builder: (column) => column);

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);
}

class $$CachedBooksTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CachedBooksTable,
    CachedBook,
    $$CachedBooksTableFilterComposer,
    $$CachedBooksTableOrderingComposer,
    $$CachedBooksTableAnnotationComposer,
    $$CachedBooksTableCreateCompanionBuilder,
    $$CachedBooksTableUpdateCompanionBuilder,
    (CachedBook, BaseReferences<_$AppDatabase, $CachedBooksTable, CachedBook>),
    CachedBook,
    PrefetchHooks Function()> {
  $$CachedBooksTableTableManager(_$AppDatabase db, $CachedBooksTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedBooksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedBooksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedBooksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> author = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<String> language = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<String?> coverUrl = const Value.absent(),
            Value<String?> fileUrl = const Value.absent(),
            Value<String?> localFilePath = const Value.absent(),
            Value<String> format = const Value.absent(),
            Value<int> totalVerses = const Value.absent(),
            Value<bool> isFavorite = const Value.absent(),
            Value<DateTime> cachedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedBooksCompanion(
            id: id,
            title: title,
            author: author,
            category: category,
            language: language,
            description: description,
            coverUrl: coverUrl,
            fileUrl: fileUrl,
            localFilePath: localFilePath,
            format: format,
            totalVerses: totalVerses,
            isFavorite: isFavorite,
            cachedAt: cachedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            required String author,
            required String category,
            required String language,
            required String description,
            Value<String?> coverUrl = const Value.absent(),
            Value<String?> fileUrl = const Value.absent(),
            Value<String?> localFilePath = const Value.absent(),
            Value<String> format = const Value.absent(),
            Value<int> totalVerses = const Value.absent(),
            Value<bool> isFavorite = const Value.absent(),
            Value<DateTime> cachedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedBooksCompanion.insert(
            id: id,
            title: title,
            author: author,
            category: category,
            language: language,
            description: description,
            coverUrl: coverUrl,
            fileUrl: fileUrl,
            localFilePath: localFilePath,
            format: format,
            totalVerses: totalVerses,
            isFavorite: isFavorite,
            cachedAt: cachedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CachedBooksTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CachedBooksTable,
    CachedBook,
    $$CachedBooksTableFilterComposer,
    $$CachedBooksTableOrderingComposer,
    $$CachedBooksTableAnnotationComposer,
    $$CachedBooksTableCreateCompanionBuilder,
    $$CachedBooksTableUpdateCompanionBuilder,
    (CachedBook, BaseReferences<_$AppDatabase, $CachedBooksTable, CachedBook>),
    CachedBook,
    PrefetchHooks Function()>;
typedef $$CachedVersesTableCreateCompanionBuilder = CachedVersesCompanion
    Function({
  required String id,
  required String bookId,
  required int chapterNumber,
  required int verseNumber,
  required String originalScriptText,
  Value<String> scriptType,
  Value<String?> transliteration,
  Value<String?> wordMeanings,
  required String translation,
  Value<String?> commentary,
  Value<int?> audioTimestampStartMs,
  Value<int?> audioTimestampEndMs,
  Value<int> rowid,
});
typedef $$CachedVersesTableUpdateCompanionBuilder = CachedVersesCompanion
    Function({
  Value<String> id,
  Value<String> bookId,
  Value<int> chapterNumber,
  Value<int> verseNumber,
  Value<String> originalScriptText,
  Value<String> scriptType,
  Value<String?> transliteration,
  Value<String?> wordMeanings,
  Value<String> translation,
  Value<String?> commentary,
  Value<int?> audioTimestampStartMs,
  Value<int?> audioTimestampEndMs,
  Value<int> rowid,
});

class $$CachedVersesTableFilterComposer
    extends Composer<_$AppDatabase, $CachedVersesTable> {
  $$CachedVersesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get bookId => $composableBuilder(
      column: $table.bookId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get chapterNumber => $composableBuilder(
      column: $table.chapterNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get verseNumber => $composableBuilder(
      column: $table.verseNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get originalScriptText => $composableBuilder(
      column: $table.originalScriptText,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get scriptType => $composableBuilder(
      column: $table.scriptType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get transliteration => $composableBuilder(
      column: $table.transliteration,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get wordMeanings => $composableBuilder(
      column: $table.wordMeanings, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get translation => $composableBuilder(
      column: $table.translation, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get commentary => $composableBuilder(
      column: $table.commentary, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get audioTimestampStartMs => $composableBuilder(
      column: $table.audioTimestampStartMs,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get audioTimestampEndMs => $composableBuilder(
      column: $table.audioTimestampEndMs,
      builder: (column) => ColumnFilters(column));
}

class $$CachedVersesTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedVersesTable> {
  $$CachedVersesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get bookId => $composableBuilder(
      column: $table.bookId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get chapterNumber => $composableBuilder(
      column: $table.chapterNumber,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get verseNumber => $composableBuilder(
      column: $table.verseNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get originalScriptText => $composableBuilder(
      column: $table.originalScriptText,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get scriptType => $composableBuilder(
      column: $table.scriptType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get transliteration => $composableBuilder(
      column: $table.transliteration,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get wordMeanings => $composableBuilder(
      column: $table.wordMeanings,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get translation => $composableBuilder(
      column: $table.translation, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get commentary => $composableBuilder(
      column: $table.commentary, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get audioTimestampStartMs => $composableBuilder(
      column: $table.audioTimestampStartMs,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get audioTimestampEndMs => $composableBuilder(
      column: $table.audioTimestampEndMs,
      builder: (column) => ColumnOrderings(column));
}

class $$CachedVersesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedVersesTable> {
  $$CachedVersesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get bookId =>
      $composableBuilder(column: $table.bookId, builder: (column) => column);

  GeneratedColumn<int> get chapterNumber => $composableBuilder(
      column: $table.chapterNumber, builder: (column) => column);

  GeneratedColumn<int> get verseNumber => $composableBuilder(
      column: $table.verseNumber, builder: (column) => column);

  GeneratedColumn<String> get originalScriptText => $composableBuilder(
      column: $table.originalScriptText, builder: (column) => column);

  GeneratedColumn<String> get scriptType => $composableBuilder(
      column: $table.scriptType, builder: (column) => column);

  GeneratedColumn<String> get transliteration => $composableBuilder(
      column: $table.transliteration, builder: (column) => column);

  GeneratedColumn<String> get wordMeanings => $composableBuilder(
      column: $table.wordMeanings, builder: (column) => column);

  GeneratedColumn<String> get translation => $composableBuilder(
      column: $table.translation, builder: (column) => column);

  GeneratedColumn<String> get commentary => $composableBuilder(
      column: $table.commentary, builder: (column) => column);

  GeneratedColumn<int> get audioTimestampStartMs => $composableBuilder(
      column: $table.audioTimestampStartMs, builder: (column) => column);

  GeneratedColumn<int> get audioTimestampEndMs => $composableBuilder(
      column: $table.audioTimestampEndMs, builder: (column) => column);
}

class $$CachedVersesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CachedVersesTable,
    CachedVerse,
    $$CachedVersesTableFilterComposer,
    $$CachedVersesTableOrderingComposer,
    $$CachedVersesTableAnnotationComposer,
    $$CachedVersesTableCreateCompanionBuilder,
    $$CachedVersesTableUpdateCompanionBuilder,
    (
      CachedVerse,
      BaseReferences<_$AppDatabase, $CachedVersesTable, CachedVerse>
    ),
    CachedVerse,
    PrefetchHooks Function()> {
  $$CachedVersesTableTableManager(_$AppDatabase db, $CachedVersesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedVersesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedVersesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedVersesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> bookId = const Value.absent(),
            Value<int> chapterNumber = const Value.absent(),
            Value<int> verseNumber = const Value.absent(),
            Value<String> originalScriptText = const Value.absent(),
            Value<String> scriptType = const Value.absent(),
            Value<String?> transliteration = const Value.absent(),
            Value<String?> wordMeanings = const Value.absent(),
            Value<String> translation = const Value.absent(),
            Value<String?> commentary = const Value.absent(),
            Value<int?> audioTimestampStartMs = const Value.absent(),
            Value<int?> audioTimestampEndMs = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedVersesCompanion(
            id: id,
            bookId: bookId,
            chapterNumber: chapterNumber,
            verseNumber: verseNumber,
            originalScriptText: originalScriptText,
            scriptType: scriptType,
            transliteration: transliteration,
            wordMeanings: wordMeanings,
            translation: translation,
            commentary: commentary,
            audioTimestampStartMs: audioTimestampStartMs,
            audioTimestampEndMs: audioTimestampEndMs,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String bookId,
            required int chapterNumber,
            required int verseNumber,
            required String originalScriptText,
            Value<String> scriptType = const Value.absent(),
            Value<String?> transliteration = const Value.absent(),
            Value<String?> wordMeanings = const Value.absent(),
            required String translation,
            Value<String?> commentary = const Value.absent(),
            Value<int?> audioTimestampStartMs = const Value.absent(),
            Value<int?> audioTimestampEndMs = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CachedVersesCompanion.insert(
            id: id,
            bookId: bookId,
            chapterNumber: chapterNumber,
            verseNumber: verseNumber,
            originalScriptText: originalScriptText,
            scriptType: scriptType,
            transliteration: transliteration,
            wordMeanings: wordMeanings,
            translation: translation,
            commentary: commentary,
            audioTimestampStartMs: audioTimestampStartMs,
            audioTimestampEndMs: audioTimestampEndMs,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CachedVersesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CachedVersesTable,
    CachedVerse,
    $$CachedVersesTableFilterComposer,
    $$CachedVersesTableOrderingComposer,
    $$CachedVersesTableAnnotationComposer,
    $$CachedVersesTableCreateCompanionBuilder,
    $$CachedVersesTableUpdateCompanionBuilder,
    (
      CachedVerse,
      BaseReferences<_$AppDatabase, $CachedVersesTable, CachedVerse>
    ),
    CachedVerse,
    PrefetchHooks Function()>;
typedef $$DownloadTasksTableCreateCompanionBuilder = DownloadTasksCompanion
    Function({
  required String id,
  required String bookId,
  required String title,
  required String fileUrl,
  required String localPath,
  Value<double> progress,
  Value<String> status,
  Value<int> totalBytes,
  Value<int> downloadedBytes,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$DownloadTasksTableUpdateCompanionBuilder = DownloadTasksCompanion
    Function({
  Value<String> id,
  Value<String> bookId,
  Value<String> title,
  Value<String> fileUrl,
  Value<String> localPath,
  Value<double> progress,
  Value<String> status,
  Value<int> totalBytes,
  Value<int> downloadedBytes,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$DownloadTasksTableFilterComposer
    extends Composer<_$AppDatabase, $DownloadTasksTable> {
  $$DownloadTasksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get bookId => $composableBuilder(
      column: $table.bookId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fileUrl => $composableBuilder(
      column: $table.fileUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get localPath => $composableBuilder(
      column: $table.localPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get progress => $composableBuilder(
      column: $table.progress, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalBytes => $composableBuilder(
      column: $table.totalBytes, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get downloadedBytes => $composableBuilder(
      column: $table.downloadedBytes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$DownloadTasksTableOrderingComposer
    extends Composer<_$AppDatabase, $DownloadTasksTable> {
  $$DownloadTasksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get bookId => $composableBuilder(
      column: $table.bookId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fileUrl => $composableBuilder(
      column: $table.fileUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get localPath => $composableBuilder(
      column: $table.localPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get progress => $composableBuilder(
      column: $table.progress, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalBytes => $composableBuilder(
      column: $table.totalBytes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get downloadedBytes => $composableBuilder(
      column: $table.downloadedBytes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$DownloadTasksTableAnnotationComposer
    extends Composer<_$AppDatabase, $DownloadTasksTable> {
  $$DownloadTasksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get bookId =>
      $composableBuilder(column: $table.bookId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get fileUrl =>
      $composableBuilder(column: $table.fileUrl, builder: (column) => column);

  GeneratedColumn<String> get localPath =>
      $composableBuilder(column: $table.localPath, builder: (column) => column);

  GeneratedColumn<double> get progress =>
      $composableBuilder(column: $table.progress, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get totalBytes => $composableBuilder(
      column: $table.totalBytes, builder: (column) => column);

  GeneratedColumn<int> get downloadedBytes => $composableBuilder(
      column: $table.downloadedBytes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$DownloadTasksTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DownloadTasksTable,
    DownloadTask,
    $$DownloadTasksTableFilterComposer,
    $$DownloadTasksTableOrderingComposer,
    $$DownloadTasksTableAnnotationComposer,
    $$DownloadTasksTableCreateCompanionBuilder,
    $$DownloadTasksTableUpdateCompanionBuilder,
    (
      DownloadTask,
      BaseReferences<_$AppDatabase, $DownloadTasksTable, DownloadTask>
    ),
    DownloadTask,
    PrefetchHooks Function()> {
  $$DownloadTasksTableTableManager(_$AppDatabase db, $DownloadTasksTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DownloadTasksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DownloadTasksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DownloadTasksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> bookId = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> fileUrl = const Value.absent(),
            Value<String> localPath = const Value.absent(),
            Value<double> progress = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int> totalBytes = const Value.absent(),
            Value<int> downloadedBytes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DownloadTasksCompanion(
            id: id,
            bookId: bookId,
            title: title,
            fileUrl: fileUrl,
            localPath: localPath,
            progress: progress,
            status: status,
            totalBytes: totalBytes,
            downloadedBytes: downloadedBytes,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String bookId,
            required String title,
            required String fileUrl,
            required String localPath,
            Value<double> progress = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int> totalBytes = const Value.absent(),
            Value<int> downloadedBytes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DownloadTasksCompanion.insert(
            id: id,
            bookId: bookId,
            title: title,
            fileUrl: fileUrl,
            localPath: localPath,
            progress: progress,
            status: status,
            totalBytes: totalBytes,
            downloadedBytes: downloadedBytes,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DownloadTasksTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DownloadTasksTable,
    DownloadTask,
    $$DownloadTasksTableFilterComposer,
    $$DownloadTasksTableOrderingComposer,
    $$DownloadTasksTableAnnotationComposer,
    $$DownloadTasksTableCreateCompanionBuilder,
    $$DownloadTasksTableUpdateCompanionBuilder,
    (
      DownloadTask,
      BaseReferences<_$AppDatabase, $DownloadTasksTable, DownloadTask>
    ),
    DownloadTask,
    PrefetchHooks Function()>;
typedef $$BookmarksTableCreateCompanionBuilder = BookmarksCompanion Function({
  required String id,
  required String bookId,
  required int chapter,
  required int verse,
  Value<String?> note,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$BookmarksTableUpdateCompanionBuilder = BookmarksCompanion Function({
  Value<String> id,
  Value<String> bookId,
  Value<int> chapter,
  Value<int> verse,
  Value<String?> note,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$BookmarksTableFilterComposer
    extends Composer<_$AppDatabase, $BookmarksTable> {
  $$BookmarksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get bookId => $composableBuilder(
      column: $table.bookId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get chapter => $composableBuilder(
      column: $table.chapter, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get verse => $composableBuilder(
      column: $table.verse, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$BookmarksTableOrderingComposer
    extends Composer<_$AppDatabase, $BookmarksTable> {
  $$BookmarksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get bookId => $composableBuilder(
      column: $table.bookId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get chapter => $composableBuilder(
      column: $table.chapter, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get verse => $composableBuilder(
      column: $table.verse, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$BookmarksTableAnnotationComposer
    extends Composer<_$AppDatabase, $BookmarksTable> {
  $$BookmarksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get bookId =>
      $composableBuilder(column: $table.bookId, builder: (column) => column);

  GeneratedColumn<int> get chapter =>
      $composableBuilder(column: $table.chapter, builder: (column) => column);

  GeneratedColumn<int> get verse =>
      $composableBuilder(column: $table.verse, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$BookmarksTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BookmarksTable,
    Bookmark,
    $$BookmarksTableFilterComposer,
    $$BookmarksTableOrderingComposer,
    $$BookmarksTableAnnotationComposer,
    $$BookmarksTableCreateCompanionBuilder,
    $$BookmarksTableUpdateCompanionBuilder,
    (Bookmark, BaseReferences<_$AppDatabase, $BookmarksTable, Bookmark>),
    Bookmark,
    PrefetchHooks Function()> {
  $$BookmarksTableTableManager(_$AppDatabase db, $BookmarksTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BookmarksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BookmarksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BookmarksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> bookId = const Value.absent(),
            Value<int> chapter = const Value.absent(),
            Value<int> verse = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              BookmarksCompanion(
            id: id,
            bookId: bookId,
            chapter: chapter,
            verse: verse,
            note: note,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String bookId,
            required int chapter,
            required int verse,
            Value<String?> note = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              BookmarksCompanion.insert(
            id: id,
            bookId: bookId,
            chapter: chapter,
            verse: verse,
            note: note,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$BookmarksTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BookmarksTable,
    Bookmark,
    $$BookmarksTableFilterComposer,
    $$BookmarksTableOrderingComposer,
    $$BookmarksTableAnnotationComposer,
    $$BookmarksTableCreateCompanionBuilder,
    $$BookmarksTableUpdateCompanionBuilder,
    (Bookmark, BaseReferences<_$AppDatabase, $BookmarksTable, Bookmark>),
    Bookmark,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CachedBooksTableTableManager get cachedBooks =>
      $$CachedBooksTableTableManager(_db, _db.cachedBooks);
  $$CachedVersesTableTableManager get cachedVerses =>
      $$CachedVersesTableTableManager(_db, _db.cachedVerses);
  $$DownloadTasksTableTableManager get downloadTasks =>
      $$DownloadTasksTableTableManager(_db, _db.downloadTasks);
  $$BookmarksTableTableManager get bookmarks =>
      $$BookmarksTableTableManager(_db, _db.bookmarks);
}
