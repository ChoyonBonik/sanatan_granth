-- =============================================================================
-- Migration: 001_initial_schema.sql
-- Description: Complete initial schema for Sanatan Granth (সনাতন গ্রন্থ)
-- Tables: profiles, books, chapters, verses, reading_progress, bookmarks
-- Features: Row-Level Security (RLS), Role-Based Permissions, Storage Buckets
-- =============================================================================

-- 1. Enable Required Extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- -----------------------------------------------------------------------------
-- 2. ENUM TYPES & DOMAINS
-- -----------------------------------------------------------------------------
DO $$ BEGIN
    CREATE TYPE user_role AS ENUM ('user', 'moderator', 'admin');
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

DO $$ BEGIN
    CREATE TYPE book_category AS ENUM ('Veda', 'Upanishad', 'Itihasa', 'Purana', 'Stotra', 'Gita');
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

DO $$ BEGIN
    CREATE TYPE format_type AS ENUM ('structured', 'pdf', 'epub');
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

DO $$ BEGIN
    CREATE TYPE submission_status AS ENUM ('pending', 'approved', 'rejected');
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

-- -----------------------------------------------------------------------------
-- 3. TABLES DEFINITION
-- -----------------------------------------------------------------------------

-- 3.1 Profiles Table (Linked to Supabase Auth)
CREATE TABLE IF NOT EXISTS public.profiles (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    full_name TEXT NOT NULL DEFAULT '',
    avatar_url TEXT,
    role user_role NOT NULL DEFAULT 'user',
    contribution_count INT NOT NULL DEFAULT 0 CHECK (contribution_count >= 0),
    created_at TIMESTAMPTZ NOT NULL DEFAULT timezone('utc'::text, now()),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT timezone('utc'::text, now())
);

-- 3.2 Books Table
CREATE TABLE IF NOT EXISTS public.books (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title TEXT NOT NULL,
    subtitle TEXT,
    author_rishi TEXT NOT NULL,
    category book_category NOT NULL,
    language TEXT NOT NULL DEFAULT 'Bengali',
    format_type format_type NOT NULL DEFAULT 'structured',
    file_url TEXT,
    cover_url TEXT,
    status submission_status NOT NULL DEFAULT 'pending',
    contributor_id UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT timezone('utc'::text, now()),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT timezone('utc'::text, now())
);

-- 3.3 Chapters Table
CREATE TABLE IF NOT EXISTS public.chapters (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    book_id UUID NOT NULL REFERENCES public.books(id) ON DELETE CASCADE,
    chapter_number INT NOT NULL CHECK (chapter_number > 0),
    title TEXT NOT NULL,
    audio_url TEXT,
    duration_seconds INT NOT NULL DEFAULT 0 CHECK (duration_seconds >= 0),
    created_at TIMESTAMPTZ NOT NULL DEFAULT timezone('utc'::text, now()),
    CONSTRAINT uq_book_chapter_number UNIQUE (book_id, chapter_number)
);

-- 3.4 Verses Table
CREATE TABLE IF NOT EXISTS public.verses (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    chapter_id UUID NOT NULL REFERENCES public.chapters(id) ON DELETE CASCADE,
    verse_number INT NOT NULL CHECK (verse_number > 0),
    original_script TEXT NOT NULL,
    transliteration TEXT,
    translation TEXT NOT NULL,
    commentary TEXT,
    audio_start_ms INT CHECK (audio_start_ms >= 0),
    audio_end_ms INT CHECK (audio_end_ms >= 0),
    created_at TIMESTAMPTZ NOT NULL DEFAULT timezone('utc'::text, now()),
    CONSTRAINT uq_chapter_verse_number UNIQUE (chapter_id, verse_number)
);

-- 3.5 Reading Progress Table
CREATE TABLE IF NOT EXISTS public.reading_progress (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
    book_id UUID NOT NULL REFERENCES public.books(id) ON DELETE CASCADE,
    chapter_id UUID REFERENCES public.chapters(id) ON DELETE SET NULL,
    last_verse_or_page INT NOT NULL DEFAULT 1 CHECK (last_verse_or_page >= 1),
    audio_position_ms INT NOT NULL DEFAULT 0 CHECK (audio_position_ms >= 0),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT timezone('utc'::text, now()),
    CONSTRAINT uq_user_book_progress UNIQUE (user_id, book_id)
);

