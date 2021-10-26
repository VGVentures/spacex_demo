import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:mocktail/mocktail.dart';
import 'package:spacex_demo/home/widgets/home_page_content.dart';
import 'package:spacex_demo/home/widgets/spacex_category_card.dart';

import '../../helpers/pump_app.dart';

void main() {
  group('HomePageContent', () {
    late MockNavigator navigator;

    setUp(() {
      navigator = MockNavigator();

      when(() => navigator.push(any(that: isRoute<void>())))
          .thenAnswer((_) async {});

      when(() => navigator.push(any(that: isRoute<void>())))
          .thenAnswer((_) async {});
    });

    testWidgets('number of SpaceXTile is correct', (tester) async {
      await tester.pumpApp(const HomePageContent());
      expect(find.byType(SpaceXCategoryCard), findsNWidgets(2));
    });

    testWidgets(
      'there is 1 homePageContent_rocket_spaceXCategoryCard',
      (tester) async {
        await tester.pumpApp(const HomePageContent());
        expect(
          find.byKey(const Key('homePageContent_rocket_spaceXCategoryCard')),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'there is 1 homePageContent_crew_spaceXCategoryCard',
      (tester) async {
        await tester.pumpApp(const HomePageContent());
        expect(
          find.byKey(const Key('homePageContent_crew_spaceXCategoryCard')),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'homePageContent_rocket_spaceXCategoryCard navigates '
      'to RocketsPage on tap',
      (tester) async {
        await tester.pumpApp(const HomePageContent(), navigator: navigator);

        await tester.tap(
          find.byKey(
            const Key('homePageContent_rocket_spaceXCategoryCard'),
          ),
        );

        verify(() => navigator.push(any(that: isRoute<void>()))).called(1);
      },
    );

    testWidgets(
      'homePageContent_crew_spaceXCategoryCard navigates '
      'to CrewPage on tap',
      (tester) async {
        await tester.pumpApp(
          const HomePageContent(),
          navigator: navigator,
        );

        await tester.tap(
          find.byKey(
            const Key('homePageContent_crew_spaceXCategoryCard'),
          ),
        );

        verify(() => navigator.push(any(that: isRoute<void>()))).called(1);
      },
    );
  });
}
