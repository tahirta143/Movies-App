
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:myapp/main.dart';
import 'package:myapp/core/services/movie_service.dart';
import 'package:myapp/features/watchlist/presentation/screens/watchlist_screen.dart';
import 'package:provider/provider.dart';

import 'navigation_test.mocks.dart';

@GenerateNiceMocks([MockSpec<MovieService>()])
void main() {
  late MockMovieService mockMovieService;

  setUp(() {
    mockMovieService = MockMovieService();
  });

  testWidgets('Bottom navigation bar smoke test', (WidgetTester tester) async {
    // Provide the mock service to the widget tree.
    await tester.pumpWidget(
      Provider<MovieService>(
        create: (_) => mockMovieService,
        child: const MyApp(),
      ),
    );

    // Verify that the Home screen is displayed initially.
    expect(find.byIcon(Icons.home), findsOneWidget);

    // Tap the Search icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();

    // Verify that the Search screen is displayed.
    expect(find.byType(TextField), findsOneWidget);

    // Tap the Watchlist icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.bookmark));
    await tester.pumpAndSettle();

    // Verify that the Watchlist screen is displayed.
    expect(find.descendant(of: find.byType(WatchlistScreen), matching: find.text('Watchlist')), findsOneWidget);
  });
}