-- 3.6 Bookmarks Table
CREATE TABLE IF NOT EXISTS public.bookmarks (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
    book_id UUID NOT NULL REFERENCES public.books(id) ON DELETE CASCADE,
    chapter_id UUID REFERENCES public.chapters(id) ON DELETE SET NULL,
    verse_or_page INT NOT NULL CHECK (verse_or_page >= 1),
    note TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT timezone('utc'::text, now())
);

-- -----------------------------------------------------------------------------
-- 4. PERFORMANCE INDEXES
-- -----------------------------------------------------------------------------
CREATE INDEX IF NOT EXISTS idx_profiles_role ON public.profiles(role);
CREATE INDEX IF NOT EXISTS idx_books_status ON public.books(status);
CREATE INDEX IF NOT EXISTS idx_books_category ON public.books(category);
CREATE INDEX IF NOT EXISTS idx_books_contributor ON public.books(contributor_id);
CREATE INDEX IF NOT EXISTS idx_chapters_book_id ON public.chapters(book_id);
CREATE INDEX IF NOT EXISTS idx_verses_chapter_id ON public.verses(chapter_id);
CREATE INDEX IF NOT EXISTS idx_reading_progress_user ON public.reading_progress(user_id);
CREATE INDEX IF NOT EXISTS idx_reading_progress_book ON public.reading_progress(book_id);
CREATE INDEX IF NOT EXISTS idx_bookmarks_user ON public.bookmarks(user_id);
CREATE INDEX IF NOT EXISTS idx_bookmarks_book ON public.bookmarks(book_id);

-- -----------------------------------------------------------------------------
-- 5. HELPER FUNCTIONS & TRIGGERS
-- -----------------------------------------------------------------------------

-- Helper function: Check if current auth user is admin or moderator
CREATE OR REPLACE FUNCTION public.is_admin_or_mod()
RETURNS BOOLEAN
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = public
AS $$
    SELECT EXISTS (
        SELECT 1 FROM public.profiles
        WHERE id = auth.uid()
          AND role IN ('admin', 'moderator')
    );
$$;

-- Trigger: Automatically update 'updated_at' column
CREATE OR REPLACE FUNCTION public.update_updated_at_column()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    NEW.updated_at = timezone('utc'::text, now());
    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_profiles_updated_at ON public.profiles;
CREATE TRIGGER trg_profiles_updated_at
    BEFORE UPDATE ON public.profiles
    FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

DROP TRIGGER IF EXISTS trg_books_updated_at ON public.books;
CREATE TRIGGER trg_books_updated_at
    BEFORE UPDATE ON public.books
    FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

DROP TRIGGER IF EXISTS trg_reading_progress_updated_at ON public.reading_progress;
CREATE TRIGGER trg_reading_progress_updated_at
    BEFORE UPDATE ON public.reading_progress
    FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

-- Trigger: Automatically create public.profiles entry upon auth.users signup
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
    INSERT INTO public.profiles (id, full_name, avatar_url, role)
    VALUES (
        NEW.id,
        COALESCE(NEW.raw_user_meta_data->>'full_name', NEW.raw_user_meta_data->>'name', ''),
        COALESCE(NEW.raw_user_meta_data->>'avatar_url', ''),
        'user'
    );
    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
    AFTER INSERT ON auth.users
    FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- Trigger: Increment contribution_count when a book is approved
CREATE OR REPLACE FUNCTION public.handle_book_approval_contribution()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
    IF (NEW.status = 'approved' AND (OLD IS NULL OR OLD.status <> 'approved') AND NEW.contributor_id IS NOT NULL) THEN
        UPDATE public.profiles
        SET contribution_count = contribution_count + 1
        WHERE id = NEW.contributor_id;
    ELSIF (OLD IS NOT NULL AND OLD.status = 'approved' AND NEW.status <> 'approved' AND OLD.contributor_id IS NOT NULL) THEN
        UPDATE public.profiles
        SET contribution_count = GREATEST(contribution_count - 1, 0)
        WHERE id = OLD.contributor_id;
    END IF;
    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_book_contribution_count ON public.books;
CREATE TRIGGER trg_book_contribution_count
    AFTER INSERT OR UPDATE OF status ON public.books
    FOR EACH ROW EXECUTE FUNCTION public.handle_book_approval_contribution();

-- -----------------------------------------------------------------------------
-- 6. ROW-LEVEL SECURITY (RLS) POLICIES
-- -----------------------------------------------------------------------------

ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.books ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.chapters ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.verses ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.reading_progress ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.bookmarks ENABLE ROW LEVEL SECURITY;

