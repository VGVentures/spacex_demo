import 'package:bloc_test/bloc_test.dart';
import 'package:crew_member_repository/crew_member_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:spacex_api/spacex_api.dart';
import 'package:spacex_demo/crew/crew.dart';
import 'package:spacex_demo/crew_member_details/crew_member_details.dart';

import '../../helpers/helpers.dart';

class MockCrewMemberRepository extends Mock implements CrewMemberRepository {}

class MockCrewCubit extends MockCubit<CrewState> implements CrewCubit {}

void main() {
  final crewMembers = List.generate(
    3,
    (i) => CrewMember(
      id: '$i',
      name: 'Alejandro Ferrero $i',
      status: 'active',
      agency: 'Very Good Aliens',
      image:
          'https://media-exp1.licdn.com/dms/image/C4D03AQHVNIVOMkwQaA/profile-displayphoto-shrink_200_200/0/1631637257882?e=1637193600&v=beta&t=jFm-Ckb0KS0Z5hJDbo3ZBSEZSYLHfllUf4N-IV2NDTc',
      wikipedia: 'https://www.wikipedia.org/',
      launches: ['Launch $i'],
    ),
  );

  group('CrewPage', () {
    late CrewMemberRepository crewMemberRepository;

    setUp(() {
      crewMemberRepository = MockCrewMemberRepository();
      when(() => crewMemberRepository.fetchAllCrewMembers())
          .thenAnswer((_) async => crewMembers);
    });

    test(
      'has route',
      () => expect(
        CrewPage.route(),
        isA<MaterialPageRoute<void>>(),
      ),
    );

    testWidgets('renders CrewView', (tester) async {
      await tester.pumpApp(
        Navigator(
          onGenerateRoute: (_) => CrewPage.route(),
        ),
        crewMemberRepository: crewMemberRepository,
      );

      expect(find.byType(CrewPage), findsOneWidget);
    });
  });

  group('CrewView', () {
    late CrewCubit crewCubit;
    late MockNavigator navigator;

    setUp(() {
      crewCubit = MockCrewCubit();
      navigator = MockNavigator();

      when(() => navigator.push(any(that: isRoute<CrewMemberDetailsPage?>())))
          .thenAnswer((_) async {});
    });

    setUpAll(() {
      registerFallbackValue<CrewState>(const CrewState());
      registerFallbackValue<Uri>(Uri());
    });

    testWidgets('renders empty page when status is initial', (tester) async {
      const key = Key('crewView_initial_sizedBox');

      when(() => crewCubit.state).thenReturn(
        const CrewState(),
      );

      await tester.pumpApp(
        BlocProvider.value(
          value: crewCubit,
          child: const CrewView(),
        ),
      );

      expect(find.byKey(key), findsOneWidget);
    });

    testWidgets(
      'renders loading indicator when status is loading',
      (tester) async {
        const key = Key('crewView_loading_indicator');

        when(() => crewCubit.state).thenReturn(
          const CrewState(
            status: CrewStatus.loading,
          ),
        );

        await tester.pumpApp(
          BlocProvider.value(
            value: crewCubit,
            child: const CrewView(),
          ),
        );

        expect(find.byKey(key), findsOneWidget);
      },
    );

    testWidgets(
      'renders error text when status is failure',
      (tester) async {
        const key = Key('crewView_failure_text');

        when(() => crewCubit.state).thenReturn(
          const CrewState(
            status: CrewStatus.failure,
          ),
        );

        await tester.pumpApp(
          BlocProvider.value(
            value: crewCubit,
            child: const CrewView(),
          ),
        );

        expect(find.byKey(key), findsOneWidget);
      },
    );

    testWidgets(
      'renders list of crew members when status is success',
      (tester) async {
        const key = Key('crewView_success_crewMemberList');

        when(() => crewCubit.state).thenReturn(
          CrewState(
            status: CrewStatus.success,
            crewMembers: crewMembers,
          ),
        );

        await mockNetworkImages(() async {
          await tester.pumpApp(
            BlocProvider.value(
              value: crewCubit,
              child: const CrewView(),
            ),
          );
        });

        expect(find.byKey(key), findsOneWidget);
        expect(find.byType(ListTile), findsNWidgets(crewMembers.length));
      },
    );

    testWidgets(
      'navigates to CrewMemberDetailsPage when rocket is tapped',
      (tester) async {
        when(() => crewCubit.state).thenReturn(
          CrewState(
            status: CrewStatus.success,
            crewMembers: crewMembers,
          ),
        );

        await tester.pumpApp(
          BlocProvider.value(
            value: crewCubit,
            child: const CrewView(),
          ),
          navigator: navigator,
        );

        await tester.tap(find.text(crewMembers.first.name));

        verify(() =>
                navigator.push(any(that: isRoute<CrewMemberDetailsPage?>())))
            .called(1);
      },
    );
  });
}
