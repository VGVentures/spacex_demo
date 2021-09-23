import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_navigator/mock_navigator.dart';
import 'package:mocktail/mocktail.dart';
import 'package:spacex_demo/home/widgets/home_page_content.dart';
import 'package:spacex_demo/home/widgets/spacex_tile.dart';
import 'package:spacex_demo/rockets/view/rockets_page.dart';

import '../../helpers/pump_app.dart';

class MockNavigator extends Mock
    with MockNavigatorDiagnosticsMixin
    implements MockNavigatorBase {}

class FakeRoute<T> extends Fake implements Route<T> {}

void main() {
  group('HomePageContent', () {
    late MockNavigator navigator;

    setUp(() {
      navigator = MockNavigator();

      when(() => navigator.push(RocketsPage.route()))
          .thenAnswer((_) async => null);

      // TODO: CHANGE ROUTE TO CREW PAGE
      when(() => navigator.push(any())).thenAnswer((_) async => null);
    });

    setUpAll(() {
      registerFallbackValue<Route<Object?>>(FakeRoute<Object?>());
    });

    testWidgets('number of SpaceXTile is correct', (tester) async {
      await tester.pumpApp(const HomePageContent());
      expect(find.byType(SpaceXTile), findsNWidgets(2));
    });

    testWidgets('there is 1 homePageContent_rocketSpaceXTile', (tester) async {
      await tester.pumpApp(const HomePageContent());
      expect(
        find.byKey(const Key('homePageContent_rocketSpaceXTile')),
        findsOneWidget,
      );
    });

    testWidgets('there is 1 homePageContent_crewSpaceXTile', (tester) async {
      await tester.pumpApp(const HomePageContent());
      expect(
        find.byKey(const Key('homePageContent_crewSpaceXTile')),
        findsOneWidget,
      );
    });

    testWidgets(
        'homePageContent_rocketSpaceXTile navigates to RocketsPage on tap',
        (tester) async {
      await tester.pumpApp(
        MockNavigatorProvider(
          navigator: navigator,
          child: const HomePageContent(),
        ),
      );

      await tester
          .tap(find.byKey(const Key('homePageContent_rocketSpaceXTile')));

      verify(() => navigator.push(any())).called(1);
    });
  });
}