-- 6.1 Profiles Policies
CREATE POLICY "Public profiles are viewable by everyone"
    ON public.profiles FOR SELECT
    USING (true);

CREATE POLICY "Users can update their own profile"
    ON public.profiles FOR UPDATE
    TO authenticated
    USING (auth.uid() = id)
    WITH CHECK (
        auth.uid() = id
        AND (role = (SELECT role FROM public.profiles WHERE id = auth.uid()) OR public.is_admin_or_mod())
    );

-- 6.2 Books Policies
-- Rule 1: Anyone can read books where status = 'approved'
CREATE POLICY "Anyone can view approved books"
    ON public.books FOR SELECT
    USING (status = 'approved');

-- Rule 2: Authenticated users can view their own pending/rejected submissions
CREATE POLICY "Contributors can view own submissions"
    ON public.books FOR SELECT
    TO authenticated
    USING (contributor_id = auth.uid());

-- Rule 3: Moderators and Admins can view all books
CREATE POLICY "Moderators and admins can view all books"
    ON public.books FOR SELECT
    TO authenticated
    USING (public.is_admin_or_mod());

-- Rule 4: Authenticated users can insert books with status = 'pending'
CREATE POLICY "Authenticated users can submit books as pending"
    ON public.books FOR INSERT
    TO authenticated
    WITH CHECK (
        auth.uid() = contributor_id
        AND status = 'pending'
    );

-- Rule 5: Contributors can update their own pending books
CREATE POLICY "Contributors can edit own pending books"
    ON public.books FOR UPDATE
    TO authenticated
    USING (contributor_id = auth.uid() AND status = 'pending')
    WITH CHECK (contributor_id = auth.uid() AND status = 'pending');

-- Rule 6: Only moderator or admin roles can update books.status or approve books
CREATE POLICY "Moderators and admins can update any book"
    ON public.books FOR UPDATE
    TO authenticated
    USING (public.is_admin_or_mod())
    WITH CHECK (public.is_admin_or_mod());

-- Rule 7: Moderators and admins can delete books
CREATE POLICY "Moderators and admins can delete books"
    ON public.books FOR DELETE
    TO authenticated
    USING (public.is_admin_or_mod());

-- 6.3 Chapters Policies
-- Read: View chapters if book is approved, owned by user, or user is admin/mod
CREATE POLICY "Anyone can view chapters of accessible books"
    ON public.chapters FOR SELECT
    USING (
        EXISTS (
            SELECT 1 FROM public.books
            WHERE public.books.id = public.chapters.book_id
              AND (
                  public.books.status = 'approved'
                  OR public.books.contributor_id = auth.uid()
                  OR public.is_admin_or_mod()
              )
        )
    );

-- Insert/Update/Delete chapters: Book contributor (if pending) or admin/mod
CREATE POLICY "Contributors or admins can manage chapters"
    ON public.chapters FOR ALL
    TO authenticated
    USING (
        EXISTS (
            SELECT 1 FROM public.books
            WHERE public.books.id = public.chapters.book_id
              AND (
                  (public.books.contributor_id = auth.uid() AND public.books.status = 'pending')
                  OR public.is_admin_or_mod()
              )
        )
    )
    WITH CHECK (
        EXISTS (
            SELECT 1 FROM public.books
            WHERE public.books.id = public.chapters.book_id
              AND (
                  (public.books.contributor_id = auth.uid() AND public.books.status = 'pending')
                  OR public.is_admin_or_mod()
              )
        )
    );

-- 6.4 Verses Policies
-- Read: View verses if parent chapter's book is accessible
CREATE POLICY "Anyone can view verses of accessible chapters"
    ON public.verses FOR SELECT
    USING (
        EXISTS (
            SELECT 1 FROM public.chapters
            JOIN public.books ON public.books.id = public.chapters.book_id
            WHERE public.chapters.id = public.verses.chapter_id
              AND (
                  public.books.status = 'approved'
                  OR public.books.contributor_id = auth.uid()
                  OR public.is_admin_or_mod()
              )
        )
    );

