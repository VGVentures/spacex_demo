import 'package:crew_member_repository/crew_member_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:rocket_repository/rocket_repository.dart';
import 'package:spacex_demo/l10n/l10n.dart';

class MockRocketRepository extends Mock implements RocketRepository {}

class MockCrewMemberRepository extends Mock implements CrewMemberRepository {}

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    MockNavigator? navigator,
    RocketRepository? rocketRepository,
    CrewMemberRepository? crewMemberRepository,
  }) {
    final innerChild = Scaffold(
      body: widget,
    );

    return pumpWidget(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(
            value: rocketRepository ?? MockRocketRepository(),
          ),
          RepositoryProvider.value(
            value: crewMemberRepository ?? MockCrewMemberRepository(),
          )
        ],
        child: MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: navigator == null
              ? innerChild
              : MockNavigatorProvider(
                  navigator: navigator,
                  child: innerChild,
                ),
        ),
      ),
    );
  }
}
