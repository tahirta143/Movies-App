
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/core/presentation/widgets/main_navigation.dart';
import 'package:myapp/features/home/presentation/screens/home_screen.dart';
import 'package:myapp/features/movie_details/presentation/screens/movie_detail_screen.dart';
import 'package:myapp/features/movie_details/presentation/screens/trailer_screen.dart';
import 'package:myapp/features/profile/presentation/screens/profile_screen.dart';
import 'package:myapp/features/search/presentation/screens/search_screen.dart';
import 'package:myapp/features/watchlist/presentation/screens/watchlist_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
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
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return MovieDetailScreen(movieId: id);
      },
    ),
    GoRoute(
      path: '/trailer/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return TrailerScreen(trailerId: id);
      },
    ),
  ],
);