-- Insert/Update/Delete verses: Book contributor (if pending) or admin/mod
CREATE POLICY "Contributors or admins can manage verses"
    ON public.verses FOR ALL
    TO authenticated
    USING (
        EXISTS (
            SELECT 1 FROM public.chapters
            JOIN public.books ON public.books.id = public.chapters.book_id
            WHERE public.chapters.id = public.verses.chapter_id
              AND (
                  (public.books.contributor_id = auth.uid() AND public.books.status = 'pending')
                  OR public.is_admin_or_mod()
              )
        )
    )
    WITH CHECK (
        EXISTS (
            SELECT 1 FROM public.chapters
            JOIN public.books ON public.books.id = public.chapters.book_id
            WHERE public.chapters.id = public.verses.chapter_id
              AND (
                  (public.books.contributor_id = auth.uid() AND public.books.status = 'pending')
                  OR public.is_admin_or_mod()
              )
        )
    );

-- 6.5 Reading Progress Policies
CREATE POLICY "Users can view own reading progress"
    ON public.reading_progress FOR SELECT
    TO authenticated
    USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own reading progress"
    ON public.reading_progress FOR INSERT
    TO authenticated
    WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own reading progress"
    ON public.reading_progress FOR UPDATE
    TO authenticated
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can delete own reading progress"
    ON public.reading_progress FOR DELETE
    TO authenticated
    USING (auth.uid() = user_id);

-- 6.6 Bookmarks Policies
CREATE POLICY "Users can view own bookmarks"
    ON public.bookmarks FOR SELECT
    TO authenticated
    USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own bookmarks"
    ON public.bookmarks FOR INSERT
    TO authenticated
    WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own bookmarks"
    ON public.bookmarks FOR UPDATE
    TO authenticated
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can delete own bookmarks"
    ON public.bookmarks FOR DELETE
    TO authenticated
    USING (auth.uid() = user_id);

-- -----------------------------------------------------------------------------
-- 7. SUPABASE STORAGE BUCKETS & POLICIES
-- -----------------------------------------------------------------------------

-- Create storage buckets if storage schema exists
INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES 
    ('book_covers', 'book_covers', true, 5242880, ARRAY['image/jpeg', 'image/png', 'image/webp']),
    ('book_files', 'book_files', false, 52428800, ARRAY['application/pdf', 'application/epub+zip']),
    ('chapter_audio', 'chapter_audio', true, 52428800, ARRAY['audio/mpeg', 'audio/mp3', 'audio/m4a', 'audio/aac'])
ON CONFLICT (id) DO UPDATE SET
    public = EXCLUDED.public,
    file_size_limit = EXCLUDED.file_size_limit,
    allowed_mime_types = EXCLUDED.allowed_mime_types;

-- Storage RLS: book_covers (Public Read, Authenticated Upload)
CREATE POLICY "Public read for book covers"
    ON storage.objects FOR SELECT
    USING (bucket_id = 'book_covers');

CREATE POLICY "Authenticated users can upload book covers"
    ON storage.objects FOR INSERT
    TO authenticated
    WITH CHECK (bucket_id = 'book_covers');

CREATE POLICY "Admins and mods can delete book covers"
    ON storage.objects FOR DELETE
    TO authenticated
    USING (bucket_id = 'book_covers' AND public.is_admin_or_mod());

-- Storage RLS: book_files (Authenticated Upload, Read if user owns or book is approved)
CREATE POLICY "Authenticated users can upload book files"
    ON storage.objects FOR INSERT
    TO authenticated
    WITH CHECK (bucket_id = 'book_files');

CREATE POLICY "Public read for approved book files or owner"
    ON storage.objects FOR SELECT
    USING (
        bucket_id = 'book_files'
        AND (
            auth.role() = 'authenticated'
            OR EXISTS (
                SELECT 1 FROM public.books
                WHERE public.books.file_url LIKE '%' || storage.objects.name
                  AND public.books.status = 'approved'
            )
        )
    );

CREATE POLICY "Admins and mods can delete book files"
    ON storage.objects FOR DELETE
    TO authenticated
    USING (bucket_id = 'book_files' AND public.is_admin_or_mod());

-- Storage RLS: chapter_audio (Public Read, Authenticated Upload)
CREATE POLICY "Public read for chapter audio"
    ON storage.objects FOR SELECT
    USING (bucket_id = 'chapter_audio');

CREATE POLICY "Authenticated users can upload chapter audio"
    ON storage.objects FOR INSERT
    TO authenticated
    WITH CHECK (bucket_id = 'chapter_audio');

CREATE POLICY "Admins and mods can delete chapter audio"
    ON storage.objects FOR DELETE
    TO authenticated
    USING (bucket_id = 'chapter_audio' AND public.is_admin_or_mod());
