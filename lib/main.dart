
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:myapp/core/theme/app_theme.dart';
import 'package:myapp/core/presentation/widgets/main_navigation.dart';
import 'package:myapp/features/search/presentation/screens/search_screen.dart';
import 'package:myapp/features/watchlist/presentation/screens/watchlist_screen.dart';
import 'package:myapp/features/profile/presentation/screens/profile_screen.dart';
import 'package:myapp/features/home/presentation/screens/home_screen.dart';
import 'package:myapp/features/movie_details/presentation/screens/movie_detail_screen.dart';
import 'package:myapp/features/movie_details/presentation/screens/trailer_screen.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const CineVerseApp(),
    ),
  );
}

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const MainNavigation();
      },
      routes: [
        GoRoute(
          path: 'search',
          builder: (context, state) => const SearchScreen(),
        ),
        GoRoute(
          path: 'watchlist',
          builder: (context, state) => const WatchlistScreen(),
        ),
        GoRoute(
          path: 'profile',
          builder: (context, state) => const ProfileScreen(),
        ),
        GoRoute(
          path: 'movie/:id',
          builder: (context, state) => MovieDetailScreen(movieId: state.pathParameters['id']!),
          routes: [
            GoRoute(
              path: 'trailer/:trailerId',
              builder: (context, state) => TrailerScreen(trailerId: state.pathParameters['trailerId']!),
            ),
          ]
        ),
      ]
    ),
  ],
);

class CineVerseApp extends StatelessWidget {
  const CineVerseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp.router(
          title: 'CineVerse',
          theme: AppTheme.darkTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.themeMode,
          routerConfig: _router,
        );
      },
    );
  }
}
