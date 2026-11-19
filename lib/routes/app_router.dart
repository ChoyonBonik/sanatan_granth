import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Presentation Pages
import '../features/auth/presentation/pages/login_page.dart';
import '../features/auth/presentation/pages/register_page.dart';
import '../features/auth/presentation/pages/profile_page.dart';
import '../features/library/presentation/pages/home_page.dart';
import '../features/library/presentation/pages/search_page.dart';
import '../features/library/presentation/pages/book_details_page.dart';
import '../features/reader/presentation/pages/structured_verse_reader_page.dart';
import '../features/reader/presentation/pages/pdf_document_reader_page.dart';
import '../features/contribute/presentation/pages/contribute_dashboard_page.dart';
import '../features/contribute/presentation/pages/upload_document_page.dart';
import '../features/contribute/presentation/pages/upload_csv_verses_page.dart';
import '../features/contribute/presentation/pages/contribution_status_tracker_page.dart';
import '../features/offline/presentation/pages/download_manager_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: <RouteBase>[
    // Main App Shell with Bottom Navigation Bar
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return ScaffoldWithNavBar(child: child);
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          name: 'home',
          builder: (BuildContext context, GoRouterState state) => const HomePage(),
        ),
        GoRoute(
          path: '/offline',
          name: 'offline',
          builder: (BuildContext context, GoRouterState state) =>
              const DownloadManagerPage(),
        ),
        GoRoute(
          path: '/contribute',
          name: 'contribute',
          builder: (BuildContext context, GoRouterState state) =>
              const ContributeDashboardPage(),
        ),
        GoRoute(
          path: '/profile',
          name: 'profile',
          builder: (BuildContext context, GoRouterState state) =>
              const ProfilePage(),
        ),
      ],
    ),

    // Library & Search Subroutes
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/search',
      name: 'search',
      builder: (BuildContext context, GoRouterState state) => const SearchPage(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/book/:id',
      name: 'book_details',
      builder: (BuildContext context, GoRouterState state) {
        final String bookId = state.pathParameters['id'] ?? 'gita-as-it-is';
        return BookDetailsPage(bookId: bookId);
      },
    ),

    // Readers
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/reader/structured/:bookId',
      name: 'structured_reader',
      builder: (BuildContext context, GoRouterState state) {
        final String bookId = state.pathParameters['bookId'] ?? 'gita-as-it-is';
        return StructuredVerseReaderPage(bookId: bookId);
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/reader/pdf/:documentId',
      name: 'pdf_reader',
      builder: (BuildContext context, GoRouterState state) {
        final String docId = state.pathParameters['documentId'] ?? 'valmiki-ramayana';
        return PdfDocumentReaderPage(documentId: docId);
      },
    ),

    // Contribute Subroutes
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/contribute/upload-document',
      name: 'upload_document',
      builder: (BuildContext context, GoRouterState state) =>
          const UploadDocumentPage(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/contribute/upload-csv',
      name: 'upload_csv',
      builder: (BuildContext context, GoRouterState state) =>
          const UploadCsvVersesPage(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/contribute/tracker',
      name: 'contribution_tracker',
      builder: (BuildContext context, GoRouterState state) =>
          const ContributionStatusTrackerPage(),
    ),

    // Auth Routes
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/login',
      name: 'login',
      builder: (BuildContext context, GoRouterState state) => const LoginPage(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/register',
      name: 'register',
      builder: (BuildContext context, GoRouterState state) =>
          const RegisterPage(),
    ),
  ],
);

class ScaffoldWithNavBar extends StatelessWidget {
  final Widget child;

  const ScaffoldWithNavBar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _calculateSelectedIndex(context),
        onDestinationSelected: (int idx) => _onItemTapped(idx, context),
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book_rounded),
            label: 'Library',
          ),
          NavigationDestination(
            icon: Icon(Icons.offline_pin_outlined),
            selectedIcon: Icon(Icons.offline_pin_rounded),
            label: 'Offline',
          ),
          NavigationDestination(
            icon: Icon(Icons.volunteer_activism_outlined),
            selectedIcon: Icon(Icons.volunteer_activism_rounded),
            label: 'Contribute',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/offline')) return 1;
    if (location.startsWith('/contribute')) return 2;
    if (location.startsWith('/profile')) return 3;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/offline');
        break;
      case 2:
        context.go('/contribute');
        break;
      case 3:
        context.go('/profile');
        break;
    }
  }
}
