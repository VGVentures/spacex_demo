import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:mocktail/mocktail.dart';
import 'package:spacex_demo/crew/crew.dart';
import 'package:spacex_demo/home/widgets/home_page_content.dart';
import 'package:spacex_demo/home/widgets/spacex_tile.dart';
import 'package:spacex_demo/rockets/view/rockets_page.dart';

import '../../helpers/pump_app.dart';

void main() {
  group('HomePageContent', () {
    late MockNavigator navigator;

    setUp(() {
      navigator = MockNavigator();

      when(() => navigator.push(any(that: isRoute<RocketsPage?>())))
          .thenAnswer((_) async {});

      when(() => navigator.push(any(that: isRoute<CrewPage?>())))
          .thenAnswer((_) async {});
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
      await tester.pumpApp(const HomePageContent(), navigator: navigator);

      await tester.tap(find.byKey(
        const Key('homePageContent_rocketSpaceXTile'),
      ));

      verify(() => navigator.push(any(that: isRoute<RocketsPage?>())))
          .called(1);
    });

    testWidgets('homePageContent_crewSpaceXTile navigates to CrewPage on tap',
        (tester) async {
      await tester.pumpApp(const HomePageContent(), navigator: navigator);

      await tester.tap(find.byKey(
        const Key('homePageContent_crewSpaceXTile'),
      ));

      verify(() => navigator.push(any(that: isRoute<CrewPage?>()))).called(1);
    });
  });
}
