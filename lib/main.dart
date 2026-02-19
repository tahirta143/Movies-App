
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/core/services/movie_service.dart';
import 'package:myapp/core/theme/app_theme.dart';
import 'package:provider/provider.dart';

import 'package:myapp/core/presentation/widgets/main_navigation.dart';
import 'package:myapp/features/home/presentation/screens/home_screen.dart';
import 'package:myapp/features/movie_details/presentation/screens/movie_detail_screen.dart';
import 'package:myapp/features/movie_details/presentation/screens/trailer_screen.dart';
import 'package:myapp/features/profile/presentation/screens/profile_screen.dart';
import 'package:myapp/features/search/presentation/screens/search_screen.dart';
import 'package:myapp/features/watchlist/presentation/screens/watchlist_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(
    Provider<MovieService>(
      create: (_) => MovieService(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Movie App',
      theme: AppTheme.darkTheme,
      routerConfig: _router,
    );
  }
}

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return MainNavigation(child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/search',
          builder: (context, state) => const SearchScreen(),
        ),
        GoRoute(
          path: '/watchlist',
          builder: (context, state) => const WatchlistScreen(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/movie/:id',
      builder: (context, state) =>
          MovieDetailScreen(movieId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/trailer/:key',
      builder: (context, state) =>
          TrailerScreen(trailerId: state.pathParameters['key']!),
    ),
  ],
);
